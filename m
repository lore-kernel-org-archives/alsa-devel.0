From: tifereth <jesodi@googlemail.com>
Subject: Re: Acer 5920G: HDMI Sound
Date: Wed, 15 Apr 2009 19:18:37 +0200
Message-ID: <49E616ED.5010103@googlemail.com>
References: <49E4E9F7.4060606@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id D309B103816
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 19:18:39 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so204fga.21
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 10:18:39 -0700 (PDT)
In-Reply-To: <49E4E9F7.4060606@googlemail.com>
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

I finally managed to get it running:

my problem was that i didn't upgrade alsa-utils to 1.9 which made it =

finally working.

Here are some steps that could help:
- update alsa-base to 1.9
- update alsa-utils to 1.9
- stop your XServer, run "alsaconf", reboot

some system info:

aplay -l
**** Liste von PLAYBACK Ger=E4ten ****
Karte 0: Intel [HDA Intel], Ger=E4t 0: ALC1200 Analog [ALC1200 Analog]
  Untergeordnete Ger=E4te: 0/1
  Untergeordnetes Ger=E4t '0: subdevice #0
Karte 0: Intel [HDA Intel], Ger=E4t 1: ALC1200 Digital [ALC1200 Digital]
  Untergeordnete Ger=E4te: 1/1
  Untergeordnetes Ger=E4t '0: subdevice #0

cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version =

1.0.19.46.g516fa.506.gb750c.
Compiled on Apr 13 2009 for kernel 2.6.29.1 (SMP).

greetings

tifereth wrote:
> hi,
>
> i'm the owner of an "Acer 5920g" Laptop with the following specs:
> - Nvidia 8600m GT
> - HDMI Port
> - afaik. Realtek Sound Chip
>
> i've tried a lot to get the hdmi sound working, but still without =

> success. As i can only find "requests for help" for this sound chip, =

> perhaps you could help the lost acer 5920 owners and me.
>
> things i've tried yet:
> - updated kernel to vanilla 2.6.29.1 ( alsa 1.8a )
> - updated alsa to 1.9 ( stable )
> - updated alsa to "1.0.19.46.g516fa.506.gb750c" ( snapshot from =

> 14.04.2009 )
> - added the followng line to /etc/modprobe.d/alsa-base: "options =

> snd-hda-intel model=3Dauto"
>
> result of aplay -L && aplay -l ist still the same:
>
> aplay -l
> **** Liste von PLAYBACK Ger=E4ten ****
> Karte 0: Intel [HDA Intel], Ger=E4t 0: ALC1200 Analog [ALC1200 Analog]
> Untergeordnete Ger=E4te: 1/1
> Untergeordnetes Ger=E4t '0: subdevice #0
> Karte 0: Intel [HDA Intel], Ger=E4t 1: ALC1200 Digital [ALC1200 Digital]
> Untergeordnete Ger=E4te: 1/1
> Untergeordnetes Ger=E4t '0: subdevice #0
>
> aplay -L
> default:CARD=3DIntel
>   HDA Intel, ALC1200 Analog
>   Default Audio Device
> front:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   Front speakers
> surround40:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   4.0 Surround output to Front and Rear speakers
> surround41:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Analog
>   7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
> iec958:CARD=3DIntel,DEV=3D0
>   HDA Intel, ALC1200 Digital
>   IEC958 (S/PDIF) Digital Audio Output
> null
>   Discard all samples (playback) or generate zero samples (capture)
>
> alsa_info.sh output: =

> http://www.alsa-project.org/db/?f=3Daa10ba4429b9cc24826d8ce1a79a0e898fd69=
dea =

>
>
> Hopefully you have anymore ideas i could try, if you need anymore =

> hardware information please contact me
>
> thanks in advance,
> tifereth
>
