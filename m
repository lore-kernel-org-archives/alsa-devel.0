From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Question to sophisticated alsa developer
Date: Wed, 5 Aug 2009 08:46:42 -0400
Message-ID: <9e4733910908050546w3c268db9h7ccd4fa37ecd0099@mail.gmail.com>
References: <4A796779.6030204@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 1288B24418
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 14:46:43 +0200 (CEST)
Received: by yxe6 with SMTP id 6so67712yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 05:46:43 -0700 (PDT)
In-Reply-To: <4A796779.6030204@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <biessmann@corscience.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 5, 2009 at 7:05 AM, Andreas Bie=DFmann<biessmann@corscience.de>=
 wrote:
> Hi all,
>
> I currently test alsa playback on AVR32 board with atmel's abdac driver.
> My environment is 2.6.30.4 customized kernel (customization for my own
> board), rootfs and toolchain made of customized buildroot from atmel. I
> use alsa-lib 1.0.20 with patch [1] applied and alsa-utils with patch [2]
> applied. The alsa code does compile and work fine (aside from my problem
> described some lines later).
>
> My test case is a sine wave file with 440Hz tone, samplerate is 17089
> (cause of samplerate abdac driver offers and to avoid resampling in
> alsa-lib) playing with aplay. This works fine, I see a 440Hz sine wave
> on my oscilloscope and there is no effect as described later on.
>
> My problem is when I'm enabling dmix layer to run concurrent aplay
> processes I always get a click at the end of my last played sine wave
> file. My Oscilloscope shows me that there is sometimes a short part of a
> single or somtimes multiple sine period(s) moved down (or up) to mid
> value (I can supply a screenshot of oscilloscope, if this description is
> not clear enough). Mostly this effect is about 500 us long. The sine
> wave is missing the information at this position, it is no delay of the
> analog value at this position. If I overlay a correct sine wave the
> following part after the problematic position matches exactly the
> overlayed sine wave.
> I investigated that this problem always occur somewhere at the end of
> dmix. When I play a long "null" sample and start repeated play of my
> short sine wave sample the effect is not there while the null sample is
> playing. After ending of null sample the described effect appears
> instantly on each end of my repeated test sample.

This sounds like the same problem I am having on the mpc5200. On a
batch DMA driver there is a latency after the last sample plays.

When the last sample plays it generates an interrupt. ALSA sends a
STOP back after this interrupt. But the audio hardware continues
playing between this interrupt and receiving the STOP. Since the last
valid sample generated the interrupt, the hardware is playing garbage
(stale data) while waiting on the STOP. Probably  500us worth of stale
data.,

Look at how the mpc5200 driver checks appl_ptr to keep from playing
off the end of valid data. Note that there are a couple of pending
patches trying to get this logic right in the mpc5200 driver.


>
> Here is my asound.conf to enable dmix layer for alsa:
>
> ---8<---
> pcm.!default {
> =A0 =A0 =A0 =A0type plug
> =A0 =A0 =A0 =A0slave.pcm "dmixer"
> }
>
> ctl.mixer0 {
> =A0 =A0 =A0 =A0type hw
> =A0 =A0 =A0 =A0card 0
> }
>
> pcm.!plughw {
> =A0 =A0 =A0 =A0type plug
> =A0 =A0 =A0 =A0slave.pcm "dmixer"
> }
>
> pcm.dmixer {
> =A0 =A0 =A0 =A0type dmix
> =A0 =A0 =A0 =A0ipc_key 1024
> =A0 =A0 =A0 =A0slave {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pcm "hw:0"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0format S16_BE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate 17089
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0bindings {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 1
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0slowptr false
> }
>
> ctl.dmixer {
> =A0 =A0 =A0 =A0type hw
> =A0 =A0 =A0 =A0card 0
> }
> --->8---
>
> Maybe there is already a bloomer in.
>
> I have tried to change slowptr stuff in pcm.dmixer without any effect to
> my problem. I also tried to change buffer sizes in dmixer's slave but
> these changes had no effect.
>
> I also tried some changes in kernel driver for ABDAC. I played a bit
> with periods_min and period_bytes_min without effect to my problem. The
> buffer_size in "Direct Stream Mixing PCM" is fixed to the value in
> "hw:0". But if I double the periods_min in Kernel (default: 6
> periods_min, 64 periods_max) for "hw:0" the maximum value for
> buffer_size in "Direct Stream Mixing PCM" is fixed to 8192. The "Route
> conversion" layer has always the buffer_size value of the next layer.
> This is 8192 for doubled periods_min in kernel and dmix enabled and
> 12288 for doubled periods_min and dmix disabled. Any advice to this
> "feature"?
>
> Here is the output of aplay -v for dmix enabled:
>
> ---8<---
> # aplay -v sin_440_17089_1sec.wav
> Playing WAVE 'sin_440_17089_1sec.wav' : Signed 16 bit Little Endian,
> Rate 17089 Hz, Mono
> Plug PCM: Route conversion PCM (sformat=3DS16_BE)
> =A0Transformation table:
> =A0 =A00 <- 0
> =A0 =A01 <- 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : RW_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_LE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 1
> =A0rate =A0 =A0 =A0 =A0 : 17089
> =A0exact rate =A0 : 17089 (17089/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 8192
> =A0period_size =A0: 1024
> =A0period_time =A0: 59921
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 1024
> =A0period_event : 0
> =A0start_threshold =A0: 8192
> =A0stop_threshold =A0 : 8192
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1073741824
> Slave: Direct Stream Mixing PCM
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : MMAP_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_BE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 2
> =A0rate =A0 =A0 =A0 =A0 : 17089
> =A0exact rate =A0 : 17089 (17089/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 8192
> =A0period_size =A0: 1024
> =A0period_time =A0: 59921
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 1024
> =A0period_event : 0
> =A0start_threshold =A0: 8192
> =A0stop_threshold =A0 : 8192
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1073741824
> Hardware PCM card 0 'Atmel ABDAC' device 0 subdevice 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : MMAP_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_BE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 2
> =A0rate =A0 =A0 =A0 =A0 : 17089
> =A0exact rate =A0 : 17089 (17089/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 12288
> =A0period_size =A0: 1024
> =A0period_time =A0: 59921
> =A0tstamp_mode =A0: ENABLE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 1024
> =A0period_event : 0
> =A0start_threshold =A0: 1
> =A0stop_threshold =A0 : 1610612736
> =A0silence_threshold: 0
> =A0silence_size : 1610612736
> =A0boundary =A0 =A0 : 1610612736
> =A0appl_ptr =A0 =A0 : 0
> =A0hw_ptr =A0 =A0 =A0 : 0
> --->8---
>
>
> And here the output of aplay -v without dmix:
>
> ---8<---
> # aplay -v sin_440_17089_1sec.wav
> Playing WAVE 'sin_440_17089_1sec.wav' : Signed 16 bit Little Endian,
> Rate 17089 Hz, Mono
> Plug PCM: Route conversion PCM (sformat=3DS16_BE)
> =A0Transformation table:
> =A0 =A00 <- 0
> =A0 =A01 <- 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : RW_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_LE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 1
> =A0rate =A0 =A0 =A0 =A0 : 17089
> =A0exact rate =A0 : 17089 (17089/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 12288
> =A0period_size =A0: 1024
> =A0period_time =A0: 59921
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 1024
> =A0period_event : 0
> =A0start_threshold =A0: 12288
> =A0stop_threshold =A0 : 12288
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1610612736
> Slave: Hardware PCM card 0 'Atmel ABDAC' device 0 subdevice 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : MMAP_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_BE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 2
> =A0rate =A0 =A0 =A0 =A0 : 17089
> =A0exact rate =A0 : 17089 (17089/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 12288
> =A0period_size =A0: 1024
> =A0period_time =A0: 59921
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 1024
> =A0period_event : 0
> =A0start_threshold =A0: 12288
> =A0stop_threshold =A0 : 12288
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1610612736
> =A0appl_ptr =A0 =A0 : 0
> =A0hw_ptr =A0 =A0 =A0 : 0
> --->8---
>
> Well, currently I have no more ideas where to dig for my problem. I do
> need a mixing layer to allow two or three concurrent aplay instances at
> the same time but the output in this case is (atm) worse. Has anyone
> some advice where to search for a solution to my problem. Or has anybody
> some advice to use another feature of alsa to allow concurrent aplay
> processes?
>
> regards
>
> Andreas Bie=DFmann
>
> [1]
> http://git.buildroot.net/buildroot/tree/package/multimedia/alsa-lib/alsa-=
lib-1.0.18-avr32-bad-inline.patch
>
> [2]
> http://git.buildroot.net/buildroot/tree/package/multimedia/alsa-utils/als=
a-utils-1.0.18-fix-intl-support.patch
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
