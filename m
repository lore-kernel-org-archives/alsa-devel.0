From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Why do I get broken pipe on write to a pcm in state
 PREPARED?
Date: Fri, 13 Sep 2002 11:41:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209131137140.521-100000@pnote.perex-int.cz>
References: <s5h1y7zp5fp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y7zp5fp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Anders Torger <torger@ludd.luth.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Sep 2002, Takashi Iwai wrote:

> At Thu, 12 Sep 2002 13:48:56 +0200,
> Anders Torger wrote:
> > 
> (...snipped the analogy of pipes...)
> > 
> > Well, I have the same opinion, I'd just like to give another example 
> > (actually the same all over again, but I want to make it obvious). For 
> > a socket or a pipe, if noone reads from the other end, it will block 
> > forever. Thus, a buggy program will dead-lock. I think this example 
> > fits logically the case of writing to the sound-card but no-one starts 
> > it. It should then block forever.
>  
> agreed, although the alsa is already apart from the standard device
> operations (unlike normal devices, alsa needs an explicit set-up
> before read/write).
> 
> 
> > The problem I have is that I do not see the use of generating a broken 
> > pipe in this situation, the only scenario I can come up with is "oh, I 
> > got a broken pipe, I must have forgotten to start the pcm, so I do it 
> > and try writing again". But that scenario is highly unlikely to occur 
> > in a program, and if it does, I would call it bad programming.
> > 
> > For the blocking case, however, there is a use, that of having multiple 
> > threads (or forked processes). In my case I have a input thread and and 
> > output thread, and the sound-card is started from the input thread, 
> > after the output buffer has been readily filled with data. Not that it 
> > is hard to change my program to do like ALSA wants it, but I think the 
> > behaviour is wrong, it is not what one would expect.
> 
> we can see this problem from a different angle:  on the current
> scheme, you cannot block writing if the stream is not running.
> writing more in the prepare state will always return an error
> immediately.
> 
> btw, the attached patch is a quick and untested hack to change the
> behavior as you wish :)
> please give a try.

I think that the current behaviour of write() is ok, the behaviour of
poll() might be "fixed". I see advantages for both. I would prefer to have
this configurable to satisfy multi-threaded applications. We can put a new
variable to sw_params.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
