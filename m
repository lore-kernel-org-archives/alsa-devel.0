From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS mapping for ALSA controls
Date: Thu, 8 Apr 2004 19:12:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404081911240.1867@pnote.perex-int.cz>
References: <s5hhdvvacci.wl@alsa2.suse.de> <031101c41d2a$83ea2a50$f8b6a8c0@ent.ti.com>
 <s5h1xmy9z5y.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xmy9z5y.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: pavans@india.ti.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Apr 2004, Takashi Iwai wrote:

> At Thu, 8 Apr 2004 10:59:50 +0530,
> Pavana Sharma wrote:
> > 
> > yes, I did this as root ..
> 
> hmm, it works for me.
> 
> 	# echo 'VOLUME "Line Playback" 0' > /proc/asound/card0/oss_mixer
> 	# cat /proc/asound/card0/oss_mixer  | grep VOLUME
> 	VOLUME "Line Playback" 0

Shell problem? The embedded devices has stripped things.

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
