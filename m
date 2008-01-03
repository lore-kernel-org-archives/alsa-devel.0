From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:23:08 -0600
Message-ID: <477D280C.4000800@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<477BA974.8010308@freescale.com>
	<20080102172340.GA2007@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC8D10386B
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:21:59 +0100 (CET)
In-Reply-To: <20080102172340.GA2007@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

>> clock1 = <0, bb8000>
> 
>> Would that be better?
> 
> To cover everything you'd need to be able to specify all the clocking
> parameters, especially a PLL configuration, and also specify more than
> one of each item.  Even then you'd still have problems like...

The ASoC V1 API for communicating clock data from the fabric driver to the 
codec driver only allows for three parameters.

> According to the documentation in your patch the bus frequency should
> already be optional 

My code does not currently support that configuration, and I don't have any 
hardware that works that way, so I don't know what it would look like.  I'm 
just trying to make the driver as flexible as possible, given ASoC V1 constraints.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
