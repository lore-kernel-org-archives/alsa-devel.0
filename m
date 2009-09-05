From: Sophie Hamilton <sophie-alsa@theblob.org>
Subject: Problems with safe API and snd-cs46xx
Date: Sat, 5 Sep 2009 13:24:04 +0100
Message-ID: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 9549224405
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Sep 2009 14:24:09 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1173392bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 05 Sep 2009 05:24:06 -0700 (PDT)
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

Hi there,

I was pointed here by Audacious developers, who believe I've found a
bug in the snd-cs46xx driver, which I use for my sound card (a Turtle
Beach Santa Cruz, whose PCI ID is 1013:6003).

Audacious, as of version 2.1, uses the default period time offered by
ALSA and limits itself to the "safe API" as per Lennart Poettering.
This already uncovered a bug in the Aureal Vortex driver, and I
believe, based on the information that the devs gave me, that I have
just uncovered another. (I'm also having problems with recent versions
of OpenAL. However, I'll explain this further below.)

I first started having the problem after having upgraded to Audacious
2.1, from Audacious 1.5.1. (to be more precise, the Gentoo ebuild
1.5.1-r1.) At the time, I was using the Gentoo-patched 2.6.29-series
kernel, which I use as my normal kernel. After upgrading, I could no
longer play audio directly using ALSA; instead, Audacious would
initialise to 00:00, not play anything, and report the following to
the owning console every so often:

> ERROR: ALSA: alsa-core.c:226 (alsaplug_write_buffer): (write) snd_pcm_recover: Input/output error

The thread which was doing this also seemed to be blocking, as when I
tried to do anything else in Audacious, the interface would then
freeze until the thread was done. OSS output seems to be okay,
although as I don't have OSS compiled at all into the kernel (not even
as a module), this would be going via ALSA's own OSS emulation. In
addition, ALSA output to another audio device from Audacious works
fine.

I Googled for this and came across another snd-cs46xx user having the
exact same problem in bug AUD-53 in the JIRA implementation they were
using: http://jira.atheme.org/browse/AUD-53 . Since that user had been
asked to upgrade to tip but hadn't, I did so instead (uninstalling the
Gentoo ebuilds frst, of course) and reported back the additional debug
info:

> DEBUG: ALSA: alsa-core.c:226 (alsaplug_write_buffer): snd_pcm_writei error: Input/output error
> ERROR: ALSA: alsa-core.c:230 (alsaplug_write_buffer): snd_pcm_recover error: Input/output error

I then didn't know how to continue as I wasn't sure whether the bug
would be seen as it had previously been closed as unreproducible, so I
hopped onto the IRC channel and asked about what should be done. It
was there that the probability of it being a driver bug in the
snd-cs46xx sound driver was mentioned, and the reasoning - that the
use of ALSA's safe API has been exposing driver bugs that were
previously hidden.

As mentioned previously, I'm also having issues with OpenAL. The
version I'm using now is 1.7.411; previously I was using 1.5.304,
which I believe worked fine. (I can't easily test this now as the
Gentoo ebuild for it has gone, however.) The symptoms I got were
similar - I got no sound, and messages were printed to the console
every so often (more often than with Audacious, however):

> AL lib: alsa.c:194: Wait timeout... buffer size too low?

At first I thought this was an issue with Second Life, but on seeing
the exact same symptoms using mplayer with the '-ao openal' switch,
and also seeing it occur with 'openal-info', it seems to be an OpenAL
thing. (Since I don't have many apps that I use with OpenAL, I hadn't
known this before.) It seems that this is a symptom of whatever driver
bug is causing the Audacious error.

For the purposes of making this post, I decided to compile and install
a vanilla 2.6.30.5 kernel to boot into, so that I could make sure
there were no problems with the latest stable build. (I'd rather not
run unstable versions if I can help it, or I would have done so; this
is my primary machine. However, I'm willing to apply patches for this
specific problem in order to test them.)

The results of this were that I no longer get the messages and the
threads don't block, but I get entirely new problems now - instead of
useable sound, I get what sounds a little like noise, but more
crackly, and the seek bar in Audacious seems to be going along as fast
as it can - for each wallclock second, the seek bar goes up by about
114 seconds. The same occurs when I use mplayer with the '-ao openal'
switch; I get the noise/crackles, and the time position shown on the
console zooms by.

The description of my sound card given by 'lspci -vv' (under both
kernels) is thus:

> 05:04.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24/30 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
>         Subsystem: Voyetra Technologies Santa Cruz
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (1000ns min, 6000ns max)
>         Interrupt: pin A routed to IRQ 22
>         Region 0: Memory at fdafe000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: Memory at fd900000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: Sound Fusion CS46xx
>         Kernel modules: snd-cs46xx

Most applications that I have seem to work properly with regards to
audio, although I've heard that this is probably because ALSA's safe
API isn't very well documented and as such most applications will not
be using it, thus not exposing the bug in snd-cs46xx.

No information is output to dmesg when this happens, on either the
Gentoo-patched 2.6.29 kernel, or the vanilla 2.6.30.5 kernel.

If you need any further information, please let me know! As stated
above, I'm willing to apply patches to the vanilla sources of the
latest stable kernel in order to test them. I don't have experience of
downloading the ALSA drivers and compiling them separately but I could
also do that if it's needed.

Thank you,

 - Sophie.
