From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Removal of /proc/asound ?
Date: Sat, 17 May 2003 13:55:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 17 May 2003, Erik de Castro Lopo wrote:

> Hi all, 
> 
> I noticed this in a recent post from Takashi Iwai :
> 
> > (note that you need to run snddevices script once with the recent cvs
> > version, since we removed the dynamic device files on /proc.)
> 
> Anybody care to fill me in on :
> 
>     0) Why this is being done?
>     1) What replaces it?
>     2) How do user space programmers ensure backwards and forwards 
>        compatibility?

I try to explain these things to avoid more confusion.

The dynamic devices created in proc filesystem does things similar as 
DEVFS. We used it, because in design time, we changed minor and major 
numbers for our devices heavily. Once we stabilized our devices, and DEVFS 
obsoleted our code (DEVFS is more generic), there is no reason to maintain 
this code anymore. Also, we are only one project doing this and we had 
requests from the kernel people to remove this code.

The current situation is that used /dev/snd symlink should be replaced
with directory containing static device entries (created by mknod). If you
use DEVFS, there is no difference and no extra steps are required.

If the driver is installed via standard command 'make install' in the 
alsa-driver directory, the snddevices script is run automatically when 
/dev/snd is a symlink. This ensures that ALSA devices are properly 
recreated. If another update mechanism is used, it should be upgraded.

There is no impact for the user space programmers. Because alsa-lib uses 
only device names (/dev/snd/*), there is no difference among DEVFS, 
static mknod device files and proc dynamic devices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
