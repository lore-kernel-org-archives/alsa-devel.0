From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Fri, 15 Jun 2007 20:08:39 +0100
Message-ID: <1181934519.26658.94.camel@localhost.localdomain>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 7928810389B
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 21:08:41 +0200 (CEST)
In-Reply-To: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-15 at 13:46 -0500, Paul Kavan wrote:

> 
> Now to making the driver once the code is done. I am relatively new to
> writing linux drivers. In the 6 or so that I have written, I usually
> cross-compile them as modules and then insmod them. I have tried that here
> and am getting a strange warning that I am unsure of.  I have a pretty
> simple Makefile and when I execute it, I get:
> 
> make ARCH=arm CROSS_COMPILE=arm-linux-
> make -C ~/Linux_Builds/linux-2.6.21.5M=/home/grhuser/Door_Access_System/Remotes/Driver/sound
> modules
> make[1]: Entering directory `/home/grhuser/Linux_Builds/linux- 2.6.21.5'
>   CC [M]
> /home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.o
>   Building modules, stage 2.
>   MODPOST 1 modules
> WARNING: "at91_ssc_dai"
> [/home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.ko]
> undefined!
>   CC
> /home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.mod.o
>   LD [M]
> /home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.ko
> make[1]: Leaving directory `/home/grhuser/Linux_Builds/linux- 2.6.21.5'
> 

It looks like the AT91 platform code is not being built. i.e. at91-ssc,
at91-pcm.

> As you can see, I am using linux-2.6.21.5 I have ALSA checked and AT91-SoC
> checked in my .config file. For this attempt to build the driver, I have a
> separate folder than contains: at91-ssc.h and at91-pcm.h. If there is a more
> correct way to do this and be able to debug it, please let me know.
> 

It's probably going to be easier in the long run to copy your driver
code to linux/sound/soc/at91 and then add an entry for your driver in
the linux/sound/soc/at91/ Makefile & Kconfig

e.g. for Kconfig

config SND_AT91_SOC_ETI_B1_WM8731
	tristate "SoC Audio support for WM8731-based Endrelia ETI-B1 boards"
	depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
	select SND_AT91_SOC_SSC
	select SND_SOC_WM8731
	help
	  Say Y if you want to add support for SoC audio on WM8731-based
	  Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.

This can then tell the build system (via the select keyword above) that
your board driver depends on the AT91 platform driver and your codec. 

Liam
