From: JongHo Kim <furmuwon@gmail.com>
Subject: Re:
	=?utf-8?q?Using_codec_pins_to_configure_part_of_audi?=
	=?utf-8?q?o_routing=09subsystem?=
Date: Tue, 16 Sep 2014 04:39:18 +0000 (UTC)
Message-ID: <loom.20140916T055333-865@post.gmane.org>
References: <CAOMFOmXQtGe38_=vcjyAgt8RgEhCJ4ik4jShsGp2DtyJjbd=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 09110261643
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 06:50:05 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1XTkiJ-0008Eh-PD
 for alsa-devel@alsa-project.org; Tue, 16 Sep 2014 06:50:04 +0200
Received: from 121.50.20.11 ([121.50.20.11])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 06:50:03 +0200
Received: from furmuwon by 121.50.20.11 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 06:50:03 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Anatol Pomozov <anatol.pomozov <at> gmail.com> writes:

> 
> Hi
> 
> Here is reiteration from my previous question [1]
> 
> I have following task. I have realtek rt5677 codec. Codec has 6 pins.
> Some of the pins are configured as output and used to manipulate part
> of audio routing subsystem. In my case one pin enables headphones amp,
> another pin gates DMIC clock.
> 
> I can easily do it by hard-coding this logic to rt5677 driver. Now I
> an trying to pull this board-specific logic out of the codec driver
> code and move it to device tree.
> 
> I was told (without much explanation) to do it either 2 ways:
> 
> 1) export codec pins as gpio and then create fixed regulator and tie
> it to codec via SND_SOC_DAPM_REGULATOR_SUPPLY. I sent a question [1]
> to clarify if it is the right way.
> 
> 2) create ALSA controls for pins. I believe it means I need to create
> controls with names "GPIO1", "GPIO2"..."GPIO6" and then use as part of
> audio_routing list.
> 
> What is the right way to achieve my goal. Are there examples of
> configuration similar to mine? I am sure it is an easy task that was
> already implemented by someone, but I can't google any useful result.
> 
> [1] http://comments.gmane.org/gmane.linux.alsa.devel/127508
> 

Hi.. I think..

1. RT5677 codec driver have to support kernel gpiolib driver(gpio kernel 
framework) 
   that similar to the arizona-gpio.c(http://lxr.free-
electrons.com/source/drivers/gpio/gpio-arizona.c)
   
   You are lucky guy, RT5677 author(Oder Chiou <oder_chiou@realtek.com>) has 
update gpiolib function today.
   (http://thread.gmane.org/gmane.linux.alsa.devel/127626/focus=127625)
   (http://thread.gmane.org/gmane.linux.alsa.devel/127658)      
   You can use the gpio lib(kernel gpio function)
   
2. Make the switch function or dapm_widget of the amp or the dmic clock 
   using gpio lib in your ASoC machine driver
   refer to this function "tegra_wm8903_event_hp" or 
"tegra_wm8903_event_int_spk"
   (http://lxr.free-electrons.com/source/sound/soc/tegra/tegra_wm8903.c)
   
3. Connect the DAPM widget maps or Make kcontrol switch(refer to the 
"tegra_wm8903_controls")
   If you connect the dapm, amp or dmic is automatically turn on/off.
   If you make the kcontrol switch, you have to turn on/off using the alsa 
library on userspace.
   
good lock~
