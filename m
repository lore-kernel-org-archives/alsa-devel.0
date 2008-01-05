From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Fri, 04 Jan 2008 20:43:17 -0600
Message-ID: <477EEEC5.9050603@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<477BA974.8010308@freescale.com>	<20080102172340.GA2007@sirena.org.uk>	<477D280C.4000800@freescale.com>
	<20080103230004.GA18709@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 703032448F
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 03:42:06 +0100 (CET)
In-Reply-To: <20080103230004.GA18709@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> Each individual call to set_sysclk() only takes three parameters but it
> can be called repeatedly and some configurations are going to require
> this. 

In other words, ...

clock1 = <0, bb8000>
clock2 = <1, 653230>
clock23 = <0, ab2372>

> and of course the ordering matters.  

Ok, you got me there.  But then, isn't this just another example where the 
device tree is incapable of describing a complex configuration, and so we need 
a platform driver?


> Indeed.  Providing the device tree stuff doesn't get set in stone I'm
> not sure we need to nail this down perfectly for ASoC v1 when we're
> running into trouble working around it.

I definitely agree with that.  I'll be the first to admit that this driver, 
much like ASoC V1, is a prototype.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
