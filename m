From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Full duplex dmix,dsnoop
Date: Thu, 25 Mar 2004 20:40:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403252039320.1864@pnote.perex-int.cz>
References: <406334F2.4020101@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <406334F2.4020101@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Mar 2004, James Courtier-Dutton wrote:

> bash-2.05b# arecord -fcd -Dplug:duplex | aplay -Dplug:duplex
> Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> arecord: pcm.c:5920: snd_pcm_mmap_commit: Assertion `frames <= 
> snd_pcm_mmap_avail(pcm)' failed.
> Aborted by signal Aborted...
> 
> This last example with -fcd, outputs one period, maybe two then exits 
> with the above error.

Do you use latest CVS code? I've fixed this problem with the rate 
(resampling) plugin.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
