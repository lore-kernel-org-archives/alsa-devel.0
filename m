From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Fri, 27 Apr 2012 08:44:24 -0500
Message-ID: <alpine.DEB.2.02.1204270837060.11753@heelrod.ad.cirrus.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C97C243B7
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 15:45:00 +0200 (CEST)
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

>> +static const char * const beep_pitch_text[] = {
>> +	"C4", "C5", "D5", "E5", "F5", "G5", "A5", "B5",
>> +	"C6", "D6", "E6", "F6", "G6", "A6", "B6", "C7"
>> +};
>> +
>> +static const struct soc_enum beep_pitch_enum =
>> +	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 4,
>> +		ARRAY_SIZE(beep_pitch_text), beep_pitch_text);
>> +
>> +static const char * const beep_ontime_text[] = {
>> +	"86 ms", "430 ms", "780 ms", "1.20 s", "1.50 s",
>> +	"1.80 s", "2.20 s", "2.50 s", "2.80 s", "3.20 s",
>> +	"3.50 s", "3.80 s", "4.20 s", "4.50 s", "4.80 s", "5.20 s"
>> +};
>> +
>> +static const struct soc_enum beep_ontime_enum =
>> +	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 0,
>> +		ARRAY_SIZE(beep_ontime_text), beep_ontime_text);
>> +
>> +static const char * const beep_offtime_text[] = {
>> +	"1.23 s", "2.58 s", "3.90 s", "5.20 s",
>> +	"6.60 s", "8.05 s", "9.35 s", "10.80 s"
>> +};
>> +
>> +static const struct soc_enum beep_offtime_enum =
>> +	SOC_ENUM_SINGLE(CS42L52_BEEP_VOL, 5,
>> +		ARRAY_SIZE(beep_offtime_text), beep_offtime_text);
>> +
>> +static const char * const beep_config_text[] = {
>> +	"Off", "Single", "Multiple", "Continuous"
>> +};
>> +
>> +static const struct soc_enum beep_config_enum =
>> +	SOC_ENUM_SINGLE(CS42L52_BEEP_TONE_CTL, 6,
>> +		ARRAY_SIZE(beep_config_text), beep_config_text);
>> +
>> +static const char * const beep_bass_text[] = {
>> +	"50 Hz", "100 Hz", "200 Hz", "250 Hz"
>> +};
>
> All this beep stuff is really supposed to go through the input
> subsystem, or at least have the hookup in there to trigger it.
>

I have added basic functionality of the Beep to the input subsystem but 
have a few questions regarding the extra configs. I just used the same 
interface as the WM8962.

Would it be OK to keep the configurable parts of the Beep as Kcontrols? 
Maybe even Platform data?
