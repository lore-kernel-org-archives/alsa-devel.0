From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Detecting ALSA OSS emulation
Date: Tue, 9 Dec 2003 12:26:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312091209260.20863@pnote.perex-int.cz>
References: <20031208120657.GD535@zewt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031208120657.GD535@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <g_sf@zewt.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Dec 2003, Glenn Maynard wrote:

> Is there a reliable way to find out if /dev/dsp is being handled by
> ALSA?  I want to be able to detect this for diagnostics.  (If /dev/dsp
> is ALSA, the native alsa-lib code should have been used, and something
> has gone wrong.)  Currently, I'm checking for the existance of
> /proc/asound/version, but at least one user had a configuration where
> that file existed but /dev/dsp was really OSS.
> 
> (That's what it looked like, and what he claimed, at least; I havn't
> tried to reproduce that configuration, with both ALSA and OSS loaded
> and only OSS actually handling sound.  It's possible something else
> was happening and the user was wrong.)

We use this OSS version:

#define SNDRV_OSS_VERSION         ((3<<16)|(8<<8)|(1<<4)|(0))   /* 3.8.1a */

Ok, I've just added a new ioctl for more easy and reliable checks for 
mixer and pcm emulation:

#define OSS_ALSAEMULVER         _SIOR ('M', 249, int)

This ioctl will return 1 as integer:

int ver;
if (ioctl(fd, OSS_ALSAEMULVER, &ver) == 0 && ver > 0)
	printf("fd is ALSA's emulation handle\n");

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
