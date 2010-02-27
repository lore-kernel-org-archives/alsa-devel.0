From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Sat, 27 Feb 2010 21:45:12 +0800
Message-ID: <4f3252891002270545s5fd181abhee48b2c4a7732497@mail.gmail.com>
References: <hm5aba$p65$1@dough.gmane.org>
	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
	<hm5u2i$2h7$1@dough.gmane.org>
	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>
	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
	<hm8cus$56i$1@dough.gmane.org>
	<4f3252891002261806i57ea7580rcd4da69cf67b8754@mail.gmail.com>
	<hmajvg$6jp$1@dough.gmane.org>
	<4f3252891002270037m78de203fu526a1eaee8e13910@mail.gmail.com>
	<hmaq1l$m8o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F2CA1037F7
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 14:45:13 +0100 (CET)
Received: by pvg16 with SMTP id 16so306306pvg.38
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 05:45:12 -0800 (PST)
In-Reply-To: <hmaq1l$m8o$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/2/27 Angel Tsankov <fn42551@fmi.uni-sofia.bg>

>
> I'd also like to point out that in /etc/asound.state the values for
> control.48 are the maximum possible (if I interpret the values right),
> but when I stored the levels neither master, nor PCM was set to its
> maximum value.
>
> Regards,
> Angel Tsankov
>
>
That is the per voice volume control which use the hardware mixer in ymf754
chip instead of the mixer of ac97 codec

ymf754 has 32 playback subdevices , each subdevices has one hardware mixer
volume control

the values are set to 0dB by the driver when the subdevice is open , DSP can
mix 32 streams by hardware

when  the driver is loaded there are 32 controls which are inactive and the
total number of controls should more that those controls in asound.state
since those iface PCM "PCM playback volume controls" are not saved at
shutdown because all 32 controls are inactive when 32 subdevices are closed
