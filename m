From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 11:13:36 -0600
Message-ID: <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 934BB26553F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 18:08:28 +0100 (CET)
In-Reply-To: <20140130175658.11469081@skate>
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

> I've tried again, and I confirm the problem. When the PCM is muted, I
> can only toggle it between the values 62 and 64. When the PCM is
> unmuted, I can only toggle it between the values 60 and 61.
OK, that is very odd.  I will take a look when I get a chance. I have an 
L51 board, but need to do some other stuff first.

>
> The ugly attached patch fixes the problem for me (the patch is a
> partial revert of your patch).
>

Thanks! but...

         SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
                         CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
-                       0, 0x34, 0xE4, aout_tlv),
+                       8, 0xffffff19, 0x18, aout_tlv),
         SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",

shifting 8 on an 8bit register?

I'll have to look into this. Thanks for the feedback!

-Brian
