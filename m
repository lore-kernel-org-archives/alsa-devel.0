From: alsa@0x00.my-ho.st
Subject: Re: Maestro 2E (rev 10) not found or device busy w/
 0.9.2
Date: Fri, 25 Apr 2003 11:02:07 -0600 (MDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0304251036470.0@0x00.my-ho.st>
References: <Pine.LNX.4.50.0303261659330.8112-100000@0x00.my-ho.st>
 <s5hof3xnp8c.wl@alsa2.suse.de> <Pine.LNX.4.50.0303271039120.8112-100000@0x00.my-ho.st>
 <0304061234440.0@0x00.my-ho.st> <s5histpq7z0.wl@alsa2.suse.de>
 <0304081112590.0@0x00.my-ho.st> <s5hy92jpzd0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy92jpzd0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Apr 2003, Takashi Iwai wrote:

> At Tue, 8 Apr 2003 12:15:42 -0600 (MDT),
> alsa@0x00.my-ho.st wrote:
> >
> > >  (you can proceed the process there by
> > > replacing 0x8a05 to 0x0a05...)
> >
> > This change allows the driver to load, but:
>
> there are two places which check AC97_REC_GAIN.
> line 1980 and line 2064 in the latest cvs.
> you'll need to change both parts.

Thanks, that seemed to do the trick.  I did have to force the building of
the PC Speaker controls as well, but it seems to work okay now (the mixer
controls actually seem to work better than with the 'maestro' kernel
driver :)).

It does seem that something still isn't quite right though.  I'm getting
quite a few of these types of messages:

kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer
value (stream = 0, delta: -922, max jitter = 1024): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer
value (stream = 0, delta: -998, max jitter = 1024): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer
value (stream = 0, delta: -694, max jitter = 1024): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer
value (stream = 0, delta: -1094, max jitter = 8192): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer
value (stream = 0, delta: -972, max jitter = 8192): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer
value (stream = 0, delta: -688, max jitter = 8192): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer
value (stream = 0, delta: -1488, max jitter = 8192): wrong interrupt
acknowledge?
kernel: ALSA ../alsa-kernel/core/pcm_lib.c:215: Unexpected hw_pointer
value (stream = 0, delta: -532, max jitter = 8192): wrong interrupt
acknowledge?

I've also had the system hang once when unloading the ALSA kernel modules,
as well as very rarely seeing these messages:

kernel: spurious 8259A interrupt: IRQ7.
kernel: spurious 8259A interrupt: IRQ15.

Any thoughts on what might be the problem?  Thanks.

  - Ted


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
