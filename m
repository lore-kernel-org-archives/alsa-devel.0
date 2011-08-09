From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: new rt5631 driver from Realtek
Date: Wed, 10 Aug 2011 01:14:57 +0900
Message-ID: <20110809161456.GO15861@opensource.wolfsonmicro.com>
References: <D645C35CCC6E49B38F7BCBD483C1F861@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8360924612
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 18:15:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <D645C35CCC6E49B38F7BCBD483C1F861@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu <johnnyhsu@realtek.com>
Cc: alsa-devel@alsa-project.org, 'Flove' <flove@realtek.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 06:10:16PM +0800, johnnyhsu wrote:

> We have prepared our driver and attach them in the mail.

> The driver is made according to alsa architecture and patches by diff.

Please follow the standard driver submission process documented in
Documentation/SubmittingPatches.  At the very least you need to submit
patches in the format documented there, not attachments and not just
directly attached source files as you have done.  There are many
examples of the appropriate mail format on the Linux mailing lists.

git format-patch and git send-email will generally do the right thing,
they're often the easiest way to get things right.

> The driver is approved and worked on alsa 1.0.24

As also covered in SubmittingPatches you need to submit against the
current development version of the standard Linux kernel.  For ASoC this
is:

  git://git.kernel.org/pub/scm/linux/kernel/broonie/sound-2.6.git for-next

Looking briefly at the code I also see:

> static struct snd_soc_codec *rt5631_codec;

This is not suitable for mainline, please register your device using the
standard kernel mechanisms.

> module_param(timesofbclk, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> MODULE_PARM_DESC(timeofbclk, "relationship between bclk and fs");

This looks like something that should be configured using the machine
driver.

> static inline int rt5631_write(struct snd_soc_codec *codec,
> 			unsigned int reg, unsigned int val)
> {
> 	return snd_soc_write(codec, reg, val);
> }

> static inline unsigned int rt5631_read(struct snd_soc_codec *codec,
> 				unsigned int reg)
> {
> 	return snd_soc_read(codec, reg);
> }

Just use the relevant functions directly.

> 
> static int rt5631_write_mask(struct snd_soc_codec *codec,
> 	unsigned int reg, unsigned int value, unsigned int mask)

This is snd_soc_update_bits().

> /*
>  * speaker channel volume select SPKMIXER, 0DB by default
>  * Headphone channel volume select OUTMIXER,0DB by default
>  * AXO1/AXO2 channel volume select OUTMIXER,0DB by default
>  * Record Mixer source from Mic1/Mic2 by default
>  * Mic1/Mic2 boost 40dB by default
>  * DAC_L-->OutMixer_L by default
>  * DAC_R-->OutMixer_R by default
>  * DAC-->SpeakerMixer
>  * Speaker volume-->SPOMixer(L-->L,R-->R)
>  * Speaker AMP ratio gain is 1.44X
>  * HP from OutMixer,speaker out from SpeakerOut Mixer
>  * enable HP zero cross
>  * change Mic1 & mic2 to differential mode
>  */

This sort of stuff is not suitable for mainline either, the driver
should just use chip defaults for audio paths and leave the use case up
to the application layer.

Please compare your driver with the other CODEC drivers and make sure it
is following a simmilar style to them.
