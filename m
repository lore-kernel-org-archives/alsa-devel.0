From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in state PREPARED?
Date: Thu, 12 Sep 2002 13:48:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209121148.g8CBmv020843@d1o87.telia.com>
References: <200209111926.g8BJQr013561@d1o87.telia.com> <E17pDpC-0005FU-00@usw-sf-list1.sourceforge.net> <s5hadmnpik5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadmnpik5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 12 September 2002 13.13, you wrote:
> At Wed, 11 Sep 2002 16:14:19 -0400,
>
> Paul Davis wrote:
> > >Is it possible to adjust a stop threshold or something to get my
> > >desired behaviour?
> >
> > i think you should have set the start mode to START_DATA and the
> > start threshold appropriately. then the device would have started
> > as soon as the buffer was full.
>
> but this will make the driver to start the stream automatically.
> if you want to start explicitly by yourself, then it's not a
> concrete solution.
>
>
> the question is the behavior at the following situation:
> you are trying to write data greater than buffer size.  the device is
> set up as blocking mode.  how does write() behave?
>
> if the stream is running, it's blocked.  ok, fine.
> meanwhile, on the current implementation, if the stream is prepared
> or paused, it returns -EPIPE.
>
> this is correct in a certain perspective:  the file is not writable,
> and unless you change its state, data will be _never_ written.
> blocking the operation makes no sense, hence the driver returns an
> error.  this argument is valid on a single thread program.

This is the same case with writing to pipes, and when there is no 
reader in the other end. What will happen then is that when the buggy 
program fills the buffer is that it blocks. I think most unix 
programmers intuitively would expect this behaviour also from alsa file 
descriptors.

As I see it, there is no function to this behaviour, just saying "your 
program does not work" through a broken pipe instead of a dead-lock. I 
even would say that for most programmers it would be simpler to find 
the bug if it dead-locked instead of a broken pipe, since most would 
associate the broken pipe to a buffer underflow and search for the 
wrong problem. At least I did (however, my program would not have 
dead-locked either, since it has multiple processes)

> however, if the program is multi-threaded the state can be changed in
> other thread, then the operation may start in background.
> hence, the driver should block.  this is the case we faced now.
>
>
> the behavior of poll() is dependent on the behavior of write().
> thus, in the former case, poll() should return POLLERR, while in the
> latter case it should block.
>
>
> i myself prefer to block the operation.  it's more intuitive.
> if you don't like blocking, then you can open it in the non-blocking
> mode.  i don't see any other drawbacks.
>
>
> anyway, i'd like to hear other opinions, too.

Well, I have the same opinion, I'd just like to give another example 
(actually the same all over again, but I want to make it obvious). For 
a socket or a pipe, if noone reads from the other end, it will block 
forever. Thus, a buggy program will dead-lock. I think this example 
fits logically the case of writing to the sound-card but no-one starts 
it. It should then block forever.

The problem I have is that I do not see the use of generating a broken 
pipe in this situation, the only scenario I can come up with is "oh, I 
got a broken pipe, I must have forgotten to start the pcm, so I do it 
and try writing again". But that scenario is highly unlikely to occur 
in a program, and if it does, I would call it bad programming.

For the blocking case, however, there is a use, that of having multiple 
threads (or forked processes). In my case I have a input thread and and 
output thread, and the sound-card is started from the input thread, 
after the output buffer has been readily filled with data. Not that it 
is hard to change my program to do like ALSA wants it, but I think the 
behaviour is wrong, it is not what one would expect.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
