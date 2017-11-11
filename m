From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: rawmidi: Adjust seven function calls
 together with a variable assignment
Date: Sat, 11 Nov 2017 12:11:14 +0100
Message-ID: <11ba4e92-d71a-b8a9-08ff-b2d26a4ba606@users.sourceforge.net>
References: <d4c89bda-5091-2d3c-ded1-ba2c3b061ff6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 065682670C1
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 12:11:20 +0100 (CET)
In-Reply-To: <d4c89bda-5091-2d3c-ded1-ba2c3b061ff6@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Fabian Frederick <fabf@skynet.be>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 11:22:28 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/rawmidi.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index b3b353d72527..c17f173150e9 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -109,9 +109,10 @@ static void snd_rawmidi_input_event_work(struct work_struct *work)
 
 static int snd_rawmidi_runtime_create(struct snd_rawmidi_substream *substream)
 {
-	struct snd_rawmidi_runtime *runtime;
+	struct snd_rawmidi_runtime *runtime = kzalloc(sizeof(*runtime),
+						      GFP_KERNEL);
 
-	if ((runtime = kzalloc(sizeof(*runtime), GFP_KERNEL)) == NULL)
+	if (!runtime)
 		return -ENOMEM;
 	runtime->substream = substream;
 	spin_lock_init(&runtime->lock);
@@ -124,7 +125,9 @@ static int snd_rawmidi_runtime_create(struct snd_rawmidi_substream *substream)
 		runtime->avail = 0;
 	else
 		runtime->avail = runtime->buffer_size;
-	if ((runtime->buffer = kmalloc(runtime->buffer_size, GFP_KERNEL)) == NULL) {
+
+	runtime->buffer = kmalloc(runtime->buffer_size, GFP_KERNEL);
+	if (!runtime->buffer) {
 		kfree(runtime);
 		return -ENOMEM;
 	}
@@ -571,8 +574,9 @@ static int snd_rawmidi_info_user(struct snd_rawmidi_substream *substream,
 				 struct snd_rawmidi_info __user * _info)
 {
 	struct snd_rawmidi_info info;
-	int err;
-	if ((err = snd_rawmidi_info(substream, &info)) < 0)
+	int err = snd_rawmidi_info(substream, &info);
+
+	if (err < 0)
 		return err;
 	if (copy_to_user(_info, &info, sizeof(struct snd_rawmidi_info)))
 		return -EFAULT;
@@ -616,7 +620,8 @@ static int snd_rawmidi_info_select_user(struct snd_card *card,
 		return -EFAULT;
 	if (get_user(info.subdevice, &_info->subdevice))
 		return -EFAULT;
-	if ((err = snd_rawmidi_info_select(card, &info)) < 0)
+	err = snd_rawmidi_info_select(card, &info);
+	if (err < 0)
 		return err;
 	if (copy_to_user(_info, &info, sizeof(struct snd_rawmidi_info)))
 		return -EFAULT;
@@ -1549,21 +1554,30 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 	rmidi->dev.release = release_rawmidi_device;
 	dev_set_name(&rmidi->dev, "midiC%iD%i", card->number, device);
 
-	if ((err = snd_rawmidi_alloc_substreams(rmidi,
-						&rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT],
-						SNDRV_RAWMIDI_STREAM_INPUT,
-						input_count)) < 0) {
+	err =
+	    snd_rawmidi_alloc_substreams(rmidi,
+					 &rmidi
+					 ->streams[SNDRV_RAWMIDI_STREAM_INPUT],
+					 SNDRV_RAWMIDI_STREAM_INPUT,
+					 input_count);
+	if (err < 0) {
 		snd_rawmidi_free(rmidi);
 		return err;
 	}
-	if ((err = snd_rawmidi_alloc_substreams(rmidi,
-						&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT],
-						SNDRV_RAWMIDI_STREAM_OUTPUT,
-						output_count)) < 0) {
+
+	err =
+	    snd_rawmidi_alloc_substreams(rmidi,
+					 &rmidi
+					 ->streams[SNDRV_RAWMIDI_STREAM_OUTPUT],
+					 SNDRV_RAWMIDI_STREAM_OUTPUT,
+					 output_count);
+	if (err < 0) {
 		snd_rawmidi_free(rmidi);
 		return err;
 	}
-	if ((err = snd_device_new(card, SNDRV_DEV_RAWMIDI, rmidi, &ops)) < 0) {
+
+	err = snd_device_new(card, SNDRV_DEV_RAWMIDI, rmidi, &ops);
+	if (err < 0) {
 		snd_rawmidi_free(rmidi);
 		return err;
 	}
-- 
2.15.0
