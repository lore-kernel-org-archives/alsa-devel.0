From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC PATCH 3/6] ASoC: sgtl5000: initialize
 CHIP_ANA_POWER to power-on defaults
Date: Fri, 06 Mar 2015 15:14:16 -0700
Message-ID: <54FA26B8.9050601@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-4-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201207.GX21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6703726606C
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:14:24 +0100 (CET)
Received: by pablj1 with SMTP id lj1so45658203pab.10
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 14:14:22 -0800 (PST)
In-Reply-To: <20150306201207.GX21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Mark,

On 03/06/2015 01:12 PM, Mark Brown wrote:
> On Thu, Feb 26, 2015 at 03:54:30PM -0700, Eric Nelson wrote:
>> Initialize CHIP_ANA_POWER to match power on defaults, which
>> disables ADC, DAC, and charge pumps.
> 
>> +++ b/sound/soc/codecs/sgtl5000.c @@ -47,12 +47,10 @@ static
>> const struct reg_default sgtl5000_reg_defaults[] = { {
>> SGTL5000_CHIP_ANA_ADC_CTRL,		0x0000 }, {
>> SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 }, { SGTL5000_CHIP_ANA_CTRL,
>> 0x0111 }, -	{ SGTL5000_CHIP_LINREG_CTRL,		0x0000 }, {
>> SGTL5000_CHIP_REF_CTRL,		0x0000 }, { SGTL5000_CHIP_MIC_CTRL,
>> 0x0000 }, { SGTL5000_CHIP_LINE_OUT_CTRL,		0x0000 }, {
>> SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 }, -	{
>> SGTL5000_CHIP_ANA_POWER,		0x7060 },
> 
> Two big problems here.  One is that this appears to also affect 
> LINREG_CTRL which your changelog didn't mention.

It did mention the change:

	> Initialize CHIP_ANA_POWER to match power on defaults, which
	> disables ADC, DAC, and charge pumps.
	>
	> In the process, remove references to the following
	> register/bitfields from the sgttl5000_set_power_regs routine:
	> 	CHIP_ANA_POWER/LINREG_SIMPLE_POWERUP and
	> 	CHIP_LINREG_CTRL/LINREG_VDD_MASK
	>
	> And remove CHIP_ANA_POWER and CHIP_LINREG_CTRL from the set
	> of default registers so they don't get clobbered by
	> sgtl5000_fill_defaults().

The CHIP_LINREG_CTRL value needs to be set based on the presence
or absence of external VDDD, so writing a default (power-on) value
doesn't help much, and this certainly shouldn't happen after
the proper value is written.

> The other is that contrary to what the changelog says this isn't 
> fixing the default, it's removing it.
> 

You're right about the commit message. It should be re-worded.

> The whole point of the register defaults table is to contain the 
> default power on register values, if it contains other things that 
> is a bug and should be fixed by changing the values not removing
> them.
> 

I understand that, but the crux of the problem is that these
registers need to be set early, their order is critical, and
some of them need to be written based on the internal/external
VDDD decision.

In a soft reboot on a machine that doesn't actually control
the power to the SGTL5000 (which is all supported boards at
the moment), a write to the ANA_POWER register with stale
values in either LINREG_CTRL or CLK_CTRL (from patch 5)
will fail and cause the chip to lock up.

Discussion of this is the primary reason I sent this patch
set as an RFC: to highlight the issues.

> Given that confusion I'm really having a hard time understanding
> the rest of the commit.
> 

Some of this (and some of your expressed concerns) could be
alleviated by moving the call to sgtl5000_fill_defaults()
before the newly-added code to initialize ANA_POWER based on
whether an external VDDD is supplied or the internal LDO is
used, but then the dependencies would be hidden in the order
of registers in the table.

This is just more explicit.

I hope that clarifies things.

Regards,


Eric
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+ia3AAoJEFUqXmm9AiVrU6AH/iu2bxDRrhBPaBBLMnXQUqiG
w49zAs74PA3LcFAvR0zPhBeRjbw3NOFjAVqsr2nejpq4jtNnlxG0aYYiX+bsWA4H
52vplw8BaJxRUnR/pwa+cj7HzUwK637t8/19Zk3mfxbeqaUMX6zDS1w5k8c8U5DE
1497cxLXnX5OVjClzCyrLiZMUhLqu2BCXFgxJLHe9315MFz5T+Nd1tFXDFSVmNB8
oO85GSMBvdz2CkQ9X6wjMVVS9QnISoisEjBOhoqzfGP6A5C3p2f2zi+Sm/2Rote7
E3diMCmrH22q+IruCfQbzzVVB0B3SiU+ckQvvEWtCXWNr0RVaJwzuzdonD51Zkk=
=9hrU
-----END PGP SIGNATURE-----
