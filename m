From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Mon, 07 Jan 2008 09:52:03 -0600
Message-ID: <47824AA3.5070808@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 11B5F24905
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 16:52:22 +0100 (CET)
In-Reply-To: <20080106004637.GJ4326@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

David Gibson wrote:

> Ok, but couldn't you strucutre your I2S or fabric driver so that it
> only becomes fully operational once the codec driver has registered
> with it?

Not in ASoC V1.  You have to understand, ASoC V1 was designed without any 
consideration for runtime-bindings and other OF goodies.  All connections 
between the drivers are static, literally.  In fact, I wouldn't be surprised if 
some ASoC drivers cannot be compiled as modules.

So all I'm trying to do now is get my driver, with warts and all, into the tree 
so that I can focus with Liam et al to get a real ASoC V2 up and running.

-- 
Timur Tabi
Linux kernel developer at Freescale
