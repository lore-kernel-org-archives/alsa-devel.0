From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Audio hardware with a queue, not a circular buffer
Date: Sun, 7 Jul 2002 17:24:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020707222440.GA8318@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm (still) writing a driver for the Gadget Labs Wave/4.

I don't know what to return for the pointer callback:

on 09/26/2001, Paul Davis advised:
>>       pointer
>
> this is called to find out where the h/w pointer is in the ring buffer
> used for capture/playback. some devices do not support it, but most do.

My card uses a queue, not a ring buffer. What should I do for this 
function? I can read a value for queue depth out of the card, but this 
doesn't appear to be what the mid-level code is looking for.

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
We have stuff for geeks like you.
http://thinkgeek.com/sf
