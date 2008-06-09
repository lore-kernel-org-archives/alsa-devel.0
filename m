From: Lennart Poettering <mznyfn@0pointer.de>
Subject: What does snd_pcm_delay() actually return?
Date: Mon, 9 Jun 2008 21:02:25 +0200
Message-ID: <20080609190225.GA4534@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A2B8103848
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 21:02:26 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi, Jaroslav,

could you please explain what exactly snd_pcm_delay() returns? 

Some applications (such as WINE) assume it is the time that would pass
until we reach an underrun if we would stop writing any further data
to the PCM device.

Other applications (such as most media players) use it for time
synchronisation. i.e. assume that it is the time that passes until a
sample I write to a PCM device now would take to be played.

Why does this make a difference? For all drivers/ioplug backends where
audio is not directly written to the hardware buffer of the audio
device the underrun might happen much earlier than the last sample
written is heard. This seems to be the case of USB audio for
example. If I fill up the hw buffer completely, I will be notified
about a buffer underrun much earlier than the buffer size would
suggest. 

Another example is the PulseAudio backend: for each client stream we
maintain a private playback buffer. After that buffer there is the
hardware buffer.  If the client buffer runs empty we'd like to signal
an underrun. However, in that situation it still will take some time
until the underrun is really hearable, because the audio first has to
pass the second buffer in line, the hardware buffer.

Or in other words: in some backends (PCI/DMA) after a sample is read
from the ALSA playback buffer and the read index is increased it is
immediately heard. In others it will still take substantial time until
it is heard. The current API doesn't expose any information about how
long that additional time can be, and it is not clear if
snd_pcm_delay() includes or does not include this extra time in its
result.

The ALSA documentation claims that snd_pcm_delay() returns the
"distance between current application frame position and sound frame
position". That would point that WINE's interpretation is
correct. (i.e. ignore the extra time)

However, the USB audio driver actually seems to return the total time
delay as it is useful for synchronization, so follows what media
players expect. (i.e. take the extra time into account)

I personally believe that the USB audio driver does it right because
the most important use for snd_pcm_delay() is to achieve
synchronization between audio and video. However, the other value is
very important too. Not just for WINE, but also for my own work,
PulseAudio.

Most of the time the small difference between those two values doesn't
really matter, since the difference is very small and for classic
PCI/DMI devices zero. However, with USB I am now encountering this
problem, because I cannot reliably estimate from the data ALSA supplies me
with when the next underrun would happen. Also, the WINE people
are pretty vocal that I am not right with my interepretation of the
sitaution.

Takashi, Jaroslav, could you please eleborate on this, and explain
which interpretation is the correct one?

Also, regardless which one is the correct one, could we please add a
second API function the allows clients to query the other value?

I have already raised this issue in differents words two times before
[1]. I never got a comment from you on this. So, please please with
cream on top, respond!

Thank you very much,

Lennart

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007354.html

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
