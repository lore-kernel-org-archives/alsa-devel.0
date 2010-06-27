From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Modifying the AD193X driver and integrating with
	the Blackfin platform
Date: Sun, 27 Jun 2010 21:07:23 +0100
Message-ID: <135AA9D1-54E3-4A87-B91D-6B71F47EEC99@opensource.wolfsonmicro.com>
References: <AANLkTimmzCY6rTrrV7aCBgznfekeIQxwY8kUDUGLDY_9@mail.gmail.com>
	(sfid-20100627_143422_653569_4AEE1E44)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC15F24485
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 22:07:26 +0200 (CEST)
In-Reply-To: <AANLkTimmzCY6rTrrV7aCBgznfekeIQxwY8kUDUGLDY_9@mail.gmail.com>
	(sfid-20100627_143422_653569_4AEE1E44)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 27 Jun 2010, at 14:34, Adam Rosenberg wrote:

> If I want to integrate this code into the uClinux-dist-2009R1.1-RC4
> distribution, is it simply a matter of copying the files in
> "[linux-2.6-asoc.git]/sound/" to the linux-2.6/sound directory for
> uClinux?  Or is it better if I git clone linux-2.6-asoc and move my
> custom board development files there?  Is there a driver installation
> guide somewhere that I can read about this?

Merge this as you would any other patch. If you are concerned with integration
with a non-mainline patchset I would encourage you to seek advice from
whoever provides that patchset. This code is aimed at mainline and is intended
to function in a mainline environment.

> I am concerned that the official Blackfin distribution
> (http://blackfin.uclinux.org/gf/download/frsrelease/473/7285/uClinux-dist-2009R1.1-RC4.tar.bz2)
> will not be compatible with the ASoC distribution
> (git://opensource.wolfsonmicro.com/linux-2.6-asoc).  Can you tell me
> if there are any differences between these?

You should not be using the Wolfson repositories to track ASoC
development. Use the repository listed in MAINTAINERS.

> 1.  Where can I find the ASoC documentation?

Documentation/sound/alsa/soc, the changelogs and the code.

> 2.  Is there an installation guide to use ASoC with an existing Kernel?

ASoC has been a part of the standard Linux kernel since 2.6.21. Unless
your kernel is exceptionally old it will already contain ASoC.

> 3.  What are the differences between the wolfsonmicro.com
> linux-2.6-asoc and blackfin.uclinux.org uClinux-dist-2009R1.1-RC4?

I can't really comment on a specific version of an out of tree patch set, the
Wolfson tree contains only a few unmerged changes to support Wolfson
devices. You should either compare the code yourself or ask the ucLinux
community to explain the changes they've made to the standard Linux
code.
