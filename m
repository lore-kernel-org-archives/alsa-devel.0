From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Wed, 24 Dec 2014 21:28:33 +0900
Message-ID: <549AB171.8030700@sakamocchi.jp>
References: <1419332872.4067.10.camel@xbing-ubuntu>
 <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
 <1419414572.1861.3.camel@gmail.com> <549A8DF8.1010004@iki.fi>
 <1419422073.1929.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 32874261490
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 13:28:37 +0100 (CET)
In-Reply-To: <1419422073.1929.5.camel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: "; Libin Yang" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Takashi Iwai" <tiwai@suse.de>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, Clemens Ladisch <clemens@ladisch.de>, "; Fengguang Wu" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Dec 24 2014 20:54, Xuebing Wang wrote:
> Anssi, thanks for your help.
> 
> 1) In Fedora 21 (kernel 3.17.4), 
> 'fuser -v /dev/snd/*' shows below:
> /dev/snd/controlC0:  xbing      2400 F.... pulseaudio
> /dev/snd/controlC1:  xbing      2400 F.... pulseaudio
> /dev/snd/pcmC0D3p:   xbing      2400 F...m pulseaudio
> /dev/snd/pcmC1D0c:   xbing      2400 F...m pulseaudio
> /dev/snd/pcmC1D0p:   xbing      2400 F...m pulseaudio
> 
> After 'pulseaudio --kill' to kill pulseaudio (after disable autospawn),
> lsmod shows refcount of snd_hda_intel is down from 7 to 2 as below:
> $ lsmod | grep hda_intel
> snd_hda_intel          30479  2
> 
> 'rmmod snd_hda_intel' still shows this module is in use.
> 
> 2) But, in Ubuntu 14.04.1 (kernel 3.13.0) DOES work after 'pulseaudio --kill', because lsmod shows refcount of snd_hda_intel is 5.
> 
> Any suggestions? Could it be because of kernel difference 3.17.4 vs 3.13.0?

In Ubuntu, pulseaudio process re-run even if you kill the process. See:
https://wiki.ubuntu.com/PulseAudio/Log

But in this case, you don't need to kill pulseaudio. You just set 'off'
for card profile, or unload alsa-card module. Then these character
devices are released.

The way to set card profile:
$ pactl list cards | grep Card
Card #3
$ pactl set-card-profile 3 off

Or use 'configuration' tab in pavucontrol GUI. In Ubuntu, this
application is released by 'pavucontrol' package.

The way to unload alsa-card module:
$ pactl list modules | grep alsa
(... you can see module-alsa-card is loaded.)
$ pactl unload-module module-alsa-card
$ pactl list modules | grep alsa
(... you can see module-alsa-card is unloaded.)


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
