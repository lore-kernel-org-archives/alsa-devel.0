From: "Paul Kavan" <pkavan@gmail.com>
Subject: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Fri, 15 Jun 2007 13:46:59 -0500
Message-ID: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 96BEE10387D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:47:00 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so932875uge
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:47:00 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all:

I am working on a driver for a dumb codec to work with the SSC as a PCM on
the AT91SAM9260. I have, with the gracious help of Frank Mandarino, have the
glue code written without too many problems. However, I need some guidance
on getting a few things configured correctly for my codec and then getting
it to compile and load correctly.

For configuration, I am using the Winbond W6811. For this, I am going to use
a 256kHz BCLK and an 8kHz frame. Each sample consists of 8-bit u-law PCM,
MSB first. When I execute a read from the codec to the processor, I need to
make the reads on the falling edge of the BCLK at each sync pulse. When
executing a write from the processor to the codec I need to write on the
rising edge at each sync pulse. I think I the timing correct in my driver
with:

    cmr_div = 187;    /* PCM_CLK = ~96MHz/(2*187) = 256kHz */
   period = 15;    /* PCM_SYNC = PCM_CLK/(2*(15+1)) = 8000Hz */

However, I am not sure how to get the following correct for my needs:

#define W6811_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)

Now to making the driver once the code is done. I am relatively new to
writing linux drivers. In the 6 or so that I have written, I usually
cross-compile them as modules and then insmod them. I have tried that here
and am getting a strange warning that I am unsure of.  I have a pretty
simple Makefile and when I execute it, I get:

make ARCH=arm CROSS_COMPILE=arm-linux-
make -C ~/Linux_Builds/linux-2.6.21.5M=/home/grhuser/Door_Access_System/Remotes/Driver/sound
modules
make[1]: Entering directory `/home/grhuser/Linux_Builds/linux- 2.6.21.5'
  CC [M]
/home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "at91_ssc_dai"
[/home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.ko]
undefined!
  CC
/home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.mod.o
  LD [M]
/home/grhuser/Door_Access_System/Remotes/Driver/sound/grh_ek_w6811.ko
make[1]: Leaving directory `/home/grhuser/Linux_Builds/linux- 2.6.21.5'

As you can see, I am using linux-2.6.21.5 I have ALSA checked and AT91-SoC
checked in my .config file. For this attempt to build the driver, I have a
separate folder than contains: at91-ssc.h and at91-pcm.h. If there is a more
correct way to do this and be able to debug it, please let me know.

I have attached copies of my driver. I would appreciate any and all feedback
and assistance on getting this running.
