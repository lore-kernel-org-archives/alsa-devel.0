From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [RME MADI/RayDAT/AIO/AES] Changing hdspm_config
	and hdspm_status
Date: Mon, 22 Aug 2011 18:31:04 +0200
Message-ID: <4E528448.4020902@drcomp.erfurt.thur.de>
References: <4E5283CB.7070902@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BA0E2412D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 18:31:13 +0200 (CEST)
In-Reply-To: <4E5283CB.7070902@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, Fredrik Lingvall <fredrik.lingvall@gmail.com>, Andre Schramm <andre.schramm@iosono-sound.com>, =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
List-Id: alsa-devel@alsa-project.org

On 08/22/11 18:28, Adrian Knoth wrote:

> I'll post the changes to hdspm.c in a second, but that's just a
> preview for discussion, not necessarily the final patch.


diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 493e394..0518cfe 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -918,6 +918,7 @@ struct hdspm {

 	int last_external_sample_rate;	/* samplerate mystic ... */
 	int last_internal_sample_rate;
+	uint32_t dds;
 	int system_sample_rate;

 	int dev;		/* Hardware vars... */
@@ -1355,6 +1356,7 @@ static void hdspm_set_dds_value(struct hdspm
*hdspm, int rate)

 	if (rate >= 112000)
 		rate /= 4;
+	hdspm->dds = (u32) n;
 	else if (rate >= 56000)
 		rate /= 2;

@@ -6093,7 +6095,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep
*hw, struct file *file,
 	void __user *argp = (void __user *)arg;
 	struct hdspm *hdspm = hw->private_data;
 	struct hdspm_mixer_ioctl mixer;
-	struct hdspm_config info;
+	struct hdspm_config config;
 	struct hdspm_status status;
 	struct hdspm_version hdspm_version;
 	struct hdspm_peak_rms *levels;
@@ -6199,21 +6201,36 @@ static int snd_hdspm_hwdep_ioctl(struct
snd_hwdep *hw, struct file *file,

 	case SNDRV_HDSPM_IOCTL_GET_CONFIG:

-		memset(&info, 0, sizeof(info));
+		memset(&config, 0, sizeof(config));
 		spin_lock_irq(&hdspm->lock);
-		info.pref_sync_ref = hdspm_pref_sync_ref(hdspm);
-		info.wordclock_sync_check = hdspm_wc_sync_check(hdspm);
-
-		info.system_sample_rate = hdspm->system_sample_rate;
-		info.autosync_sample_rate =
-			hdspm_external_sample_rate(hdspm);
-		info.system_clock_mode = hdspm_system_clock_mode(hdspm);
-		info.clock_source = hdspm_clock_source(hdspm);
-		info.autosync_ref = hdspm_autosync_ref(hdspm);
-		info.line_out = hdspm_line_out(hdspm);
-		info.passthru = 0;
+		config.dds = hdspm->dds;
+		if (hdspm->system_sample_rate <= 48000) {
+		  config.freq = hdspm->system_sample_rate;
+		  config.wck_mul = 1;
+		} else if (hdspm->system_sample_rate <= 96000) {
+		  config.freq = hdspm->system_sample_rate/2;
+		  config.wck_mul = 2;
+		} else {
+		  config.freq = hdspm->system_sample_rate/4;
+		  config.wck_mul = 4;
+		}
+		config.clock_mode = hdspm_system_clock_mode(hdspm);
+
+		switch (hdspm->io_type) {
+		case MADI:
+		  config.card_specific.madi.line_out = hdspm_line_out(hdspm);
+		  config.card_specific.madi.tms = hdspm_c_tms(hdspm);
+		  config.card_specific.madi.input_select = hdspm_input_select(hdspm);
+		  config.card_specific.madi.output_mode = hdspm_tx_64(hdspm);
+		  config.card_specific.madi.sync_ref = hdspm_pref_sync_ref(hdspm);
+		  break;
+
+		default:
+		  break;
+		}
+
 		spin_unlock_irq(&hdspm->lock);
-		if (copy_to_user((void __user *) arg, &info, sizeof(info)))
+		if (copy_to_user((void __user *) arg, &config, sizeof(config)))
 			return -EFAULT;
 		break;

@@ -6239,10 +6256,8 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep
*hw, struct file *file,

 			statusregister =
 				hdspm_read(hdspm, HDSPM_statusRegister);
-			status.card_specific.madi.madi_input =
-				(statusregister & HDSPM_AB_int) ? 1 : 0;
 			status.card_specific.madi.channel_format =
-				(statusregister & HDSPM_TX_64ch) ? 1 : 0;
+				(statusregister & HDSPM_RX_64ch) ? 1 : 0;
 			/* TODO: Mac driver sets it when f_s>48kHz */
 			status.card_specific.madi.frame_format = 0;
