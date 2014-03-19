From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Wed, 19 Mar 2014 10:31:12 -0500
Message-ID: <alpine.DEB.2.02.1403191030070.14838@heelrod>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0096.outbound.protection.outlook.com [65.55.169.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A2A22650DD
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 16:31:06 +0100 (CET)
In-Reply-To: <20140210152244.19f9d647@skate>
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

On Mon, 10 Feb 2014, Thomas Petazzoni wrote:

> Dear Brian Austin,
>
> On Thu, 30 Jan 2014 11:23:57 -0600, Brian Austin wrote:
>
>>>>          SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
>>>>                          CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
>>>> -                       0, 0x34, 0xE4, aout_tlv),
>>>> +                       8, 0xffffff19, 0x18, aout_tlv),
>>>>          SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
>>>>
>>>> shifting 8 on an 8bit register?
>>>
>>> These values are just the ones that were here before your commit
>>> 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40. I didn't invent anything,
>>> just reverted partially your commit.
>>>
>> Oh yes, of course. I was just making the comment that it looks very
>> strange to have that shift value. I'm glad it works for your system and
>> you can go forward with your development.
>>
>> Once I get it figured out, I'll CC you on the submission for your review
>> and test.
>
> Any news about this volume control problem on cs42l51 ?
>
> Thanks!
>
> Thomas
Hello Thomas,

I found the issue WRT the CS42L51. It was actually the shift values for 
the kcontrols were wrong :)

I have the changes and will be sending the patch shortly.  Your CC'd as 
reporter if that's OK.

Thanks,
Brian
