From: "Jose Henrique Spahn Torres" <jose.torres@eldorado.org.br>
Subject: Re: [RFC] [PATCH 0/2] ASoC sound support
	forSMDK2440boards
Date: Tue, 29 May 2007 14:42:06 -0300
Message-ID: <AC2729D6E3A3314A922E4E0FBE513F65D6BE87@MAIL.eldorado.org.br>
References: <5b7270f40705240728p4f579269g1ddc8e8db8d59f81@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FD65@MAIL.eldorado.org.br>
	<5b7270f40705241445t59a89b24sacbd3abf0a1b129d@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D1FE77@MAIL.eldorado.org.br>
	<5b7270f40705250750u1ba4619dm973fcb297c8fefb1@mail.gmail.com>
	<AC2729D6E3A3314A922E4E0FBE513F65D6B8B8@MAIL.eldorado.org.br>
	<5b7270f40705251040r56bee4dfqdb2e66fd2b7fbdcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eldorado.org.br (mail.eldorado.org.br [200.168.210.67])
	by alsa0.perex.cz (Postfix) with SMTP id 2A476243C3
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 19:42:09 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <5b7270f40705251040r56bee4dfqdb2e66fd2b7fbdcd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zoltan Devai <zdevai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----Original Message-----
From: Zoltan Devai [mailto:zdevai@gmail.com] 
Sent: sexta-feira, 25 de Maio de 2007 14:40
To: Jose Henrique Spahn Torres
Subject: Re: [alsa-devel] [RFC] [PATCH 0/2] ASoC sound support
forSMDK2440boards

2007/5/25, Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>:
> > 2007/5/24, Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>:
> usbcore: registered new interface driver hci_usb Advanced Linux Sound 
> Architecture Driver Version 1.0.14rc4 (Wed May 16
> 09:45:46 2007 UTC).
> ASoC version 0.13.1
> SMDK2440 ALSA SoC Audio driver
> UDA1341 SoC Audio Codec
> L3 write
> L3 transfer
> L3 sendbyte: 16
> L3 sendbyte: 40
> asoc: UDA1341 <-> s3c24xx-i2s mapping ok ALSA device list:
>   #0: SMDK2440 (UDA1341)
> TCP cubic registered
> ...

Fine.

> However, when triyng to play something I get this:
>
> asoc: machine hw_params failed
>
> This is in sound/soc/soc-core.c, line 494.
> I couldn't go any futher then this.
> Any hint?

This combination of processor, crystal and codec only supports the
following rates:
11.025 Khz, 22.050Khz and 44.100 Khz

Please try to play a file with these sample rates.
(If you have alsa-tools, you could try 'speaker-test -r 44.100').

BTW, could you tell me the freq of the crystal on the processor board ?
(Is it 16.934 Mhz?)

Zoltan


Hi,

I used speaker-test as indicated above and the result is:

pendrive $ ./speaker-test -r 44100

speaker-test 1.0.11

Playback device is default
Stream parameters are 44100Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: -2,No such file or directory

I have also tried:

/pendrive $ ./aplay -f cd 01-jack_johnson-times_like_these-rns.wav
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:547: audio open error: No such file or directory
/pendrive $

so I don't know what is happening here.
Does anyone have any idea?

Thanks,
Henrique
