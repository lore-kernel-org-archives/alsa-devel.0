From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Sat, 27 Feb 2010 16:46:12 +0200
Message-ID: <hmbb74$d5k$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>	<hm5u2i$2h7$1@dough.gmane.org>	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>	<hm8cus$56i$1@dough.gmane.org>	<4f3252891002261806i57ea7580rcd4da69cf67b8754@mail.gmail.com>	<hmajvg$6jp$1@dough.gmane.org>	<4f3252891002270037m78de203fu526a1eaee8e13910@mail.gmail.com>	<hmaq1l$m8o$1@dough.gmane.org>
	<4f3252891002270545s5fd181abhee48b2c4a7732497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A09C24518
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 15:46:23 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NlNvp-0002BA-2K
	for alsa-devel@alsa-project.org; Sat, 27 Feb 2010 15:46:13 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 15:46:13 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 15:46:13 +0100
In-Reply-To: <4f3252891002270545s5fd181abhee48b2c4a7732497@mail.gmail.com>
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

Raymond Yau wrote:
> 2010/2/27 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
> 
>> I'd also like to point out that in /etc/asound.state the values for
>> control.48 are the maximum possible (if I interpret the values right),
>> but when I stored the levels neither master, nor PCM was set to its
>> maximum value.
>>
>> Regards,
>> Angel Tsankov
>>
>>
> That is the per voice volume control which use the hardware mixer in ymf754

The device in question is YMF724F.

> chip instead of the mixer of ac97 codec
> 
> ymf754 has 32 playback subdevices , each subdevices has one hardware mixer
> volume control
> 
> the values are set to 0dB by the driver when the subdevice is open , DSP can
> mix 32 streams by hardware
> 
> when  the driver is loaded there are 32 controls which are inactive and the
> total number of controls should more that those controls in asound.state
> since those iface PCM "PCM playback volume controls" are not saved at
> shutdown because all 32 controls are inactive when 32 subdevices are closed

Angel Tsankov
