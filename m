From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/14] sound: Move dereference after NULL test and drop
 unnecessary NULL tests
Date: Sat, 17 Oct 2009 08:33:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0910170832570.9213@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751446AbZJQGdW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

In pcm.c, if the NULL test on pcm is needed, then the dereference should be
after the NULL test.

In dummy.c and ali5451.c, the context of the calls to
snd_card_dummy_new_mixer and snd_ali_free_voice show that dummy and pvoice,
respectively cannot be NULL.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/core/pcm.c            |    5 +++--
 sound/drivers/dummy.c       |    2 --
 sound/pci/ali5451/ali5451.c |    2 +-

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 0c14401..c69c60b 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -953,11 +953,12 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_notify *notify;
 	char str[16];
-	struct snd_pcm *pcm = device->device_data;
+	struct snd_pcm *pcm;
 	struct device *dev;
 
-	if (snd_BUG_ON(!pcm || !device))
+	if (snd_BUG_ON(!device || !device->device_data))
 		return -ENXIO;
+	pcm = device->device_data;
 	mutex_lock(&register_mutex);
 	err = snd_pcm_add(pcm);
 	if (err) {
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 6ba066c..146ef00 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -808,8 +808,6 @@ static int __devinit snd_card_dummy_new_mixer(struct snd_dummy *dummy)
 	unsigned int idx;
 	int err;
 
-	if (snd_BUG_ON(!dummy))
-		return -EINVAL;
 	spin_lock_init(&dummy->mixer_lock);
 	strcpy(card->mixername, "Dummy Mixer");
 
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index b458d20..aaf4da6 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -973,7 +973,7 @@ static void snd_ali_free_voice(struct snd_ali * codec,
 	void *private_data;
 
 	snd_ali_printk("free_voice: channel=%d\n",pvoice->number);
-	if (pvoice == NULL || !pvoice->use)
+	if (!pvoice->use)
 		return;
 	snd_ali_clear_voices(codec, pvoice->number, pvoice->number);
 	spin_lock_irq(&codec->voice_alloc);
