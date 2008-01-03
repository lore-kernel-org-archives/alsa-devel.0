From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:20:27 -0600
Message-ID: <477D276B.2060300@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	
	<477D2150.4020506@freescale.com>
	<fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 5131010383B
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:19:19 +0100 (CET)
In-Reply-To: <fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
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
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> The device tree is a description of the hardware; not software.  It's
> not a good idea to break with convention due to current driver
> architecture.

I believe that with ASoC V1, I'm stuck between a rock and a hard place, and so 
the only way to make this code work is to bend some rules.  Right now, the 
CS4270 driver does not support platform drivers or the device tree, so there's 
no point in putting a child I2C node for it.  As I mentioned in other posts, I 
will be more than happy to update the CS4270 driver to support this new 
paradigm (which was invented after the CS4270 driver was written) *after* this 
current patchset is applied.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
