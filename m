From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in    statePREPARED?
Date: Tue, 17 Sep 2002 11:03:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209170903.g8H93s028326@d1o87.telia.com>
References: <Pine.LNX.4.33.0209131137140.521-100000@pnote.perex-int.cz> <200209162014.g8GKEc014124@d1o87.telia.com> <3D86E3ED.5C06BCB1@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D86E3ED.5C06BCB1@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 September 2002 10.12, you wrote:
> Please use technical argumentations: pseudo statistical and
> subjective ones does not worth a lot.

Actually, that is exactly the type of argumentation you use yourself. 
It is not anything wrong with that either. It is always subjective why 
a certain technical behaviour is a better one than others.

And, I still think a good design rule is to make it behave like it 
traditionally behaves, so experienced programmers will get the expected 
behaviour.

> > "If the sound card output buffer is full of data, and it is not
> > running, what would happen if you poll that file descriptor for
> > writing"
> >
> > 1) it will block, because it is not ready for writing
> > 2) it would not block, because it would then block forever
>
> 2 is better because the programmer can know the reason of failure.
> With 1 the programmer will not receive enough info to detect it (also
> using a timeout)

This is the only reason I've heard for this feature, that it makes 
problems easier to detect. That you can easier detect a bug in a 
program. There is thus actually no functional use. Could you give me 
another argument than this bug detection thing why the current 
behaviour is useful?

However, I actually think that the current behaviour makes it *harder* 
to detect the bug. It was for me. I got XRUN on the output process so I 
thought there was some problem with buffer underrun, and wondered if 
the card had started automatically anyway and searched for problems 
there.

A deadlock is instead easy to detect. Attach with gdb and see where it 
has blocked, and from that it is easy to understand, well, this file 
descriptor never gets ready for writing, so the sound card cannot be 
running. Blocking indicates one error. XRUN indicates more than one.

> > "If you write to a non-blocking sound card output file descriptor,
> > but the buffer is full, and the sound card is not running, what
> > will then happen?"
> >
> > 1) it will return with errno set to EAGAIN, because it is not ready
> > for writing
> > 2) it will return with errno set to EPIPE, because there is a
> > buffer overflow
>
> 2 is better because EAGAIN would be returned also if buffer is
> *temporarily* full.
> Consider also that "retry again later" is definitely a misleading
> hint.

You can think so, but if there is another thread, it is not true. Also, 
this is how other file descriptor works, they are exactly as mean. 
Making ALSA "nicer" in your opinion will just confuse programmers who 
know how file descriptors work in Unix.

And still, your argument is still only for bug detection, and a bug 
causing this problem is easy to detect with the established file 
descriptor behaviour.

> Please understand that it's very hard to satisfy everybody and I'm
> not sure it's a worthy goal.

Satisfy most people and do good design is a worthy goal I think. My 
(and others) arguments are mainly these:

1) File descriptors should have the standard behaviour, because 
programmers expect it, and will then not confuse dead-lock bugs with 
overflows.
2) The standard behaviour has a use, blocking on write, starting the 
card from another thread or process.
3) It is good design to use established behaviours. Now the established 
behaviour also gives functional and advantages in use, so it should be 
a straight-forward decision.

> That apart, I'm very interested to hear further technical reason to
> change current behaviour.

Yes, I'm very interested in further reasoning as well. I am firm but 
humble, I can change my mind, but so far I have not seen any convincing 
arguments for having a special behaviour for ALSA file descriptors.

/Anders Torger


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
