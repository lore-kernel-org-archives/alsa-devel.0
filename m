From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 12:34:19 -0400
Message-ID: <CA+7tXijRBYW8frA650=kXJOKnZ4nfAHQi18baLB+D3Zc867bGQ@mail.gmail.com>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C5010BAB1
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 18:34:20 +0200 (CEST)
Received: by wibhn9 with SMTP id hn9so640913wib.2
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 09:34:20 -0700 (PDT)
In-Reply-To: <20120510160601.GC12727@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 12:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The question is - what would cause ALSA to hammer away at the buffer
> like that - checking it every 16 or 8 DMA bytes transferred? =A0I'm also
> seeing around 75% system CPU time, which really isn't good.
>
> The above was captured while aplay was running, with no apparant audio
> corruption.

I've had this happen, but not with aplay.  I sent something to the
list a few months ago about it.

The problem is triggered when writing to ALSA with writes that are
unequal to the period size and using sampling rate conversion in an
ALSA plugin.  Code in alsa-lib will get into a loop calling poll() on
the pcm fd, and ALSA's poll() calls the pointer method to figure out
if there is enough buffer space free to return or if it poll() should
block.

That is all fine, but rather than write more data when poll() returns,
alsa-lib decides to call poll() again.  So it's stuck in a tight loop
calling poll() which isn't blocking.  Eventually there will be enough
space in the buffer that alsa will write some data and poll() will
block.

Basically poll() will return when there is at least X bytes available
in the buffer.  X =3D avail_min.  ALSA will only write more data when
there is at least Y bytes free in the buffer.  The bug is X < Y.  This
only happens when sample rate conversion and only if the app doesn't
call snd_pcm_writei() with full periods.  While the available space in
the buffer is > X and < Y, ALSA is in a tight loop calling poll()
which calls the PCM's pointer method.  If X =3D=3D Y, then this would
never happen.
