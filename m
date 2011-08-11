From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: Add ADAU1373 codec support
Date: Thu, 11 Aug 2011 12:11:27 +0200
Message-ID: <4E43AACF.5060701@metafoo.de>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	<1312948364-2587-2-git-send-email-lars@metafoo.de>
	<20110811092702.GA18454@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E9C72440B
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 12:13:35 +0200 (CEST)
In-Reply-To: <20110811092702.GA18454@opensource.wolfsonmicro.com>
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
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>> +	SOC_ENUM("Lineout1 Mono Stereo", adau1373_lineout1_mode_enum),
>> +	SOC_ENUM("Speaker Mono Stereo", adau1373_speaker_mode_enum),
> 
> I'd expect these to be platform data/machine data rather than user
> control?  The speaker wiring isn't going to vary dynamically...
>
You still might want to switch, for whatever particular reason, between mono
and stereo at runtime.

>> +	switch (freq / params_rate(params)) {
>> +	case 1024: /* fs */
>> +		div = 0;
>> +		break;
>> +	case 1536: /* 2/3 fs */
>> +		div = 1;
>> +		break;
> 
> These comments look inaccuate, fs is the sample rate so a divide of 1
> would be fs.

div contains the register value representation of that particular divider.
