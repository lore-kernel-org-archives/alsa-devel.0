From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 16:58:09 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.56.0308271656580.398158@kosh.hut.fi>
References: <Pine.OSF.4.56.0308271045210.398158@kosh.hut.fi>
 <1061982466.30543.64.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1061982466.30543.64.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> You can almost certainly just add
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> to the CFLAGS in the Makefile. (it would be good if this was default on
> 32bit platforms).

Thanks. This did the trick.

Tommi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
