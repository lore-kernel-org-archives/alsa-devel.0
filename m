From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 08:19:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403251319.i2PDJH8k002304@dhin.linuxaudiosystems.com>
References: <003301c41253$919b5c00$161b14ac@boromir>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 25 Mar 2004 11:25:56 +0100."
             <003301c41253$919b5c00$161b14ac@boromir>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> >open pcm, and get a handle.
>> >
>> >snd_pcm_poll_descriptors(handle, &pfd, err);
>> >
>> >Get a poll file scriptor in pfd.
>> >
>> >select(nfds, rfds, wfds, efds, tvp);
>> >
>> >Is it possible to use this call with alsa ?
>> 
>> select is generally deprecated in linux (linus says so!). but you can
>> use the same pfds in select as in poll (select is implemented in the
>> kernel using the poll code). the problem is interpreting the results
>> you get back (as noted recently for the dmix plugin).
>
>select and pselect do allow for a more accurate timeout specification.
>Why is select deprecated?

well, one reason might be gleaned from the man page for select_tut:

      [ ... ]

       mode  at all (see ioctl(2)). It is easy to introduce subtle errors that
       will remove the advantage of using select, hence I will present a  list
       of essentials to watch for when using the select call.
 
       1.     You should always try use select without a timeout. Your program
              should have nothing to do if there is no  data  available.  Code
              that  depends  on timeouts is not usually portable and difficult
              to debug.

of course, for main event loops in things like glib, this can't ever
really be true, but it is a rather salient point for most callers of
select(). 

i think the main reason for its "deprecation" (which is very mild,
given that its an official POSIX call) is that its semantics are not
quite as clear as poll(2). its even possible that i've missed a
retraction from linus about this.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
