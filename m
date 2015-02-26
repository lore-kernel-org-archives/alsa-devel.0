From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: hda - Replace bus pm_notify with
	the standard runtime PM framework
Date: Thu, 26 Feb 2015 18:00:21 +0100
Message-ID: <1424970025-8082-7-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE16264F10
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7AB41ADD1
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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

Now the final bit of runtime PM cleanup: instead of manual
notification of the power up/down of the codec via hda_bus pm_notify
ops, use the standard runtime PM feature.

The child codec device will kick off the runtime PM of the parent
(PCI) device upon suspend/resume automatically.  For managing whether
the link can be really turned off, we use the bit flags
bus->codec_powered instead of the earlier bus->power_keep_link_on.
flag.  Each codec driver is responsible to set/clear the bit flag, and
the controller device can be turned off only when all these bits are
cleared.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 33 ++++++++-------------------------
 sound/pci/hda/hda_codec.h      |  7 +------
 sound/pci/hda/hda_controller.c | 19 -------------------
 sound/pci/hda/hda_intel.c      |  5 ++---
 sound/pci/hda/patch_sigmatel.c |  4 +++-
 5 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 36cebe0e76b2..33b8b71f8eaf 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -46,23 +46,9 @@
 #define codec_in_pm(codec)	atomic_read(&(codec)->in_pm)
 #define hda_codec_is_power_on(codec) \
 	(!pm_runtime_suspended(hda_codec_dev(codec)))
-
-static void hda_call_pm_notify(struct hda_codec *codec, bool power_up)
-{
-	struct hda_bus *bus = codec->bus;
-
-	if ((power_up && codec->pm_up_notified) ||
-	    (!power_up && !codec->pm_up_notified))
-		return;
-	if (bus->ops.pm_notify)
-		bus->ops.pm_notify(bus, power_up);
-	codec->pm_up_notified = power_up;
-}
-
 #else
 #define codec_in_pm(codec)	0
 #define hda_codec_is_power_on(codec)	1
-#define hda_call_pm_notify(codec, state) {}
 #endif
 
 /**
@@ -1152,7 +1138,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	snd_array_free(&codec->spdif_out);
 	remove_conn_list(codec);
 	codec->bus->caddr_tbl[codec->addr] = NULL;
-	hda_call_pm_notify(codec, false); /* cancel leftover refcounts */
+	clear_bit(codec->addr, &codec->bus->codec_powered);
 	snd_hda_sysfs_clear(codec);
 	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
@@ -1277,10 +1263,10 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	 * the caller has to power down appropriatley after initialization
 	 * phase.
 	 */
+	set_bit(codec->addr, &bus->codec_powered);
 	pm_runtime_set_active(hda_codec_dev(codec));
 	pm_runtime_get_noresume(hda_codec_dev(codec));
 	codec->power_jiffies = jiffies;
-	hda_call_pm_notify(codec, true);
 #endif
 
 	snd_hda_sysfs_init(codec);
@@ -1340,11 +1326,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
 #endif
 	codec->epss = snd_hda_codec_get_supported_ps(codec, fg,
 					AC_PWRST_EPSS);
-#ifdef CONFIG_PM
-	if (!codec->d3_stop_clk || !codec->epss)
-		bus->power_keep_link_on = 1;
-#endif
-
 
 	/* power-up all before initialization */
 	hda_set_power_state(codec, AC_PWRST_D0);
@@ -3954,7 +3935,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	hda_mark_cmd_cache_dirty(codec);
 
 	codec->power_jiffies = jiffies;
-	hda_call_pm_notify(codec, true);
 
 	hda_set_power_state(codec, AC_PWRST_D0);
 	restore_shutup_pins(codec);
@@ -3986,14 +3966,17 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	for (i = 0; i < codec->num_pcms; i++)
 		snd_pcm_suspend_all(codec->pcm_info[i].pcm);
 	state = hda_call_codec_suspend(codec);
-	if (!codec->bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK))
-		hda_call_pm_notify(codec, false);
+	if (codec->d3_stop_clk && codec->epss && (state & AC_PWRST_CLK_STOP_OK))
+		clear_bit(codec->addr, &codec->bus->codec_powered);
 	return 0;
 }
 
 static int hda_codec_runtime_resume(struct device *dev)
 {
-	hda_call_codec_resume(dev_to_hda_codec(dev));
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	set_bit(codec->addr, &codec->bus->codec_powered);
+	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 89908f5b9601..457fc589eb46 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -83,10 +83,6 @@ struct hda_bus_ops {
 			  struct hda_pcm *pcm);
 	/* reset bus for retry verb */
 	void (*bus_reset)(struct hda_bus *bus);
-#ifdef CONFIG_PM
-	/* notify power-up/down from codec to controller */
-	void (*pm_notify)(struct hda_bus *bus, bool power_up);
-#endif
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	/* prepare DSP transfer */
 	int (*load_dsp_prepare)(struct hda_bus *bus, unsigned int format,
@@ -150,10 +146,10 @@ struct hda_bus {
 	unsigned int rirb_error:1;	/* error in codec communication */
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
-	unsigned int power_keep_link_on:1; /* don't power off HDA link */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
+	unsigned long codec_powered;	/* bit flags of powered codecs */
 };
 
 /*
@@ -372,7 +368,6 @@ struct hda_codec {
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 #ifdef CONFIG_PM
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
-	unsigned int pm_up_notified:1;	/* PM notified to controller */
 	atomic_t in_pm;		/* suspend/resume being performed */
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index cfe2c55296b6..789ca66c3094 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1785,22 +1785,6 @@ static void azx_bus_reset(struct hda_bus *bus)
 	bus->in_reset = 0;
 }
 
-#ifdef CONFIG_PM
-/* power-up/down the controller */
-static void azx_power_notify(struct hda_bus *bus, bool power_up)
-{
-	struct azx *chip = bus->private_data;
-
-	if (!azx_has_pm_runtime(chip))
-		return;
-
-	if (power_up)
-		pm_runtime_get_sync(chip->card->dev);
-	else
-		pm_runtime_put_sync(chip->card->dev);
-}
-#endif
-
 static int get_jackpoll_interval(struct azx *chip)
 {
 	int i;
@@ -1827,9 +1811,6 @@ static struct hda_bus_ops bus_ops = {
 	.get_response = azx_get_response,
 	.attach_pcm = azx_attach_pcm_stream,
 	.bus_reset = azx_bus_reset,
-#ifdef CONFIG_PM
-	.pm_notify = azx_power_notify,
-#endif
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	.load_dsp_prepare = azx_load_dsp_prepare,
 	.load_dsp_trigger = azx_load_dsp_trigger,
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 40540048b002..738d332351d5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -918,7 +918,8 @@ static int azx_runtime_idle(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (!power_save_controller || !azx_has_pm_runtime(chip))
+	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
+	    chip->bus->codec_powered)
 		return -EBUSY;
 
 	return 0;
@@ -1084,7 +1085,6 @@ static int azx_free(struct azx *chip)
 		azx_stop_chip(chip);
 	}
 
-	pci->dev.power.ignore_children = 0; /* FIXME */
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
 	if (chip->msi)
@@ -1794,7 +1794,6 @@ static int azx_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	pci->dev.power.ignore_children = 1; /* FIXME */
 	err = azx_create(card, pci, dev, pci_id->driver_data,
 			 &pci_hda_ops, &chip);
 	if (err < 0)
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6a2163056216..2956a6ba6bf0 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2132,8 +2132,10 @@ static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
+#ifdef CONFIG_PM
 		/* resetting controller clears GPIO, so we need to keep on */
-		codec->bus->power_keep_link_on = 1;
+		codec->d3_stop_clk = 0;
+#endif
 	}
 }
 
-- 
2.3.0
