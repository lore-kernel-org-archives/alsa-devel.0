From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 10:55:59 -0500
Message-ID: <alpine.DEB.2.02.1204171040350.16471@heelrod.ad.cirrus.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe006.messaging.microsoft.com [216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 06AE410427F
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 17:56:48 +0200 (CEST)
In-Reply-To: <20120417111359.GB6652@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: mbizon@freebox.fr, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, joe@nucleusys.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


On Tue, 17 Apr 2012, Mark Brown wrote:

> On Mon, Apr 16, 2012 at 03:58:58PM -0500, Brian Austin wrote:
>> This patch adds support for Cirrus Logic CS42L52 Low Power Stereo Codec
>
> Overall this looks good, a few issues below...
>
>> +static const struct reg_default cs42l52_reg_defaults[] = {
>> +	{ 1, 0xE0 },	/* r01 ChipID */
>
> You shouldn't provide a default for this, the whole point with a
> register like this is that it gets read from the device so you can
> confirm you're talking to the right device.  As things stand your code
> in probe will just check that the cache is initialised with the expected
> default.
>
>> +	{ 49, 0x00 },	/* r31 Speaker Status */
>
> Going on the name this (and possibly some of the other registers) ought
> to be marked as volatile and not have a default.
>
Yeah, that makes sense :)

> Normally this is a platform data type thing.
>
>> +static const char * const cs42l52_mic_text[] = { "Single", "Differential" };
>
> This too - it's usually determined by the schematic, not something that
> gets varied at runtime.
>
Got it. Thanks
> All this beep stuff is really supposed to go through the input
> subsystem, or at least have the hookup in there to trigger it.
>
Thanks for the input...  I'd add that functionality

>
>> +	SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture",  0,
>> +			SND_SOC_NOPM, 0, 0),
>> +	SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture",  0,
>> +			SND_SOC_NOPM, 0, 0),
>
> You should use DAPM routes to hook the AIF widgets to the DAIs -
> they're new as of 3.4 but ideally we'll be transitioning everything over
> to this.  Some of the Wolfson drivers like wm8996 have been converted so
> provide examples.
>
Thanks, I'll add that

>> +		snd_soc_update_bits(codec, CS42L52_PWRCTL1,
>> +				    CS42L52_PWRCTL1_PDN_CODEC |
>> +				    CS42L52_PWRCTL1_PDN_CHRG, 0);
>
> This looks odd, especially having it in _ON - perhaps a comment
> explaining why?
>
I'm just enabling the power for the codec. Are you refering to the Charge 
Pump enable?

>
> Should be setting cache_only when entering _OFF I think?
>
Yep.  thanks

> You should use a regmap patch for this.  It's intended for this sort of
> magic register write sequence on startup and is also integrated with the
> cache sync code so the fixes will be automatically applies whenver you
> sync.  With the code as it stands if the CODEC is powered off over
> suspend then after resume these updates won't be applied.
>
I missed this.  Yes, that is much cleaner, thanks

> devm_regmap_init_i2c(), saves a small amount of error handling/cleanup
> code.
>
Will change thanks

> module_i2c_driver().
>
I should have done this. Thanks
