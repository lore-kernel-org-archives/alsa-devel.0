From: Paul Davis <pbd@op.net>
Subject: Re: RME9636 ADAT1 Recording
Date: Tue, 24 Sep 2002 12:08:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17tsBx-0004u7-00@usw-sf-list1.sourceforge.net>
References: <20020924105354.36153.qmail@web20809.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 24 Sep 2002 03:53:54 PDT."
             <20020924105354.36153.qmail@web20809.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Shane Walton <dsrelist@yahoo.com>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Otherwise, if I will be using the alsa-lib plugin for
>striding the channels, would I be better off using the

if you ask for non-interleaved data, there is no striding going
on. the hardware is not interleaved.

>Intel Performance Primitives (IPP) libraries to do the
>channel striding?  I do want to take advantage of the
>Pentium 4.

this is a severe optimization that i would spend time on *only* after
the rest of my application was finished and i could demonstrate some
useful gain from doing.
 
--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
