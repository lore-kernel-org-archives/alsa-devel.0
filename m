From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: xine & cvs alsa
Date: Mon, 27 Jan 2003 15:40:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301271539470.2937-100000@pnote.perex-int.cz>
References: <20030127142506.GA18353@earthlink.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030127142506.GA18353@earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "despair@adelphia.net" <despair@adelphia.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Jan 2003, despair@adelphia.net wrote:

> For a week, maybe a bit more (I didn't watch any movies for over a week,
> and haven't had time to try searching cvs to pin down the date) xine has
> been dying when I try to watch movies in 4.0, 5.0, or 5.1. Stereo works
> without any problems, though.
> 
> Here's the error message:
> audio_alsa_out: Audio Device name = surround40
> audio_alsa_out: Number of channels = 4
> ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for symbol _snd_pcm_hook_ctl_elems_install
> ALSA lib pcm_hooks.c:527:(snd_pcm_hook_add_conf) symbol _snd_pcm_hook_ctl_elems_install is not defined inside (null)
> xiTK received SIGSEGV signal, RIP.
> Aborted
> 
> Is this an API change, xine doing something shifty that it got away with
> up until now, or something else entirely? Anything I can do to work around
> it? Movies just aren't the same in stereo... :)

Should be fixed in latest CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
