From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Why do I get broken pipe on write to a pcm instatePREPARED?
Date: Wed, 09 Oct 2002 23:28:11 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA42EEB.2030208@superbug.demon.co.uk>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>The behaviour of polling during capture is just fine:
>
>RUNNING: block until avail_min is available, then return POLLIN
>DRAINING: return POLLIN until buffer is empty, then return POLLERR
>(other states: POLLERR)
>
>The current behaviour for playback is:
>
>PREPARED: return POLLOUT until the buffer is full, then return POLLERR
>
Why would the buffer get full in PREPARED state ?
Surely any sensible, "start_threshold" should cause the state to change 
to RUNNING before the buffer is full.
I can't see any reason to not to use "start_threshold" in order to get 
from PREPARED to RUNNING.

>RUNNING: block until avail_min can be written, then return POLLOUT
>DRAINING: block (until state changes)
>(other states: POLLERR)
>
>I want the behaviour in the PREPARED state to be similar to the RUNNING
>state, i.e. return POLLOUT until the buffer is full, then block.
>
>My reason for this is that a buffer overflow in the PREPARED state is
>similar to a pipe connected to an application which currently doesn't read
>from the pipe (-> blocking), and not a pipe which isn't connected at all
>(-> EPIPE). And as Anders pointed out at the start of this thread, there
>are situations where this case isn't an error.
>
>
>Regards,
>Clemens
>
>  
>

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
