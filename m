From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 09:44:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403251444.i2PEisl8003668@dhin.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0403251037200.1807@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 25 Mar 2004 10:38:18 +0100."
             <Pine.LNX.4.58.0403251037200.1807@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> select is generally deprecated in linux (linus says so!). but you can
>> use the same pfds in select as in poll (select is implemented in the
>> kernel using the poll code). the problem is interpreting the results
>> you get back (as noted recently for the dmix plugin).
>
>Nope, the application must give results back to pfd array and call
>snd_pcm_poll_descriptors_revents() function. In this way, everything
>will work as expected.

i thought that the flags set by select(2) were different than those
set by poll(2) ??


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
