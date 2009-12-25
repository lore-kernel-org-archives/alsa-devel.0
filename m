From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda - HDMI sticky stream tag support
Date: Fri, 25 Dec 2009 13:14:27 +0800
Message-ID: <20091225051427.GA7347@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C0891037E3
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 06:14:31 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When we run the following commands in turn (with
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0),

	speaker-test -Dhw:0,3 -c2 -twav  # HDMI
	speaker-test -Dhw:0,0 -c2 -twav  # Analog

The second command will produce sound in the analog lineout _as well as_
HDMI sink. The root cause is, device 0 "reuses" the same stream tag that
was used by device 3, and the "intelhdmi - sticky stream id" patch leaves
the HDMI codec in a functional state. So the HDMI codec happily accepts
the audio samples which reuse its stream tag.

The proposed solution is to remember the last device each azx_dev was
assigned to, and prefer to
1) reuse the azx_dev (and hence the stream tag) the HDMI codec last used
2) or assign a never-used azx_dev for HDMI

With this patch and the above two speaker-test commands, 
HDMI codec will use stream tag 8 and Analog codec will use 5.

The stream tag used by HDMI codec won't be reused by others, as long
as we don't run out of the 4 playback azx_dev's. The legacy Analog
codec will continue to use stream tag 5 because its device id is 0
(this is a bit tricky).

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c	2009-12-25 12:17:28.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_intel.c	2009-12-25 12:41:02.000000000 +0800
@@ -356,6 +356,7 @@ struct azx_dev {
 					 */
 	unsigned char stream_tag;	/* assigned stream */
 	unsigned char index;		/* stream index */
+	int device;			/* last device number assigned to */
 
 	unsigned int opened :1;
 	unsigned int running :1;
@@ -1441,10 +1442,13 @@ static int __devinit azx_codec_configure
  */
 
 /* assign a stream for the PCM */
-static inline struct azx_dev *azx_assign_device(struct azx *chip, int stream)
+static inline struct azx_dev *
+azx_assign_device(struct azx *chip, struct snd_pcm_substream *substream)
 {
 	int dev, i, nums;
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	struct azx_dev *res = NULL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dev = chip->playback_index_offset;
 		nums = chip->playback_streams;
 	} else {
@@ -1453,10 +1457,15 @@ static inline struct azx_dev *azx_assign
 	}
 	for (i = 0; i < nums; i++, dev++)
 		if (!chip->azx_dev[dev].opened) {
-			chip->azx_dev[dev].opened = 1;
-			return &chip->azx_dev[dev];
+			res = &chip->azx_dev[dev];
+			if (res->device == substream->pcm->device)
+				break;
 		}
-	return NULL;
+	if (res) {
+		res->opened = 1;
+		res->device = substream->pcm->device;
+	}
+	return res;
 }
 
 /* release the assigned stream */
@@ -1505,7 +1514,7 @@ static int azx_pcm_open(struct snd_pcm_s
 	int err;
 
 	mutex_lock(&chip->open_mutex);
-	azx_dev = azx_assign_device(chip, substream->stream);
+	azx_dev = azx_assign_device(chip, substream);
 	if (azx_dev == NULL) {
 		mutex_unlock(&chip->open_mutex);
 		return -EBUSY;
