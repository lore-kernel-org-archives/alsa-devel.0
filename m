From: jgotts@linuxsavvy.com
Subject: Re: PATCH] SPDIF out clock sync for via8235 / ALC650
Date: Mon, 30 Dec 2002 16:30:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212302130.gBULUVp24791@ann-arbor.fmfts.com>
References: <s5hznrtzp3z.wl@alsa2.suse.de>
Reply-To: jgotts@linuxsavvy.com
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Nov 2002 16:32:48 +0100."
             <s5hznrtzp3z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ae.tech@noos.fr, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In message <s5hznrtzp3z.wl@alsa2.suse.de>, Takashi Iwai writes:

>we have already a method to change the spdif rate:
>	snd_ac97_set_rate(ac97, AC97_SPDIF, rate);
>but it didn't work properly.  so i fixed the relevant part based on
>your patch.

>to via82xx.c, the above call was just added, so that the spdif rate is
>automatically changed.

I have produced a minimal patch based upon your work in CVS to get the SPDIF
port going on A7V8X motherboards with 0.9.0rc6 until 0.9.0rc7 is released:

--- alsa-driver-0.9.0rc6/alsa-kernel/pci/via82xx.c.orig	2002-12-27 17:25:29.000000000 -0500
+++ alsa-driver-0.9.0rc6/alsa-kernel/pci/via82xx.c	2002-12-27 17:27:22.000000000 -0500
@@ -613,6 +613,9 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_LFE_DAC_RATE, runtime->rate);
+	snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);
 	if (chip->chip_type == TYPE_VIA8233 &&
 	    chip->playback.reg_offset != VIA_REG_MULTPLAY_STATUS) {
 		unsigned int tmp;
--- alsa-driver-0.9.0rc6/alsa-kernel/pci/ac97/ac97_codec.c.orig	2002-12-27 17:29:08.000000000 -0500
+++ alsa-driver-0.9.0rc6/alsa-kernel/pci/ac97/ac97_codec.c	2002-12-27 17:43:43.000000000 -0500
@@ -1942,6 +1942,45 @@
 	}
 }
 
+static int set_spdif_rate(ac97_t *ac97, unsigned short rate)
+{
+	unsigned short old, bits, reg;
+
+	if (! (ac97->ext_id & AC97_EI_SPDIF))
+		return -ENODEV;
+
+	if (ac97->flags & AC97_CS_SPDIF) {
+		switch (rate) {
+		case 48000: bits = 0; break;
+		case 44100: bits = 1 << AC97_SC_SPSR_SHIFT; break;
+		default: /* invalid - disable output */
+			snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, 0);
+			return -EINVAL;
+		}
+		reg = AC97_CSR_SPDIF;
+	} else {
+		switch (rate) {
+		case 44100: bits = AC97_SC_SPSR_44K; break;
+		case 48000: bits = AC97_SC_SPSR_48K; break;
+		case 32000: bits = AC97_SC_SPSR_32K; break;
+		default: /* invalid - disable output */
+			snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, 0);
+			return -EINVAL;
+		}
+		reg = AC97_SPDIF;
+	}
+
+	spin_lock(&ac97->reg_lock);
+	old = ac97->regs[reg] & ~AC97_SC_SPSR_MASK;
+	if (old != bits) {
+		snd_ac97_update_bits_nolock(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, 0);
+		snd_ac97_update_bits_nolock(ac97, reg, AC97_SC_SPSR_MASK, bits);
+	}
+	snd_ac97_update_bits_nolock(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, AC97_EA_SPDIF);
+	spin_unlock(&ac97->reg_lock);
+	return 0;
+}
+
 /*
  *  PCM support
  */
@@ -1971,8 +2010,9 @@
 				return -EINVAL;
 		break;
 	case AC97_SPDIF:
-		return 0;
-	default: return -EINVAL;
+		return set_spdif_rate(ac97, rate);
+	default:
+		return -EINVAL;
 	}
 	tmp = ((unsigned int)rate * ac97->clock) / 48000;
 	if (tmp > 65535)

-- 
John GOTTS <jgotts@linuxsavvy.com>  http://linuxsavvy.com/staff/jgotts


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
