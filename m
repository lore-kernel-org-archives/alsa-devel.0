From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 11:23:57 -0600
Message-ID: <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 274192655A3
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 18:18:51 +0100 (CET)
In-Reply-To: <20140130181607.6a694b8f@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, =?ISO-8859-15?Q?Gregory_Cl=E9ment?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

>> Thanks! but...
>>
>>          SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
>>                          CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
>> -                       0, 0x34, 0xE4, aout_tlv),
>> +                       8, 0xffffff19, 0x18, aout_tlv),
>>          SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
>>
>> shifting 8 on an 8bit register?
>
> These values are just the ones that were here before your commit
> 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40. I didn't invent anything,
> just reverted partially your commit.
>
Oh yes, of course. I was just making the comment that it looks very 
strange to have that shift value. I'm glad it works for your system and 
you can go forward with your development.

Once I get it figured out, I'll CC you on the submission for your review 
and test.

Thanks again,
