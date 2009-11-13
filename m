From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: need support for insatllation of pci sound card.
Date: Fri, 13 Nov 2009 11:41:58 +0800
Message-ID: <4f3252890911121941s34b8b19ewba7fb5cbc0a46d65@mail.gmail.com>
References: <daf8bdba0911121306j3bb7b3ffo3efcf7c14793196f@mail.gmail.com>
	<daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id C791E244C8
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 04:41:59 +0100 (CET)
Received: by pxi15 with SMTP id 15so1966533pxi.23
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 19:41:58 -0800 (PST)
In-Reply-To: <daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
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

Post the output of

aplay -v -Dplughw:0 any.wav



2009/11/13 Kunal Narkhede <kunal.narkhede@gmail.com>

> hi,
>
> Please help me install my sound card drivers.As told in forum i updated my
> alsa drivers with the provided one.My card seems to getting recognize but
> no
> sound is heard here is
> *output of "aplay -l" command
> *
> **** List of PLAYBACK Hardware Devices ****
> card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371 DAC2/ADC]
> Subdevices: 1/1
> Subdevice #0: subdevice #0
> card 0: AudioPCI [Ensoniq AudioPCI], device 1: ES1371/2 [ES1371 DAC1]
> Subdevices: 1/1
> Subdevice #0: subdevice #0
>
>
> *Output of "aplay -L"*
>
> default:CARD=AudioPCI
> Ensoniq AudioPCI, ES1371 DAC2/ADC
> Default Audio Device
> front:CARD=AudioPCI,DEV=0
> Ensoniq AudioPCI, ES1371 DAC2/ADC
> Front speakers
> rear:CARD=AudioPCI,DEV=0
> Ensoniq AudioPCI, ES1371 DAC1
> Rear speakers
> surround40:CARD=AudioPCI,DEV=0
> Ensoniq AudioPCI, ES1371 DAC2/ADC
> 4.0 Surround output to Front and Rear speakers
> iec958:CARD=AudioPCI,DEV=0
> Ensoniq AudioPCI, ES1371 DAC2/ADC
> IEC958 (S/PDIF) Digital Audio Output
> null
> Discard all samples (playback) or generate zero samples (capture)
>
>
> I have also *attached the logfile obtained from alsainfo.sh* provided on
> the
> thread of alsa upgrade script.
>
> Please help me install my sound card have been searching for drivers since
> 7
> months and its getting frustating now.
>
> Mine is PCI sound card on-board sound card has been disabled from bios..
>
> I am usung* ubuntu 9.04 with 2.6.28-16-generic kerne*l installed through
> updates using update manager.
>
> --
> With Regards
> Kunal
> 9860384968
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
