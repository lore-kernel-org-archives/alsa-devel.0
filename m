From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: devfs_remove() not present in linux 2.4.19
Date: Sat, 23 Nov 2002 21:46:35 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211232146090.503-100000@pnote.perex-int.cz>
References: <20021123173759.35911.qmail@web40612.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021123173759.35911.qmail@web40612.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 23 Nov 2002, [iso-8859-1] Chris Rankin wrote:

> Hi,
> 
> I am having problems with the latest ALSA CVS using
> Linux 2.4.19-SMP and devfs. Specifically:
> 
> # depmod -ae
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19/kernel/drivers/sound/snd.o
> depmod:         devfs_remove

Fixed. I forgot to commit code in alsa-driver directory from my disc ;-(

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
