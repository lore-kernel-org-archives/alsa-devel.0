From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 11:28:51 -0500
Message-ID: <alpine.DEB.2.02.1204171128010.16471@heelrod.ad.cirrus.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe003.messaging.microsoft.com [213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id F37AE104316
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:29:33 +0200 (CEST)
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

>> +static const struct soc_enum charge_pump_enum =
>> +	SOC_ENUM_SINGLE(CS42L52_CHARGE_PUMP, 4,
>> +		ARRAY_SIZE(charge_pump_freq_text), charge_pump_freq_text);
>
> Should this be runtime configurable?
>
Nope, I'll add it to platform data
