From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 13:12:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308271307320.1958-100000@pnote.perex-int.cz>
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
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Aug 2003, Tommi Sakari Uimonen wrote:

> I'm planning to use arecord for serious harddisk recording, but it can't
> write files bigger than 2BG. After browsing through kernel mailing lists
> about LFS I concluded that the problem is arecord, not the underlying
> filesystem (and since I've had >8GB files on it :).
> 
> I looked at the code, but didn't have any idea what to change.

I've tried to change the aplay code in CVS. Could you give a try?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
