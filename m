From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 10:07:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308271407.h7RE7PVN015845@oud>
References: <1061982466.30543.64.camel@lotte.street-vision.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "27 Aug 2003 12:07:46 BST."
             <1061982466.30543.64.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>, alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> I'm planning to use arecord for serious harddisk recording, but it can't

that's a non-starter :) at the very least, you'd better make sure you
always use a period size larger than the maximum scheduling delay you
think you might encounter, since arecord writes to disk from the same
thread as one audio I/O is done from.

ecasound would be a much better idea, much, much better.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
