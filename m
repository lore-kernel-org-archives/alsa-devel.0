From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Mon, 7 Oct 2002 15:57:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0210071519500.607-100000@summer.quitte>
References: <3DA178F1.769C6FFA@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA178F1.769C6FFA@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Takashi Iwai <tiwai@suse.de>, Anders Torger <torger@ludd.luth.se>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:

>Takashi Iwai wrote:
>> 
>> it CAN happen if you have multi-threads.
>> the problem is that we have no option to block the poll.
>
>If you have multi-thread you have other alternative to do that.
>OTOH application can't detect *why* poll is blocking with the change you
>advocate.

as has been said before, it is fairly easy to detect this.

and to reiterate, if this happens in a single-threaded app
the code is broken by design because it poll()s before 
starting the pcm.

i'm (we're) still waiting for your answers to these arguments. 

>> but the current behavior is incorrect from the interpretation of
>> POSIX.  so this must be a bug.
>> if we have to change it, then i would choose the new one, because it's
>> more intuitive without exception.
>
>As pointed by Clemens the current is the proper POSIX behaviour.

clemens quoted the write(2) behaviour POSIX mandates. this has 
nothing to do with the poll(2) behaviour.

quoting www.opengroup.org/onlinepubs/007904975/functions/poll.html
on POSIX-compliant poll events/revents flags:

<quote>
POLLERR An error has occurred on the device or stream. [...]
</quote>

which is not the case. in the scenario you describe (a single-
threaded app polling before the pcm is started) the error is 
within the calling code logic, but clearly not 'on the device 
or stream'.

the same document goes on to say:

<quote>
If none of the defined events have occurred on any selected file
descriptor, poll() shall wait at least timeout milliseconds for an
event to occur on any of the selected file descriptors. If the value
of timeout is 0, poll() shall return immediately. If the value of
timeout is -1, poll() shall block until a requested event occurs or
until the call is interrupted.
</quote>

there's nothing in this document that says the poll implementation
shall care about whether the condition polled for is likely or 
unlikely to occur.

it must be concluded that the current poll implementation violates
the POSIX standard.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
