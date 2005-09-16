From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problems with multiple simultaneous ac97 quirks
Date: Fri, 16 Sep 2005 11:41:37 +0100
Message-ID: <20050916104137.GA18311@srcf.ucam.org>
References: <20050915180415.GA24705@srcf.ucam.org> <s5h4q8mm7qi.wl%tiwai@suse.de> <20050915202858.GA5169@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8595175
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 12:41:37 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20050915202858.GA5169@srcf.ucam.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 15, 2005 at 09:28:58PM +0100, Matthew Garrett wrote:

> Ok. Something like the following patch? It introduces 
> AC97_TUNE_HP_MUTE_LED (yes, it's a poor name...) which is identical to 
> AC97_TUNE_MUTE_LED except it calls bind_hp_volsw_put instead of 
> snd_ac97_put_volsw and removes the headphone mixer controls.

Oops. Entirely the wrong patch. Here we go:

-- 
Matthew Garrett | mjg59@srcf.ucam.org

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hpledquirk.diff"

--- include/sound/ac97_codec.h.orig	2005-09-15 19:05:14.000000000 +0100
+++ b/include/sound/ac97_codec.h	2005-09-15 19:05:47.000000000 +0100
@@ -570,6 +570,7 @@
 	AC97_TUNE_ALC_JACK,	/* for Realtek, enable JACK detection */
 	AC97_TUNE_INV_EAPD,	/* inverted EAPD implementation */
 	AC97_TUNE_MUTE_LED,	/* EAPD bit works as mute LED */
+	AC97_TUNE_HP_MUTE_LED,  /* EAPD bit works as mute LED, use headphone control as master */
 };
 
 struct ac97_quirk {
--- sound/pci/ac97/ac97_codec.c.orig	2005-09-15 21:25:24.000000000 +0100
+++ b/sound/pci/ac97/ac97_codec.c	2005-09-15 19:09:55.000000000 +0100
@@ -2470,6 +2470,40 @@
 	return 0;
 }
 
+static int hp_master_mute_sw_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	int err = bind_hp_volsw_put(kcontrol, ucontrol);
+	if (err > 0) {
+		ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+		int shift = (kcontrol->private_value >> 8) & 0x0f;
+		int rshift = (kcontrol->private_value >> 12) & 0x0f;
+		unsigned short mask;
+		if (shift != rshift)
+			mask = 0x8080;
+		else
+			mask = 0x8000;
+		snd_ac97_update_bits(ac97, AC97_POWERDOWN, 0x8000,
+				     (ac97->regs[AC97_MASTER] & mask) == mask ?
+				     0x8000 : 0);
+	}
+	return err;
+}
+
+static int tune_hp_mute_led(ac97_t *ac97)
+{
+	snd_kcontrol_t *msw = ctl_find(ac97, "Master Playback Switch", NULL);
+	snd_kcontrol_t *mvol = ctl_find(ac97, "Master Playback Volume", NULL);
+	if (! msw || ! mvol)
+		return -ENOENT;
+	msw->put = hp_master_mute_sw_put;
+	mvol->put = bind_hp_volsw_put;
+	snd_ac97_remove_ctl(ac97, "External Amplifier", NULL);
+	snd_ac97_remove_ctl(ac97, "Headphone Playback", "Switch");
+	snd_ac97_remove_ctl(ac97, "Headphone Playback", "Volume");
+	snd_ac97_update_bits(ac97, AC97_POWERDOWN, 0x8000, 0x8000); /* mute LED on */
+	return 0;
+}
+
 struct quirk_table {
 	const char *name;
 	int (*func)(ac97_t *);
@@ -2484,6 +2518,7 @@
 	{ "alc_jack", tune_alc_jack },
 	{ "inv_eapd", tune_inv_eapd },
 	{ "mute_led", tune_mute_led },
+	{ "hp_mute_led", tune_hp_mute_led },
 };
 
 /* apply the quirk with the given type */

--J/dobhs11T7y2rNN--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
