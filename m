From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Audio hardware with a queue, not a circular buffer
Date: Sun, 7 Jul 2002 22:30:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020708033049.GB32739@mlug.missouri.edu>
References: <20020707222440.GA8318@mlug.missouri.edu> <200207080040.g680eqKL029942@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200207080040.g680eqKL029942@mlug.missouri.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 07, 2002 at 08:42:14PM -0400, Paul Davis wrote:
> >> this is called to find out where the h/w pointer is in the ring buffer
> >> used for capture/playback. some devices do not support it, but most do.
> >
> >My card uses a queue, not a ring buffer. What should I do for this 
> >function? I can read a value for queue depth out of the card, but this 
> >doesn't appear to be what the mid-level code is looking for.
> 
> since queues and ring buffers are really rather similar, perhaps you
> could explain what the card does when it reaches the end of the queued
> data.

I'll have to perform the experiment. Hopefully, this week sometime. 

If the value wraps around, then it is a ring buffer after all (and I
can return something like (sw_pointer+queue_depth) % buffer_length ??) 

If the value stays at zero, then... well, I just hope it doesn't.

Mark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
We have stuff for geeks like you.
http://thinkgeek.com/sf
