From: Brian Victor <bhv1@psu.edu>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 12:23:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030116172359.GA32330@bhv1.adelphia.net>
References: <20030116134157.GA31876@bhv1.adelphia.net> <Pine.LNX.4.21.0301161630050.665-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0301161630050.665-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2003 at 04:32:05PM +0100, Tim Goetze wrote:
>afaik, you should use snd_seq_event_output() instead of
>snd_seq_event_output_direct() -- the latter is supposed
>to by-pass the queue for instant transmission.

I've tried both, actually.  output() does not show any queued events in
/proc/asound/seq/queues; output_direct() does.  miniArp.c uses
output_direct, and seems to work.  Neither produces any output in my
test program.

I've removed all attachments to wxWindows, so anyone should be able to
compile my test program.  So I don't have to keep sending snippits out
of context, the code is here:

http://www.personal.psu.edu/users/b/h/bhv1/nowx.cc      or
http://www.personal.psu.edu/users/b/h/bhv1/nowx.cc.html (syntax colored)
(g++ nowx.cc -o nowx -lasound)

>you may want to look at alsa-lib/test/playmidi1.c for
>another reference.

That could be useful, but at a glance I don't see anything important in
there that I'm not doing.  This is really perplexing me.

>>(Which begs another question: what does PPQ stand for?  Something per
>>quarter?)
>ticks/quarter (aka 'parts per quarter').

I figured it was something like that.  Thanks.

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
