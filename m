From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 14:44:39 -0600
Message-ID: <478683B7.20306@freescale.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>	
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>	
	<478641E3.5070404@freescale.com>	
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>	
	<47867C80.4050408@freescale.com>
	<9e4733910801101239n539507a8sb23d1a2177e69bd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 25E2324711
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 21:44:58 +0100 (CET)
In-Reply-To: <9e4733910801101239n539507a8sb23d1a2177e69bd9@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> So the codec is controlled from the i2c bus and SSI is used to supply
> it with data. Based on what has been said on this list, the device
> tree node for the codec should be on the i2c bus with a link from the
> ssi bus to it.

I'm working on that now.  I'll have a new patch with this exact change this 
afternoon.

-- 
Timur Tabi
Linux kernel developer at Freescale
