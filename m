From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] dmix share one socket to more than one user
Date: Sun, 7 Dec 2003 10:33:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312071030270.20863@pnote.perex-int.cz>
References: <20031207042229.GB26017@bart.intergenia.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031207042229.GB26017@bart.intergenia.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maik Broemme <mbroemme@plusserver.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003, Maik Broemme wrote:

> Hi,
> 
> today i got some problems with the dmix pcm plugin, i start one
> mpg123 as root and later i want to start as normal user alsaplayer
> to test something. I got permission denied error, because the socket
> is only writable from the user who has created it. I have made a
> little patch which implements a new config entry for the socket
> permissions. For example:
> 
> pcm.softmix {
>         type dmix
>         ipc_key 1024
>         ipc_perm 666
> ...
> }
> 
> If you are interested in i could do this for all pcm plugins which
> creates a socket, also i could implement another entry like
> ipc_group = "audio"; no problem i think with getgrgid(); Another
> thing which is changed now; the default file permissions if no
> ipc_perm entry in the config file exists, is 0644, i think there
> is no need to have 755 for the socket :)

I changed the default permissions to 0600 to provide better security. 
Your code is in CVS (with modifications for dsnoop and dmix plugins).

The 'ipc_group' option might be also useable, so if you find a bit of 
time, I like to see it in alsa-lib.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
