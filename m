From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/48] ALSA: ac97: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:27 +0100
Message-ID: <1393430030-26704-26-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 214602657AF
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C91C275038
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_codec.c | 45 +++++++++++++++++++++++++++++++++------------
 sound/pci/ac97/ac97_patch.c |  3 ++-
 sound/pci/ac97/ac97_pcm.c   | 15 +++++++++++----
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index bf578ba2677e..14ad54b7928c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -214,6 +214,12 @@ static void update_power_regs(struct snd_ac97 *ac97);
 #define ac97_is_power_save_mode(ac97) 0
 #endif
 
+#define ac97_err(ac97, fmt, args...)	\
+	dev_err((ac97)->bus->card->dev, fmt, ##args)
+#define ac97_warn(ac97, fmt, args...)	\
+	dev_warn((ac97)->bus->card->dev, fmt, ##args)
+#define ac97_dbg(ac97, fmt, args...)	\
+	dev_dbg((ac97)->bus->card->dev, fmt, ##args)
 
 /*
  *  I/O routines
@@ -1673,7 +1679,7 @@ static int snd_ac97_modem_build(struct snd_card *card, struct snd_ac97 * ac97)
 	int err, idx;
 
 	/*
-	printk(KERN_DEBUG "AC97_GPIO_CFG = %x\n",
+	ac97_dbg(ac97, "AC97_GPIO_CFG = %x\n",
 	       snd_ac97_read(ac97,AC97_GPIO_CFG));
 	*/
 	snd_ac97_write(ac97, AC97_GPIO_CFG, 0xffff & ~(AC97_GPIO_LINE1_OH));
@@ -1963,7 +1969,7 @@ static int snd_ac97_dev_register(struct snd_device *device)
 		     ac97->bus->card->number, ac97->num,
 		     snd_ac97_get_short_name(ac97));
 	if ((err = device_register(&ac97->dev)) < 0) {
-		snd_printk(KERN_ERR "Can't register ac97 bus\n");
+		ac97_err(ac97, "Can't register ac97 bus\n");
 		ac97->dev.bus = NULL;
 		return err;
 	}
@@ -2089,7 +2095,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 						      msecs_to_jiffies(500), 1);
 		}
 		if (err < 0) {
-			snd_printk(KERN_WARNING "AC'97 %d does not respond - RESET\n", ac97->num);
+			ac97_warn(ac97, "AC'97 %d does not respond - RESET\n",
+				 ac97->num);
 			/* proceed anyway - it's often non-critical */
 		}
 	}
@@ -2098,7 +2105,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 	ac97->id |= snd_ac97_read(ac97, AC97_VENDOR_ID2);
 	if (! (ac97->scaps & AC97_SCAP_DETECT_BY_VENDOR) &&
 	    (ac97->id == 0x00000000 || ac97->id == 0xffffffff)) {
-		snd_printk(KERN_ERR "AC'97 %d access is not valid [0x%x], removing mixer.\n", ac97->num, ac97->id);
+		ac97_err(ac97,
+			 "AC'97 %d access is not valid [0x%x], removing mixer.\n",
+			 ac97->num, ac97->id);
 		snd_ac97_free(ac97);
 		return -EIO;
 	}
@@ -2131,7 +2140,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 
 	if (!ac97_is_audio(ac97) && !ac97_is_modem(ac97)) {
 		if (!(ac97->scaps & (AC97_SCAP_SKIP_AUDIO|AC97_SCAP_SKIP_MODEM)))
-			snd_printk(KERN_ERR "AC'97 %d access error (not audio or modem codec)\n", ac97->num);
+			ac97_err(ac97,
+				 "AC'97 %d access error (not audio or modem codec)\n",
+				 ac97->num);
 		snd_ac97_free(ac97);
 		return -EACCES;
 	}
@@ -2156,7 +2167,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 				goto __ready_ok;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		snd_printk(KERN_WARNING "AC'97 %d analog subsections not ready\n", ac97->num);
+		ac97_warn(ac97,
+			  "AC'97 %d analog subsections not ready\n", ac97->num);
 	}
 
 	/* FIXME: add powerdown control */
@@ -2188,7 +2200,10 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 				goto __ready_ok;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		snd_printk(KERN_WARNING "MC'97 %d converters and GPIO not ready (0x%x)\n", ac97->num, snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS));
+		ac97_warn(ac97,
+			  "MC'97 %d converters and GPIO not ready (0x%x)\n",
+			  ac97->num,
+			  snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS));
 	}
 	
       __ready_ok:
@@ -2723,7 +2738,7 @@ static int tune_ad_sharing(struct snd_ac97 *ac97)
 {
 	unsigned short scfg;
 	if ((ac97->id & 0xffffff00) != 0x41445300) {
-		snd_printk(KERN_ERR "ac97_quirk AD_SHARING is only for AD codecs\n");
+		ac97_err(ac97, "ac97_quirk AD_SHARING is only for AD codecs\n");
 		return -EINVAL;
 	}
 	/* Turn on OMS bit to route microphone to back panel */
@@ -2739,7 +2754,8 @@ AC97_SINGLE("Jack Detect", AC97_ALC650_CLOCK, 5, 1, 0);
 static int tune_alc_jack(struct snd_ac97 *ac97)
 {
 	if ((ac97->id & 0xffffff00) != 0x414c4700) {
-		snd_printk(KERN_ERR "ac97_quirk ALC_JACK is only for Realtek codecs\n");
+		ac97_err(ac97,
+			 "ac97_quirk ALC_JACK is only for Realtek codecs\n");
 		return -EINVAL;
 	}
 	snd_ac97_update_bits(ac97, 0x7a, 0x20, 0x20); /* select jack detect function */
@@ -2899,7 +2915,8 @@ int snd_ac97_tune_hardware(struct snd_ac97 *ac97, struct ac97_quirk *quirk, cons
 	if (override && strcmp(override, "-1") && strcmp(override, "default")) {
 		result = apply_quirk_str(ac97, override);
 		if (result < 0)
-			snd_printk(KERN_ERR "applying quirk type %s failed (%d)\n", override, result);
+			ac97_err(ac97, "applying quirk type %s failed (%d)\n",
+				 override, result);
 		return result;
 	}
 
@@ -2913,10 +2930,14 @@ int snd_ac97_tune_hardware(struct snd_ac97 *ac97, struct ac97_quirk *quirk, cons
 		    quirk->subdevice == (quirk->mask & ac97->subsystem_device)) {
 			if (quirk->codec_id && quirk->codec_id != ac97->id)
 				continue;
-			snd_printdd("ac97 quirk for %s (%04x:%04x)\n", quirk->name, ac97->subsystem_vendor, ac97->subsystem_device);
+			ac97_dbg(ac97, "ac97 quirk for %s (%04x:%04x)\n",
+				 quirk->name, ac97->subsystem_vendor,
+				 ac97->subsystem_device);
 			result = apply_quirk(ac97, quirk->type);
 			if (result < 0)
-				snd_printk(KERN_ERR "applying quirk type %d for %s failed (%d)\n", quirk->type, quirk->name, result);
+				ac97_err(ac97,
+					 "applying quirk type %d for %s failed (%d)\n",
+					 quirk->type, quirk->name, result);
 			return result;
 		}
 	}
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 66a3bc95fb84..991762215417 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3477,7 +3477,8 @@ static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
 
 		sctl = snd_ac97_find_mixer_ctl(ac97, *s);
 		if (!sctl) {
-			snd_printdd("Cannot find slave %s, skipped\n", *s);
+			dev_dbg(ac97->bus->card->dev,
+				"Cannot find slave %s, skipped\n", *s);
 			continue;
 		}
 		err = snd_ctl_add_slave(kctl, sctl);
diff --git a/sound/pci/ac97/ac97_pcm.c b/sound/pci/ac97/ac97_pcm.c
index eab0fc9ff2e0..d15297a68801 100644
--- a/sound/pci/ac97/ac97_pcm.c
+++ b/sound/pci/ac97/ac97_pcm.c
@@ -604,7 +604,9 @@ int snd_ac97_pcm_open(struct ac97_pcm *pcm, unsigned int rate,
 		}
 		if (!ok_flag) {
 			spin_unlock_irq(&pcm->bus->bus_lock);
-			snd_printk(KERN_ERR "cannot find configuration for AC97 slot %i\n", i);
+			dev_err(bus->card->dev,
+				"cannot find configuration for AC97 slot %i\n",
+				i);
 			err = -EAGAIN;
 			goto error;
 		}
@@ -618,15 +620,20 @@ int snd_ac97_pcm_open(struct ac97_pcm *pcm, unsigned int rate,
 			if (pcm->r[r].rslots[cidx] & (1 << i)) {
 				reg = get_slot_reg(pcm, cidx, i, r);
 				if (reg == 0xff) {
-					snd_printk(KERN_ERR "invalid AC97 slot %i?\n", i);
+					dev_err(bus->card->dev,
+						"invalid AC97 slot %i?\n", i);
 					continue;
 				}
 				if (reg_ok[cidx] & (1 << (reg - AC97_PCM_FRONT_DAC_RATE)))
 					continue;
-				//printk(KERN_DEBUG "setting ac97 reg 0x%x to rate %d\n", reg, rate);
+				dev_dbg(bus->card->dev,
+					"setting ac97 reg 0x%x to rate %d\n",
+					reg, rate);
 				err = snd_ac97_set_rate(pcm->r[r].codec[cidx], reg, rate);
 				if (err < 0)
-					snd_printk(KERN_ERR "error in snd_ac97_set_rate: cidx=%d, reg=0x%x, rate=%d, err=%d\n", cidx, reg, rate, err);
+					dev_err(bus->card->dev,
+						"error in snd_ac97_set_rate: cidx=%d, reg=0x%x, rate=%d, err=%d\n",
+						cidx, reg, rate, err);
 				else
 					reg_ok[cidx] |= (1 << (reg - AC97_PCM_FRONT_DAC_RATE));
 			}
-- 
1.9.0
