From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm
 instatePREPARED?
Date: Wed, 9 Oct 2002 16:39:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0210091637000.647-100000@summer.quitte>
References: <3DA42EEB.2030208@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA42EEB.2030208@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:

>Clemens Ladisch wrote:
>
>>The behaviour of polling during capture is just fine:
>>
>>RUNNING: block until avail_min is available, then return POLLIN
>>DRAINING: return POLLIN until buffer is empty, then return POLLERR
>>(other states: POLLERR)
>>
>>The current behaviour for playback is:
>>
>>PREPARED: return POLLOUT until the buffer is full, then return POLLERR
>>
>Why would the buffer get full in PREPARED state ?
>Surely any sensible, "start_threshold" should cause the state to change 
>to RUNNING before the buffer is full.
>I can't see any reason to not to use "start_threshold" in order to get 
>from PREPARED to RUNNING.

there may be more work to do before actually starting the pcm:
delay line allocation, caching waves stored on disk, preparing
intermediate buffers for writing to disk, creating fftw plans 
etc etc. having the pcm kick off before this work is complete is 
not sensible. 

of course this depends on the particular application, but it 
is good that alsa doesn't push a certain model of app design 
here i think.

in fact, imo every feature that 'thinks for the programmer' is 
a risky thing because it narrows the choice of app designs.

>>RUNNING: block until avail_min can be written, then return POLLOUT
>>DRAINING: block (until state changes)
>>(other states: POLLERR)
>>
>>I want the behaviour in the PREPARED state to be similar to the RUNNING
>>state, i.e. return POLLOUT until the buffer is full, then block.
>>
>>My reason for this is that a buffer overflow in the PREPARED state is
>>similar to a pipe connected to an application which currently doesn't read
>>from the pipe (-> blocking), and not a pipe which isn't connected at all
>>(-> EPIPE). And as Anders pointed out at the start of this thread, there
>>are situations where this case isn't an error.

agree.

i see the current behaviour as another case where alsa tries to 
think for you. you know my ceterum censeo.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
