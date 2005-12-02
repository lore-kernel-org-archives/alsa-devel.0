From: David Peroutka <david.peroutka@seznam.cz>
Subject: Re: Re: M-Audio Revolution 5.1 Support
Date: Fri, 02 Dec 2005 21:52:49 +0100
Message-ID: <4390B421.9030304@seznam.cz>
References: <loom.20051201T152934-108@post.gmane.org>	<loom.20051201T211819-384@post.gmane.org> <s5h1x0vhib0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070300000206050409080404"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x0vhib0.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070300000206050409080404
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

> At Thu, 1 Dec 2005 20:19:28 +0000 (UTC),
> David Peroutka wrote:
> 
>>Pieter-Jan Malfait <pieterjan.malfait <at> gmail.com> writes:
>>
>>
>>>hello,
>>>
>>>i've read on a couple of sites that the M-Audio Revolution 5.1 is not supported
>>>by   the alsa driver, however some of these sites were over a year old.. Is it
>>>currently supported or will it be in the near future ?
>>>
>>>thank you
>>>
>>>kind regards,
>>>PJ
>>>
>>>-------------------------------------------------------
>>>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>>>for problems?  Stop!  Download the new AJAX search engine that makes
>>>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>>>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>>>
>>
>>Hello,
>>
>>unfortunately, the Revolution 5.1 is currently not supported in ALSA; only
>>Revolution 7.1 is supported. Both cards are based on VIA Envy 24HT controller,
>>but there are some notable differences between the two models:
>>
>>The front two output channels of the Revolution 7.1 use AKM AK4381 stereo DAC,
>>the remaining 5.1 channels use AKM AK4355.  Analog audio is sampled with the
>>AKM AK5380 ADC.
>>
>>The Revolution 5.1 uses different codecs.  All output channels use AKM AK4358
>>(8-ch DAC, 24/192). Inputs are sampled by AKM AK5365 (24/96).  Also, the
>>Revolution 5.1 has a dedicated headphone output.
>>
>>Also note, that the DAC used in Revolution 5.1 is the same as in Juli@, which
>>is already supported in ALSA (ice1724).
>>
>>I've also tried a kernel patch, that is supposed to add support for the M-Audio
>>Revolution 5.1:
>>
>>http://www.mph.eclipse.co.uk/pub/linux/patches/ice1712_revo.patch
>>
>>but it does not work for me; apparently the driver failed to setup the output
>>codec, so I can only hear some strange dizzling sounds, coming out at full
>>volume :)
> 
> Takashi Iwai wrote:
> 
> This patch can't work because the codecs are different.
> 
> The most important question for the support of this new board is which
> connection is used on it.  Assume that it's using the same protocol as
> revo 7.1, we still need to know the clock, in, out, chip-select pins.
> You can check this by yourself with help of an electronic tool (or
> good eyes) by tracing the pin connections between VT1724 and codec
> chip.
> 
> The patch below is a shot in the dark (to ALSA CVS version!)
> If this doesn't work, first try a different value in
> akm_revo51_priv.caddr (e.g. 2 or 0).  If still doesn't work, try
> .cs_addr = VT1724_REVO_CS0 | VT1724_REVO_CS1.
> If stil doesn't work... try different combinations of clock, data and
> cs bits.
> 
> 
> Takashi

Hi Takashi,

I've found the working values for akm_revo51_priv:

.caddr = 2,
.cs_addr = 0,

The card now plays music very nicely.  I've attached a patch against 
alsa-driver-1.0.10 for other users. Note that you must adjust first two 
mixer controls named "DAC" controling volume of the left and right front 
channels.

Now, the only missing piece (for me :) is a volume control for headphone 
output. Any idea how to add it?

I do really appreciate your help and outstanding work of alsa team as whole.

Thanks!

--
David

--------------070300000206050409080404
Content-Type: text/plain;
 name="revo51.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revo51.diff"

--- revo.c.orig	2005-10-06 14:48:54.000000000 +0200
+++ revo.c	2005-12-02 21:46:20.000000000 +0100
@@ -47,6 +47,7 @@
  */
 static void revo_set_rate_val(akm4xxx_t *ak, unsigned int rate)
 {
+	printk(KERN_DEBUG "revo_set_rate_val: rate=%d\n", rate);
 	unsigned char old, tmp, dfs;
 	int reg, shift;
 
@@ -61,7 +62,7 @@
 	else
 		dfs = 0;
 
-	if (ak->type == SND_AK4355) {
+	if (ak->type == SND_AK4355 || ak->type == SND_AK4358) {
 		reg = 2;
 		shift = 4;
 	} else {
@@ -128,6 +129,26 @@
 	.mask_flags = 0,
 };
 
+static akm4xxx_t akm_revo51 __devinitdata = {
+	.type = SND_AK4358,
+	.num_dacs = 6,
+	.ops = {
+		.set_rate_val = revo_set_rate_val
+	}
+};
+
+static struct snd_ak4xxx_private akm_revo51_priv __devinitdata = {
+	.caddr = 2,
+	.cif = 0,
+	.data_mask = VT1724_REVO_CDOUT,
+	.clk_mask = VT1724_REVO_CCLK,
+	.cs_mask = VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.cs_addr = 0,
+	.cs_none = VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.add_flags = VT1724_REVO_CCLK, /* high at init */
+	.mask_flags = 0,
+};
+
 static int __devinit revo_init(ice1712_t *ice)
 {
 	akm4xxx_t *ak;
@@ -138,21 +159,24 @@
 	case VT1724_SUBDEVICE_REVOLUTION71:
 		ice->num_total_dacs = 8;
 		ice->num_total_adcs = 2;
+		ice->gpio.i2s_mclk_changed = revo_i2s_mclk_changed;
+		break;
+	case VT1724_SUBDEVICE_REVOLUTION51:
+		ice->num_total_dacs = 6;
+		ice->num_total_adcs = 2;
 		break;
 	default:
 		snd_BUG();
 		return -EINVAL;
 	}
 
-	ice->gpio.i2s_mclk_changed = revo_i2s_mclk_changed;
-
 	/* second stage of initialization, analog parts and others */
 	ak = ice->akm = kcalloc(2, sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ak)
 		return -ENOMEM;
-	ice->akm_codecs = 2;
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+		ice->akm_codecs = 2;
 		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo_front, &akm_revo_front_priv, ice)) < 0)
 			return err;
 		if ((err = snd_ice1712_akm4xxx_init(ak + 1, &akm_revo_surround, &akm_revo_surround_priv, ice)) < 0)
@@ -160,6 +184,13 @@
 		/* unmute all codecs */
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
 		break;
+	case VT1724_SUBDEVICE_REVOLUTION51:
+		ice->akm_codecs = 1;
+		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo51, &akm_revo51_priv, ice)) < 0)
+			return err;
+		/* unmute all codecs - needed! */
+		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
+		break;
 	}
 
 	return 0;
@@ -172,6 +203,7 @@
 
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+	case VT1724_SUBDEVICE_REVOLUTION51:
 		err = snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
@@ -188,5 +220,12 @@
 		.chip_init = revo_init,
 		.build_controls = revo_add_controls,
 	},
+	{
+		.subvendor = VT1724_SUBDEVICE_REVOLUTION51,
+		.name = "M Audio Revolution-5.1",
+		.model = "revo51",
+		.chip_init = revo_init,
+		.build_controls = revo_add_controls,
+	},
 	{ } /* terminator */
 };

--------------070300000206050409080404--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
