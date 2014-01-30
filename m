From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 09:23:34 -0600
Message-ID: <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB912654B9
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 16:18:25 +0100 (CET)
In-Reply-To: <20140130160554.694a8a84@skate>
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

On Thu, 30 Jan 2014, Thomas Petazzoni wrote:

> Dear Brian Austin,
>
> On Thu, 30 Jan 2014 08:59:44 -0600, Brian Austin wrote:
>
>> That is odd. My other devices that use this don't show that behavior, I
>> will check on a different device, but I will see if I can get an L51
>> today. So your saying the L51 for PCMA/B Mixer Volume COntrol, you can
>> only select 2 values in the whole range?
>
> Yes, absolutely. Not only for the PCMA/B Mixer Volume Control but also
> for the two other volume controls that were modified by your commit.
> I'll try to get back to your commit (without my revert) to verify once
> again my claims.
>
>>> Therefore, I believe that the commit has a problem. I haven't yet
>>> investigated where the problem is, maybe just the values passed to
>>> SOC_DOUBLE_R_SX_TLV(), or maybe in the implementation of the volume
>>> control functions themselves. I can certainly start investigating, but
>>> maybe the author of the commit will immediately realize where the
>>> problem could be.
>>
>> I do see however that the MAX value is not correct and should be 0x80
>> instead of 0x7F. Off by 1...
>
> Hum, ok, but I don't believe this should affect the range of values
> that alsamixer sees, but only the fact that you're not using the full
> range of volumes available at the codec level, right?

Yeah, that would not explain why you can only use 2 values for gain. That 
means something is for sure broken.

I have an L73 just up now and will check those register values and get 
back to you real soon.

sorry for the hassle
