From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Strange err=25 result.
Date: Wed, 14 Jan 2004 15:12:48 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401141511120.1877@pnote.perex-int.cz>
References: <40054D7E.5010902@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40054D7E.5010902@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Jan 2004, James Courtier-Dutton wrote:

> Some debug output from calling snd_pcm_wait() when a USB device is 
> unplugged.
> 
> (pcm_hw.c from /alsa-lib/src/pcm/pcm_hw.c)
> file=pcm_hw.c:406 function=snd_pcm_hw_status err=25
> pcm_hw.c: snd_pcm_hw_status() SNDRV_PCM_IOCTL_STATUS failed.
> 
> According to errno.h,
> #define ENOTTY          25      /* Not a typewriter */
> 
> I would think that the following would be a better err result.
> #define ENODEV          19      /* No such device */
> or even
> #define EPIPE           32      /* Broken pipe */
> 
> I have looked through alsa-lib and alsa-kernel and cannot find any place 
> in the code that sets errno to 25!
> 
> Can anybody help?

Consult the toplevel filesystem routines. In case when the device is 
disconnected, all i/o (filesystem operation) calls are redirected to empty 
structure, so the Linux kernel filesystem code probably returns ENOTTY 
errors when no ioctl/read/write callbacks are associated to the device.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
