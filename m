From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] alsa-lib leaves sound device open for child
 processes
Date: Wed, 5 Feb 2003 12:20:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302051218100.1303-100000@pnote.perex-int.cz>
References: <20030203231629.26ee7464.sebastian_kapfer@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030203231629.26ee7464.sebastian_kapfer@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Kapfer <sebastian_kapfer@web.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Feb 2003, Sebastian Kapfer wrote:

> The alsa-lib doesn't set the close-on-exec flag on its PCM device FD's.
> The consequence is that processes spawned by alsa-lib clients inherit an
> open file handle to the PCM device and thereby block it.
> 
> For example, mplayer can disable and re-launch the xscreensaver daemon.
> In the alsa-enabled version of mplayer, the xscreensaver process
> inherits a pcm handle, although xss can't make use of it. This
> effectively forces me to restart xss manually after each mplayer
> session.
> 
> Suggested fix:
> 
> --- src/pcm/pcm_hw.c.orig	2002-10-12 13:49:54.000000000 +0200
> +++ src/pcm/pcm_hw.c	2003-02-03 23:07:14.000000000 +0100
> @@ -867,6 +867,11 @@
>  		ret = -errno;
>  		goto _err;
>  	}
> +	if( fcntl( fd, F_SETFD, FD_CLOEXEC ) != 0 ) {
> +		SYSERR("fcntl FD_CLOEXEC failed");
> +		ret = -errno;
> +		goto _err;
> +	}
>  	if (ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver) < 0) {
>  		SYSERR("SNDRV_PCM_IOCTL_PVERSION failed");
>  		ret = -errno;

Well, I and Abramo think that it's better to force application developers 
to clean allocated things before they'll call exec(). I believe that not 
only ALSA file descriptors are open after exec() in mplayer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
