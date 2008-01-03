From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:28:58 -0600
Message-ID: <477D296A.6040202@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>	
	<477BADF5.9060003@freescale.com>	
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>	
	<477D25F4.6020700@freescale.com>
	<fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5258024615
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:28:00 +0100 (CET)
In-Reply-To: <fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
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

> Make the compatible property tell you!  :-)  If it's connected to an
> I2S codec, then it could be compatible = "fsl,mpc8610-ssi,i2s".  Or
> for AC7, compatible = "fsl,mpc8610-ssi,ac97"

That won't work.  There are too many variations.  I think a separate property 
just makes more sense.  Frankly, I don't see what's wrong with it.



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
