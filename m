From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 08:59:44 -0600
Message-ID: <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
References: <20140130144807.5b102b28@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 755712654B0
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 15:54:35 +0100 (CET)
In-Reply-To: <20140130144807.5b102b28@skate>
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

Hello Thomas,

On Thu, 30 Jan 2014, Thomas Petazzoni wrote:

> Brian, Liam, Mark,
>
> I am currently bringing up audio support on the Marvell Armada 370 ARM
> SoC, for which the development board uses the CS42L51 audio codec.
>
> It turns out that the commit 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40
> ("ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV") causes
> a problem here, and reverting this commit gets things back to normal.
>
> Basically, when this commit is applied, the "PCM", "Analog" and "ADC
> Mixer" volume controls in alsamixer cannot be changed to any other
> value than 60 or 61. The volume control doesn't allow to go above 61
> and below 60. If I remember correctly, at the codec level, the values
> configured for PCM in registers 0x10 and 0x11 are either 0x0 or 0x1
> depending on whether you select 60 or 61 in alsamixer.

That is odd. My other devices that use this don't show that behavior, I 
will check on a different device, but I will see if I can get an L51 
today. So your saying the L51 for PCMA/B Mixer Volume COntrol, you can 
only select 2 values in the whole range?

>
> Reverting the commit mentioned above makes alsamixer behave normally:
> the volume can be adjusted between 0 and 100 as expected, the values in
> register 0x10 and 0x11 are meaningful, and the behavior is as expected:
> with a volume to 0, I hear nothing in my headphones, with a volume set
> to 100, the volume is maximum, with a nice progressive volume increase
> in-between.
>
> Therefore, I believe that the commit has a problem. I haven't yet
> investigated where the problem is, maybe just the values passed to
> SOC_DOUBLE_R_SX_TLV(), or maybe in the implementation of the volume
> control functions themselves. I can certainly start investigating, but
> maybe the author of the commit will immediately realize where the
> problem could be.
>

I do see however that the MAX value is not correct and should be 0x80 
instead of 0x7F. Off by 1...

I'll investigate today.

> Thanks a lot!
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>
>
Thanks!
