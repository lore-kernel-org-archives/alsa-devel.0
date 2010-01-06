From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: capturing data from the microphone
Date: Wed, 6 Jan 2010 09:07:48 +0800
Message-ID: <4f3252891001051707n7e740ea5gcc217595ee354278@mail.gmail.com>
References: <4B4227BC.70705@gmail.com> <4B4359A5.5060207@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8799B24523
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 02:07:49 +0100 (CET)
Received: by pxi3 with SMTP id 3so11430163pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 05 Jan 2010 17:07:48 -0800 (PST)
In-Reply-To: <4B4359A5.5060207@heig-vd.ch>
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

which device are you using ?  ( pulseaudio , dmix or default device defined
in /usr/share/alsa/cards/*.conf )

post output of

arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav

2010/1/5 Marc Garnier <marc.garnier@heig-vd.ch>

> Hi,
>
> I have the same kind of problem. I try to capture PCM stream thanks to
> areacord :
> # arecord -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
>
> 30 seconds later I have the folowing message :
> # arecord: pcm_read:1629: read error: Input/output error
>
> I can observe the PCM stream on an oscilloscope but no interrupt are
> catched by the system  (AIC ss0 counter remains at zero ) :
> # cat /proc/interrupts
>           CPU0
>  1:     275059         AIC  at91_tick, rtc0, ttyS0
>  7:        179         AIC  ttyS2
>  9:         11         AIC  mmc0
>  13:          0         AIC  atmel_spi.1
>  14:          0         AIC  ssc0
>  82:          1        GPIO  alerte
> 107:       9464        GPIO  eth0
>
> Any idea?
>
>
>
