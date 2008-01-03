From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 11:57:40 -0600
Message-ID: <477D2214.1020900@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>	
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C573245F6
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 18:56:31 +0100 (CET)
In-Reply-To: <9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> For this model to work you need to split your driver. fsl-ssi and
> mpc8610_hpcd need to be in  two separate drivers. 

They are two separate drivers.  sound/soc/fsl/fsl_ssi.c and 
sound/soc/fsl/mpc8610_hpcd.c

 > fsl-ssi  is easy
> enough to load since it has a device tree entry.
> 
> mpc8610_hpcd is the harder one to load since it doesn't have a device
> tree entry. What you want to do it match on the compatible field of
> the root node.
> 
> static struct of_device_id fabric_of_match[] = {
> 	{
> 		.compatible	= "fsl,MPC8610HPCD",
> 	},
> 	{},
> };
> 
> But this doesn't work since the root is the device tree isn't passed
> down into the device probe code. (Could this be fixed?)

I don't understand that sentence.  Is there a typo?

> Instead we could make the separated mpc8610_hpcd fabric driver attach
> to fsl,ssi.
> 
> static struct of_device_id fabric_of_match[] = {
> 	{
> 		.compatible	= "fsl,ssi",
> 	},
> 	{},
> };
> 
> Then in it's probe code check for the right platform.

That's what I do.  I attach to fsl,ssi, gather the information from the device 
tree, and then call a private API to initialize the SSI driver.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
