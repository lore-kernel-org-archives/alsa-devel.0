From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Thu, 30 Oct 2008 11:46:31 +0100
Message-ID: <5501535d0810300346m240fb9a2u206e90e6bb4c6b07@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk>
	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
	<s5h7i7v22cl.wl%tiwai@suse.de> <ge3irb$knf$1@ger.gmane.org>
	<49055255.8030102@gmail.com> <s5h63ne1rh8.wl%tiwai@suse.de>
	<5501535d0810271710y246926f2xdd8a3f31719c6af3@mail.gmail.com>
	<s5h4p2x6vk2.wl%tiwai@suse.de>
	<5501535d0810280648l7d83505bp3f980bc75da9201c@mail.gmail.com>
	<s5h7i7sdd09.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id D938824336
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 11:46:32 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so488909rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 03:46:31 -0700 (PDT)
In-Reply-To: <s5h7i7sdd09.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2008 at 15:12, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 28 Oct 2008 14:48:01 +0100,
> Bjoern Olausson wrote:
>>
>> On Tue, Oct 28, 2008 at 08:14, Takashi Iwai <tiwai@suse.de> wrote:
>> >
>> > Forgot to ask: which SBXFI model?  The product name, PCI ID, PCI SSID,
>> > and /proc/asound/cards entry please.
>> >
>> 01:00.0 0401: 1102:0005
>>         Subsystem: 1102:0021
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
>>         Interrupt: pin A routed to IRQ 21
>>         Region 0: I/O ports at 8c00 [size=32]
>>         Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=2M]
>>         Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=64M]
>>         Capabilities: [40] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
>> Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>>         Kernel driver in use: SB-XFi
>>
>> 01:00.0 Multimedia audio controller: Creative Labs SB X-Fi
>>         Subsystem: Creative Labs X-Fi Platinum
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
>>         Interrupt: pin A routed to IRQ 21
>>         Region 0: I/O ports at 8c00 [size=32]
>>         Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=2M]
>>         Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=64M]
>>         Capabilities: [40] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
>> Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>>         Kernel driver in use: SB-XFi
>>
>>
>> >
>> >> 2. base_rate value
>> >>       rate: 96000 (96000/1)
>> >
>> > What about base_rate=48000?
>> >
>> > BTW, I changed now base_rate to 48000 for testing as I got more
>> > positive results with it.
>> >
>> Should I pass this parameter during ./configure or as module parameter?
>
> As a module parameter, either in somewhere modprobe.conf or such, or
> via modprobe command line option.
>
> I changed the latest version to use 48k as default, so you can just
> grab the latest snapshot, too.
>
>> >> A)    MPlayer dev-SVN-r27725-4.1.2
>> >> B)    Working, but horrible, crackeling sound at samplingrate 11025Hz
>> >> 22050Hz 44056 44100 47250 5000(less than the others) 50400 8000 88200
>> >> (3200, 48000 and 96000 are fine)
>> >>       checked with WindowsXP. In XP the sound is nice and clear. So the
>> >> files are good.
>> >> C)    OSS (see bug-mplayer file)
>> >> D)    See bug-mplayer file
>> >> E)    nothing
>> >
>> > What if you do the following (as root)?
>> >
>> >        # echo "mplayer 0 0 direct" > /proc/asound/card0/pcm0p/oss
>> >
>> Tested... but gives only white noise, no matter what samplingrate or file....
>
> Weird.  What happens if you force to the sample rate to 48000 via
> mplayer's option?
>
>
> Takashi
>

Sry for the delayed testing, but my "Diplomarbeit" has to be finish on
Monday... so I am a bit in a hurry...

But anyway:

Tested 10/30/2008 07:05:00 AM
712e4debd7b0c84ee68342cdc56ae8bdb0119b75 Merge commit 'stable/master'
0f6ba093f8aa7a9e2caff2a697edcfeaddd4e0a1 Remove __attribute__ form
dev_set_name() wrapper
1aec09cd650c40b93eb1956ff8396e61a52ccef3 Merge commit 'stable/master'
277a3f5f74b6ff1f7cb719f7bfbb2ccdde252cf2 Add dev_name() and
dev_set_name() wrappers
e3d42c6eae1ea6d43af6223d9338adf75e63f841 Merge branch 'topic/tools'
ff936f865a57e68289d6bd4b8da74670bf04a378 Remove topic/snd-hrtimer branch
1bf544cf592b7c2270ba1c28e67067d9c244e0e9 Merge commit 'stable/master'
d9aebb8d6130d1fc33a9ac4be62550914b2b0559 Merge branch 'topic/snd-hrtimer'
4f169e7e1cfa7a85e15920cda84eb7a8e80acf81 Add snd-hrtimer build stub
f5d186ece18e1b0b992ccb870827a6b618c6c6df Merge commit 'stable/master'


First the good news:
mplayer does play all samplerates very clear! Pure, lovely sinus ;-)
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
OSS format: S16_LE
OSS channels: 2
OSS rate: 48000
OSS period bytes: 4096
OSS periods: 16
OSS period frames: 1024


Now the bad:

Xine does not work... crackles horrible on all sample rates when run from cmd:
xine 0_16_m_11025.wav

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 2048
buffer_size: 16384

kind regards
Bjoern
