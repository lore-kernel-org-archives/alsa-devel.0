From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: struct snd_pcm_hardware_t values
Date: Sun, 6 Aug 2006 20:38:53 +0200
Message-ID: <d9def9db0608061138o100b5b78yead3623f655ec60b@mail.gmail.com>
References: <d9def9db0608050609t3683aba9ja80690a8758098e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8983317E
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 20:38:54 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so554737pya
	for <alsa-devel@alsa-project.org>; Sun, 06 Aug 2006 11:38:53 -0700 (PDT)
In-Reply-To: <d9def9db0608050609t3683aba9ja80690a8758098e1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I did some more investigation uppon this
>     .buffer_bytes_max = (32*1024),
this one seems to be clear now, I set it to the max
transfer_buffer_size of 1 URB
>     .period_bytes_min = 64,
this one not .. in my case I set it to transfer_buffer_size/2
>     .period_bytes_max = 2048,
this one is again transfer_buffer
>     .periods_min = 1,
I set this one to 2 (people in IRC cleared me up about this one)
>     .periods_max = 255,
no idea again..

So what I get now is:
http://lost-souls.mercuryserver.de/files/data/test.wav.mp3

and a buffer underrun regarding aplay
aplay -D hw:2,1 5_5_2006__07_00_59.wav
Playing WAVE '5_5_2006__07_00_59.wav' : Signed 16 bit Little Endian,
Rate 9600 Hz, Mono
underrun!!! (at least 0,307 ms long)
underrun!!! (at least 0,285 ms long)
underrun!!! (at least 0,295 ms long)
underrun!!! (at least 0,279 ms long)
underrun!!! (at least 0,298 ms long)
underrun!!! (at least 0,287 ms long)

the strange thing here is the DTMF tones in the background sound fine,
so I don't really recognize an underrun when playing the file just
that strange noise which is constant all the time..

following is what my debug prints in dmesg:
I'm sure the PCM PLAYBACK TRIGGER STOP! are caused by the buffer
underrun which is reported by aplay..
The outgoing dataformat is 9600hz, S16_LE, mono ..

memcpy3 384 - 0--
ed ff ee ff ed ff f3 ff f2 ff f5 ff fa ff fa ff ff ff ff ff
00 00 01 00 03 00 06 00 05 00 0b 00 11 00 13 00 11 00 13 00
14 00 14 00 18 00 18 00 1c 00 1e 00 1e 00 22 00 20 00 21 00
27 00 25 00 25 00 2b 00 2c 00 2d 00 2d 00 2f 00 34 00 32 00
30 00 34 00 38 00 35 00 37 00 3a 00 39 00 38 00 3b 00 3c 00
37 00 3e 00 3e 00 3f 00 42 00 3f 00 41 00 3f 00 45 00 49 00
46 00 48 00 46 00 46 00 49 00 4c 00 4d 00 4b 00 4d 00 4b 00
4d 00 4e 00 4b 00 4d 00 4b 00 4f 00 53 00 4f 00 4b 00 4b 00
51 00 51 00 50 00 53 00 51 00 55 00 54 00 52 00 56 00 53 00
55 00 57 00 52 00 55 00 55 00 55 00 53 00 52 00 55 00 54 00
57 00 56 00 53 00 56 00 55 00 57 00 55 00 54 00 55 00 56 00
56 00 54 00 55 00 52 00 54 00 54 00 52 00 53 00 53 00 53 00
53 00 53 00 52 00 52 00 52 00 51 00 51 00 4f 00 4d 00 50 00
4f 00 4e 00 4f 00 51 00 50 00 4f 00 50 00 4d 00 4c 00 4e 00
4c 00 4c 00 4d 00 47 00 48 00 4c 00 49 00 4b 00 46 00 46 00
49 00 42 00 45 00 48 00 46 00 44 00 46 00 45 00 42 00 45 00
43 00 3e 00 3f 00 40 00 3d 00 3d 00 3d 00 3b 00 3e 00 40 00
39 00 3a 00 3b 00 35 00 36 00 36 00 36 00 33 00 35 00 37 00
34 00 30 00 2e 00 33 00 2e 00 2f 00 30 00 2d 00 2e 00 29 00
2b 00 2a 00
PCM PLAYBACK TRIGGER STOP!
--- PERIOD ELAPSED 0 1676736 96 --
snd_au600_prepare
PCM PLAYBACK TRIGGER START!
playback hwptr: 0 transfer_done: 1676928  192 psize: 96 stride: 2
hwptr too big: 192 - 192
memcpy3 384 - 0--
29 00 2a 00 29 00 28 00 27 00 25 00 22 00 26 00 24 00 21 00
21 00 1d 00 1d 00 1d 00 1e 00 1e 00 1d 00 1c 00 1a 00 1d 00
1c 00 18 00 19 00 13 00 15 00 16 00 10 00 13 00 13 00 11 00
10 00 0f 00 0c 00 0c 00 0b 00 09 00 0a 00 0b 00 0b 00 08 00
07 00 09 00 07 00 04 00 02 00 01 00 00 00 fe ff fb ff fb ff
fd ff fc ff fb ff f8 ff f8 ff fa ff f5 ff f3 ff f3 ff f4 ff
f4 ff f0 ff f1 ff f1 ff ee ff ee ff eb ff eb ff ec ff e7 ff
e8 ff e5 ff e3 ff e4 ff e4 ff e3 ff e1 ff e4 ff df ff dd ff
de ff da ff dc ff dc ff d9 ff d8 ff d8 ff d5 ff d3 ff d4 ff
cd ff d4 ff d3 ff cb ff d0 ff cc ff cc ff cc ff ca ff cc ff
c5 ff c6 ff c9 ff c5 ff c2 ff c1 ff c0 ff c3 ff c1 ff bf ff
bf ff bf ff be ff bc ff bb ff b9 ff b9 ff b6 ff b5 ff b7 ff
b3 ff b2 ff b2 ff af ff b0 ff b1 ff ac ff af ff ab ff a6 ff
ab ff a6 ff a7 ff a9 ff a6 ff a4 ff a1 ff a3 ff ac ff 04 01
f3 08 02 19 6b 22 d5 19 91 06 ab f3 83 ec 13 f3 cc fe 05 06
2b 02 d6 f7 e6 f0 8e f5 25 05 aa 15 11 1b 62 0f 69 f8 8b e3
df dd 4d ea 23 01 4f 14 b3 18 29 0e d1 fd db f3 cc f5 72 ff
b0 06 cb 03 c8 f7 14 ec 37 eb ba f8 18 0e 9a 1d 88 1c 6c 0a
b3 f1 5a e1 5d e2 7f f2 97 06 e3 11 f9 0e 13 03 0c f9 02 f9
09 02 19 0b
PCM PLAYBACK TRIGGER STOP!
--- PERIOD ELAPSED 0 1676928 96 --
snd_au600_prepare
PCM PLAYBACK TRIGGER START!
playback hwptr: 0 transfer_done: 1677120  192 psize: 96 stride: 2
hwptr too big: 192 - 192
memcpy3 384 - 0--
etc.

Any help that could lead me further is appreciated...

thanks,
Markus

On 8/5/06, Markus Rechberger <mrechberger@gmail.com> wrote:
> Hi,
>
> a half year ago I bought an au600 device
> (http://alsa.opensrc.org/au600) and it's still not supported... I made
> some progress uppon the driver but there are still a few issues left.
>
> does anyone know about the snd_pcm_hardware_t struct?
> I'm not sure what values I should fill in there...
> My current driver supports a choppy kind of playback and capturing choppy
> audio.
> If I use following values in the struct my box locks up when the audio
> stream is over (uninitialized buffer for sure)
> static snd_pcm_hardware_t snd_au600_hw = {
>     .info = SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
> SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP_VALID,
>     .formats = SNDRV_PCM_FMTBIT_S16_LE,
>     .rates = SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS,
>     .rate_min = 9600,
>     .rate_max = 9600,
>     .channels_min = 1,
>     .channels_max = 1,
>     .buffer_bytes_max = (32*1024),
>     .period_bytes_min = 64,
>     .period_bytes_max = 2048,
>     .periods_min = 1,
>     .periods_max = 255,
> };
>
> If I set the values lower it doesn't crash anymore but afterwards the
> stream sounds garbled.
>
> The streamformat itself is PCM, 9600hz, 16Bit, mono, S16_LE (capturing
> as well as playback)
>
> Markus
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
