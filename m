From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA in 2.5.x
Date: Wed, 2 Oct 2002 12:44:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210021243280.653-100000@pnote.perex-int.cz>
References: <200210021117.47402@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210021117.47402@advent.drealm.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter L Jones <peter@drealm.org.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Oct 2002, Peter L Jones wrote:

> Hi all,
> 
> I was wondering when we can expect an update to ALSA in the kernel source - 
> we're still on -rc2, aren't we?  Now that 2.5.x is getting a little more 
> useable, I'd like to start running it again (I stopped at 2.5.25 as it really 
> did become too dangerous).  But I want ALSA :-)
> 
> I'm currently compiling 2.5.40 with _no sound_.  However, for some reason, 
> make modules_install comes back with:
> 
> make[3]: Entering directory `/usr/src/linux-2.5/linux/sound/core/oss'
> Installing modules in /lib/modules/2.5.40/kernel/sound/core/oss
> cp: cannot stat `snd-mixer-oss.o': No such file or directory
> cp: cannot stat `snd-pcm-oss.o': No such file or directory
> 
> I'm not up to speed on the kernel configuration language, so I've no idea 
> where to start looking...  Any clues?

ALSA tree was fully synced with kernel yesterday. Not all changes are in 
2.5.40. Please, wait for 2.5.41 or get the kernel sources from BitKeeper 
repository of 2.5.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
