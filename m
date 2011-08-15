From: Joerg-Cyril.Hoehle@t-systems.com
Subject: How to pair Wine with ALSA? part2: buffer&period size
 / blocking / mmap (long)
Date: Mon, 15 Aug 2011 17:57:36 +0200
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A41392BAD31D@HE113481.emea1.cds.t-internal.com>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB4724E@HE113481.emea1.cds.t-internal.com>
	<4E47BE26.7060705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail83.telekom.de (tcmail83.telekom.de [62.225.183.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 8567924697
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 17:57:45 +0200 (CEST)
In-Reply-To: <4E47BE26.7060705@ladisch.de>
Content-Language: de-DE
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
Cc: clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

[I've reordered some paragraphs]

Clemens Ladisch wrote:
>AFAIK the WinMM API allows to vary the number and size of submitted
>buffers arbitrarily even while the stream is running.
The API is simply like pcm_write: "here are N frames at address X".
The app allocates and owns the buffer memory at address X.

>This was designed for hardware that is reprogrammed after each buffer
>anyway (ISA DMA) or that allows dynamic buffers (e.g. ICH AC'97, which
>was designed for WinMM).
You mean that HW can be told: "play N1 frames at address X1, to be
followed without glitch with N2 frames at address X2"?  And
afterwards, "after you'll be done with X2, play N3 at address X3"?

This is very interesting.  All I knew about were circular buffers.
Hence in my mind, every API where the app supplies the data pointer
would require copying from the app buffers into the circular HW one.

>Can't you hand out a pointer to ALSA's buffer?
I am not aware of any way outside snd_pcm_mmap_begin to obtain a
pointer from ALSA.  Perhaps that's the base of my misunderstandings?

>What exactly gets optimized with mmap?  Please note that snd_pcm_write*
>copies the data from the supplied buffer into ALSA's buffer; if your
>code does the same, it is not the slightest bit faster.
I'm not sure I understand what you mean.

The mmdevapi is unlike WinMM: GetBuffer yields a buffer pointer from
the OS and has some timing restrictions (unclear to me, MSDN talks
about "buffer-processing periods").  Not unlike snd_pcm_mmap_begin.
This pointer could be the audio HW's write_ptr.

Hence in theory, as the app asks mmdevapi for a buffer and fills it,
it can be played by the OS/HW (following ReleaseBuffer, sort of
snd_pcm_mmap_commit) without additional copying.  Thus, mmdevapi is
not in the way of such optimizations with either HW ring-buffer or
the dynamic buffers you mention, whereas WinMM cannot avoid copying
with ring-buffers.

What's expected to happen in Wine without mmap is:
1. app copies/writes data into Wine-managed GetBuffer pool
1.b because of ring-buffer management, there's even a little
    more copying in case of wrap-around.
2. ALSA pcm_write* copies from Wine's pool into HW buffer.

The optimization is:
0. app gets pointer from Wine's GetBuffer, which
   in turn gets it from ALSA's snd_pcm_mmap_begin.
1. app copies/writes data into ALSA's HW buffer.

The current state is even worse w.r.t. WinMM:
1. app copies/writes data into app buffers for use by WinMM.
2. Wine's WinMM copies data into Wine's mmdevapi buffer via GetBuffer.
3. pcm_write* copies data into ALSA's HW buffer.

Well, that's a lot of text about a situation that's becoming less and
less likely.  Desktop reality is: all apps (incl. video) use a mixer
(dmix/PA/upmix) and data still needs to be mixed: no app writes into
the audio HW ringbuffer.  I'm not sure PA or dmix support mmap.


>   set_periods_near(3) / avail_min / periods explanations;
Thank you very much.  The explanation is very welcome as the ALSA doc
did not make it all clear to me.


>This suggests to use a buffer as big as possible (for the hardware).

I'm a little reluctant about that since I've myself experienced some
apps in Wine that exhibited extreme loss of sync between audio and
video when PA was in the queue instead of dmix.  I don't know what the
reason is but for sure I will test those again as I make progress.

I have no idea what one of those apps used for synchronisation.
mmdevapi did not exist at the time the app was written.
 - Did it use dsound?  I know next to nothing about that other API.
 - Did it use WinMM:waveOutGetPosition?
 - How is waveOutGetPosition defined in the presence of huge
   latencies, i.e. is it implicitly based on a ~0 latency assumption?
 - When are buffers submitted to waveOutWrite returned to the app?
   a) After the front-end processed them (sent them to the next stage)?
   b) After the back-end (speaker) played the last sample in it?
   The difference matters only as non-zero latencies are introduced into
   the audio chain, i.e. with networking, USB or simply PA's 2s buffers.
That's about WinMM.
mmdevapi defines its API much more precisely -- lesson learned.

Note that I don't think that b) can be retro-fitted into a system with
huge buffering (e.g. network, USB or PA buffers), because numerous
apps simply work like this: allocate 3 buffers of 1/3 second worth of
samples each and play them in turn.  With 5s latency that breaks.
Hence Wine may need to implement a combination of both:
   c) After the front end processed them *and* they would have been
      played by a zero-latency system, e.g. HW ring-buffers.


>You can call nonblock(0) immediately after open.
>But if your code never actually blocks, why bother to set it?

Somebody reported and I've verified that snd_pcm_drain would always
fail (with -11 IIRC) in non-blocking mode.  It's understandable as an
afterthought since the API says "wait for ..." which violates
non-blocking.  Only snd_pcm_drop works in non-blocking mode.


>Now you are trying to do what PulseAudio does.
No surprise. Every audio framework does something similar.

>Why not simply use PA instead of ALSA?
It is my understanding that the Wine project will maintain at least 4
drivers eventually, including PA.  However, for the time being, it
starts with 3: ALSA/OSS/MacOS' CoreAudio.  It is only when these will
work well enough (and the dynamic constraints on the mmdevapi be
understood/known well enough) that another one will be added AFAIK.
We are not there yet.

Thank you very much for your help and explanations,
	J=F6rg H=F6hle
