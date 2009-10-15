From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 02/11] hda - vectorize get_empty_pcm_device()
Date: Thu, 15 Oct 2009 15:03:50 +0800
Message-ID: <20091015070918.058861201@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B35B103926
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:14 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-dev-array.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

This unifies the code and data structure,
and makes it easy to add more HDMI devices.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c |   49 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c	2009-10-15 10:16:52.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.c	2009-10-15 10:17:00.000000000 +0800
@@ -2885,43 +2885,26 @@ static int get_empty_pcm_device(struct h
 	static const char *dev_name[HDA_PCM_NTYPES] = {
 		"Audio", "SPDIF", "HDMI", "Modem"
 	};
-	/* starting device index for each PCM type */
-	static int dev_idx[HDA_PCM_NTYPES] = {
-		[HDA_PCM_TYPE_AUDIO] = 0,
-		[HDA_PCM_TYPE_SPDIF] = 1,
-		[HDA_PCM_TYPE_HDMI] = 3,
-		[HDA_PCM_TYPE_MODEM] = 6
+	/* audio device indices; not linear to keep compatibility */
+	static int audio_idx[HDA_PCM_NTYPES][5] = {
+		[HDA_PCM_TYPE_AUDIO] = { 0, 2, 4, 5, -1 },
+		[HDA_PCM_TYPE_SPDIF] = { 1, -1 },
+		[HDA_PCM_TYPE_HDMI]  = { 3, -1 },
+		[HDA_PCM_TYPE_MODEM] = { 6, -1 },
 	};
-	/* normal audio device indices; not linear to keep compatibility */
-	static int audio_idx[4] = { 0, 2, 4, 5 };
-	int i, dev;
-
-	switch (type) {
-	case HDA_PCM_TYPE_AUDIO:
-		for (i = 0; i < ARRAY_SIZE(audio_idx); i++) {
-			dev = audio_idx[i];
-			if (!test_bit(dev, bus->pcm_dev_bits))
-				goto ok;
-		}
-		snd_printk(KERN_WARNING "Too many audio devices\n");
-		return -EAGAIN;
-	case HDA_PCM_TYPE_SPDIF:
-	case HDA_PCM_TYPE_HDMI:
-	case HDA_PCM_TYPE_MODEM:
-		dev = dev_idx[type];
-		if (test_bit(dev, bus->pcm_dev_bits)) {
-			snd_printk(KERN_WARNING "%s already defined\n",
-				   dev_name[type]);
-			return -EAGAIN;
-		}
-		break;
-	default:
+	int i;
+
+	if (type >= HDA_PCM_NTYPES) {
 		snd_printk(KERN_WARNING "Invalid PCM type %d\n", type);
 		return -EINVAL;
 	}
- ok:
-	set_bit(dev, bus->pcm_dev_bits);
-	return dev;
+
+	for (i = 0; audio_idx[type][i] >= 0 ; i++)
+		if (!test_and_set_bit(audio_idx[type][i], bus->pcm_dev_bits))
+			return audio_idx[type][i];
+
+	snd_printk(KERN_WARNING "Too many %s devices\n", dev_name[type]);
+	return -EAGAIN;
 }
 
 /*
