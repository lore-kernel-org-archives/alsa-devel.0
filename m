From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Compulab sound device
Date: Fri, 19 Aug 2005 14:24:21 +0100
Message-ID: <1124457861.2861.251.camel@cearnarfon>
References: <20050819124710.36978.qmail@web54603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050819124710.36978.qmail@web54603.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-08-19 at 05:47 -0700, Chow Raymond wrote:
> Ok..I backport ARM audio changes from 2.6.12 to 2.6.7.
> I manage to build a zImage file and manage to make
> modules too. However..there are few warnings that i
> encounter during make modules
> 

You might want to back port from ALSA kernel CVS as this has some
updates to pxa2xx-ac97.c for PM and ac97 warm resets. 


> sound/pci/ac97/ac97_codec.c: In function
> `snd_ac97_mixer':
> sound/pci/ac97/ac97_codec.c:1771: warning: unused
> variable `pid'
> sound/pci/ac97/ac97_codec.c: At top level:
> sound/pci/ac97/ac97_codec.c:1740: warning:
> `null_build_ops' defined but not used
> 
> Building modules, stage 2.
>   MODPOST
> *** Warning: "dma_mmap_writecombine"
> [sound/arm/snd-pxa2xx-pcm.ko] undefined!
> *** Warning: "pxa_set_cken"
> [sound/arm/snd-pxa2xx-ac97.ko] undefined!
> *** Warning: "snd_ac97_get_short_name"
> [sound/arm/snd-pxa2xx-ac97.ko] undefined!

Has sound/pci/ac97/ac97_codec.c and sound/arm/pxa2xx-pcm.c been built ?
They are both required form pxa2xx ac97 audio. 

> 
> I thought warnings would be ok. I started inserting
> modules but when I want to insert the snd-pxa2xx-ac97
> module, I get the following error.
> 
> [root@ARMCore sound1]$ insmod snd-pxa2xx-ac97.ko
> snd_pxa2xx_ac97: Unknown symbol pxa2xx_pcm_new
> snd_pxa2xx_ac97: Unknown symbol
> snd_ac97_get_short_name
> snd_pxa2xx_ac97: Unknown symbol pxa_set_cken
> insmod: error inserting 'snd-pxa2xx-ac97.ko': -1
> Unknown symbol in module
> 

This means that snd-pxa2xx-pcm.ko has not been inserted. It's built from
pxa2xx-pcm.c

> Which file should I fix? There is not any
> snd-pxa2xx-ac97.c file. What does unknown symbol in
> module means?
> 

This relates to sound/arm/pxa2xx-ac97.c

You should have the following rules in sound/arm/Makefile:-

snd-pxa2xx-pcm-objs := pxa2xx-pcm.o
snd-pxa2xx-ac97-objs := pxa2xx-ac97.o

obj-$(CONFIG_SND_PXA2xx_PCM) += snd-pxa2xx-pcm.o
obj-$(CONFIG_SND_PXA2xx_AC97) += snd-pxa2xx-ac97.o

and the following options in sound/arm/Kconfig

config SND_PXA2xx_AC97
	tristate "AC97 driver for the Intel PXA2xx chip"
	depends on ARCH_PXA && SND
	select SND_PXA2xx_PCM
	select SND_AC97_CODEC
	help
	  Say Y or M if you want to support any AC97 codec attached to
	  the PXA2xx AC97 interface.

config SND_PXA2xx_PCM
	tristate
	select SND_PCM
	help
	  Generic PCM module for PXA2xx


HTH

Liam



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
