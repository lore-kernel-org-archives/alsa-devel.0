From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 15:27:02 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308271523250.9988-100000@ecabase.localdomain>
References: <Pine.OSF.4.56.0308271045210.398158@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.56.0308271045210.398158@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Aug 2003, Tommi Sakari Uimonen wrote:

> I'm planning to use arecord for serious harddisk recording, but it can't

I strongly suggest to look for other alternatives. For serious
harddisk recording you absolutely need an application that provides
protection against spikes in disk i/o operation latencies.

Here's a more detailed explanation of why Ecasound suits this 
purpose:

 http://eca.cx/ecasound-list/2001/06/0016.html

> write files bigger than 2BG. After browsing through kernel mailing lists
> about LFS I concluded that the problem is arecord, not the underlying
> filesystem (and since I've had >8GB files on it :).

Ecasound has support for LFS (compile with --with-largefile).

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
