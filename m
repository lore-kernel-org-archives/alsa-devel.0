From: Paul Davis <pbd@op.net>
Subject: Re: Audio hardware with a queue, not a circular buffer
Date: Sun, 07 Jul 2002 20:42:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17RMaE-0007bN-00@usw-sf-list1.sourceforge.net>
References: <20020707222440.GA8318@mlug.missouri.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 07 Jul 2002 17:24:40 CDT."
             <20020707222440.GA8318@mlug.missouri.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Rages <markrages@mlug.missouri.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> this is called to find out where the h/w pointer is in the ring buffer
>> used for capture/playback. some devices do not support it, but most do.
>
>My card uses a queue, not a ring buffer. What should I do for this 
>function? I can read a value for queue depth out of the card, but this 
>doesn't appear to be what the mid-level code is looking for.

since queues and ring buffers are really rather similar, perhaps you
could explain what the card does when it reaches the end of the queued
data.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
We have stuff for geeks like you.
http://thinkgeek.com/sf
