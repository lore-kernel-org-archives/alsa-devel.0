From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:14:12 -0600
Message-ID: <477D25F4.6020700@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>	
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 40CD310383B
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:13:30 +0100 (CET)
In-Reply-To: <fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Does that mean with ASoC V2 you can instantiate it with the board
> specific platform code instead? 

I don't know.  I haven't really looked at V2 yet.  You'll have to ask Liam 
Girdwood.

> This is one of the examples of where the compatible properties are
> trying to be far to generic about what they are.  How do you define
> what "fsl,ssi" is? 

The SSI is a specific Freescale device, so I think it's pretty well defined.

> What happens when Freescale produces another
> peripheral that can do ssi but isn't register level compatible?

It won't be called the SSI.  It will be called something else.

> In my opinion, it is far better to be specific in the device tree and
> teach the driver about what versions it is able to bind against.  In
> this case, I would use "fsl,mpc8610-ssi" or maybe better yet:
> "fsl,mpc8610-ssi,i2s" (MPC8610 SSI device in I2S mode).

I can work with that, but the SSI could be placed into any future 83xx, 85xx, 
or 86xx SOC, and the driver will still work with it as-is.

> I don't like the idea of a separate fsl,mode property to describe the
> behaviour of multifunction peripherals.  It makes probing more
> difficult when there is a different driver for each mode.

Can you propose an alternative?  The driver needs to know what mode to use 
when communicating with its codec.  How am I supposed to know if I have an I2S 
codec or an AC97 codec?

>> The fabric driver is specific to the board.  So you should be using
>> Kconfig to select the fabric driver.  There is no node in the device
>> tree for fabric drivers.  I thought that was the consensus.
> 
> No, the desire is to go multiplatform in ppc.  That means you cannot
> use Kconfig to select the correct fabric driver.

I don't see any way of avoiding this with ASoC V1.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
