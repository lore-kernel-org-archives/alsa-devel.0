From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Sun, 13 Dec 2009 12:01:31 +0800
Message-ID: <4f3252890912122001i187fc0dbj86a8ea1d9a4e115f@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de> <hfodrt$ouf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DAFBE103815
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 05:01:33 +0100 (CET)
Received: by pwi18 with SMTP id 18so4291566pwi.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 20:01:32 -0800 (PST)
In-Reply-To: <hfodrt$ouf$1@ger.gmane.org>
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

2009/12/9 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Takashi Iwai at 09/12/09 13:46 did gyre and gimble:
> >> PA only adjust the watermark/sleeping time in one direction only
> >
> > Yes.
>
> Actually there is code in PA to move the watermark in both ways, but
> obviously reverting it backtowards the "underrun zone" is a bit
> dangerous, so can't be just a simple "reduce it" back.
>
>
> http://git.0pointer.de/?p=pulseaudio.git;a=commit;h=050a3a99e1d151b4f55c89f82073ef33f3399646
>
> I can't remember the current status (i.e. if the code is disabled or
> not) but AFAICT it's enabled.
>
> Col
>


What is hwbuf_unused in the watermark calculation ?

Refer to *Image 1:* *Schematic overview of the playback buffer in the
traditional playback model, in the best way the author can visualize this
with his limited drawing abilities.*

http://0pointer.de/blog/projects/pulse-glitch-free.html

When the alsa application using 4 periods , the alsa driver is about 75%
full at all time. The data remain in the buffer is many time of the minimum
period bytes ( 32 bytes in the case of intel8x0 )

1) It seem that 32byes is the PCI brust size ? ( hda driver seem has 128
bytes and usb driver ....)

PulseAudio <= 0.9.10 uses a fragment size of 25ms by default, with four
fragments.

Glitch Free mode

If no client specified any requirements we fill up the whole buffer all the
time, i.e. have an actual latency of 2s. However, if some applications
specified requirements, we take the lowest one and only use as much of the
configured hardware buffer as this value allows us. In practice, this means
we only partially fill the buffer each time we wake up. Then, we configure a
system timer to wake us up 10ms before the buffer would run empty and fill
it up again then. If the overall latency is configured to less than 10ms we
wakeup after half the latency requested.

Correct me If I am wrong

1) The function of alsa-plugin is to emulate an ALSA device

2) The hardware pointer of this pulse device is the application pointer of
the pulseaduio server

3) If PA server did not write any thing up when the timer wake up, this mean
that the hardware pointer of  the pulse device also stop moving.

>From the viewpoint of the alsa application , the pulse device is also
inaccurate


   1. hwptr 2858101 buffer 16384 appl 2874469, avail=16
   2. D: alsa-sink.c: avail: 64 (samples 16)
   3. D: alsa-sink.c: 371.16 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   4. D: alsa-sink.c: Not filling up, because too early.
   5. D: alsa-sink.c: Wakeup from ALSA!
   6. D: alsa-sink.c: Loop
   7. D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 351 ms; Process time:
   20 ms
   8. hwptr 2874490 buffer 16384 appl 2874469, avail=16405

4) why did alsa-time-test using pulse device , abort immediately

 ./alsa-time-test pulse
alsa-time-test: alsa-time-test.c:46: main: Assertion `r == 0' failed.
Aborted
