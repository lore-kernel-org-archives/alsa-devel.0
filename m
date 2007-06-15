From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Fri, 15 Jun 2007 16:06:18 -0500
Message-ID: <61c0054e0706151406o2cc8b4c2x502e7fdb38a39a3e@mail.gmail.com>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
	<1181934519.26658.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id CC50A1038A0
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 23:06:19 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so954401uge
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 14:06:19 -0700 (PDT)
In-Reply-To: <1181934519.26658.94.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam:

It's probably going to be easier in the long run to copy your driver
> code to linux/sound/soc/at91 and then add an entry for your driver in
> the linux/sound/soc/at91/ Makefile & Kconfig
>
> e.g. for Kconfig
>
> config SND_AT91_SOC_ETI_B1_WM8731
>         tristate "SoC Audio support for WM8731-based Endrelia ETI-B1
> boards"
>         depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
>         select SND_AT91_SOC_SSC
>         select SND_SOC_WM8731
>         help
>           Say Y if you want to add support for SoC audio on WM8731-based
>           Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.
>
> This can then tell the build system (via the select keyword above) that
> your board driver depends on the AT91 platform driver and your codec.
>
> Liam



Thanks for the tips. I have rewritten my Kconfig file so that it looks like
this:

config SND_AT91_SOC
    tristate "SoC Audio for the Atmel AT91 System-on-Chip"
    depends on ARCH_AT91 && SND_SOC
    help
      Say Y or M if you want to add support for codecs attached to
      the AT91 SSC interface. You will also need
      to select the audio interfaces to support below.

config SND_AT91_SOC_SSC
    tristate

config SND_AT91_SOC_AT91SAM9260_EK_W6811
    tristate "SoC Audio support for at91sam9260ek boards with W6811 codec"
    depends on SND_AT91_SOC && MACH_AT91SAM9260EK
    select SND_AT91_SOC_SSC
    select SND_SOC_W6811
    help
      Say Y if you want to add support for SoC audio on AT91SAM9260EK boards
          with a W6811 codec.

config SND_AT91_SOC_ETI_SLAVE
    bool "Run codec in slave Mode on AT91SAM9260EK"
    depends on SND_AT91_SOC_AT91SAM9260EK_W6811
    default n
    help
      Say Y if you want to run with the AT91 SSC generating the BCLK
      and LRC signals.

...and my Makefile so that it looks like this:

# AT91 Platform Support
snd-soc-at91-objs := at91-pcm.o
snd-soc-at91-ssc-objs := at91-ssc.o

obj-$(CONFIG_SND_AT91_SOC) += snd-soc-at91.o
obj-$(CONFIG_SND_AT91_SOC_SSC) += snd-soc-at91-ssc.o

# AT91 Machine Support
snd-soc-at91sam9260ek-w6811-objs := at91sam9260ek-w6811.o

obj-$(CONFIG_SND_AT91_SOC_ETI_B1_WM8731) += snd-soc-at91sam9260ek-w6811.o


...and I renamed the source to reflect what I think you have done. The
source now lives in /linux- 2.6.22-rc1/sound/soc/at91/. I did a make clean
and a at91sam9260ek_defconfig. Then in menuconfig my new option comes up.

I have selected it and then compiled the kernel. Now, when I go to boot the
board with 2.6.22-rc1 I get:

## Booting image at 22100000 ...
   Image Name:   Linux-2.6.22-rc1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1068884 Bytes =  1 MB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing
Linux......................................................................
done, boo.


and it hangs here, which is probably more related to the kernel than to my
new config stuff. I will have to solve this so I can see what I get when the
system fully boots.

Anything above that you see as an obvious error?

Thanks.

Paul
