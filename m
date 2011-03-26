From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ad183x: add support for more
	multiple parts
Date: Sat, 26 Mar 2011 12:36:10 +0000
Message-ID: <20110326123609.GE28537@opensource.wolfsonmicro.com>
References: <1301126567-8043-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B81842441E
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:36:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301126567-8043-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 04:02:47AM -0400, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>

> -static const struct snd_kcontrol_new ad1836_snd_controls[] = {
> -	/* DAC volume control */
> -	SOC_DOUBLE_R("DAC1 Volume", AD1836_DAC_L1_VOL,
> -			AD1836_DAC_R1_VOL, 0, 0x3FF, 0),

One thing I've noticed about a lot of your drivers is that there's no
TLV information - it'd be good to provide this so applications can make
use of it.

> -	/* default setting for ad1836 */
> -	/* de-emphasis: 48kHz, power-on dac */
> -	snd_soc_write(codec, AD1836_DAC_CTRL1, 0x300);
> -	/* unmute dac channels */
> -	snd_soc_write(codec, AD1836_DAC_CTRL2, 0x0);
> -	/* high-pass filter enable, power-on adc */
> -	snd_soc_write(codec, AD1836_ADC_CTRL1, 0x100);
> -	/* unmute adc channles, adc aux mode */
> -	snd_soc_write(codec, AD1836_ADC_CTRL2, 0x180);
> -	/* left/right diff:PGA/MUX */
> -	snd_soc_write(codec, AD1836_ADC_CTRL3, 0x3A);
> -	/* volume */
> -	snd_soc_write(codec, AD1836_DAC_L1_VOL, 0x3FF);
> -	snd_soc_write(codec, AD1836_DAC_R1_VOL, 0x3FF);
> -	snd_soc_write(codec, AD1836_DAC_L2_VOL, 0x3FF);
> -	snd_soc_write(codec, AD1836_DAC_R2_VOL, 0x3FF);
> -	snd_soc_write(codec, AD1836_DAC_L3_VOL, 0x3FF);
> -	snd_soc_write(codec, AD1836_DAC_R3_VOL, 0x3FF);

I appreciate that this is all in the old driver but this should all be
removed, the driver should be using the register configuration provided
by the chip and allowing the user to configure things as needed for
their system at runtime.  The appropriate configuration will typically
be application specific and providing them in the driver suggests to
people that they should be configuring in the kernel which creates
problems when multiple users try to merge into mainline.  Generally the
chip defaults will at least be safe and they avoid arguments about who's
defaults to choose.

There are some things which the driver can reasonably configure as
there's very little reason to ever choose a different configuration -
zero cross is the classic example - but routing and volume control
aren't them.

Please supply a patch removing this configuration before the patch doing
the rename so we can fix this for 2.6.40.
