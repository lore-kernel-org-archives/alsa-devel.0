From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sequencer queue PCM timing drift
Date: Thu, 1 Jul 2004 14:42:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407011434490.1553@pnote.perex-int.cz>
References: <200405131416.54774.cannam@all-day-breakfast.com>
 <Pine.LNX.4.58.0405132009120.1834@pnote.perex-int.cz>
 <200405131934.26656.cannam@all-day-breakfast.com>
 <200407011352.01194.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407011352.01194.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Jul 2004, Chris Cannam wrote:

> Timer for queue 0 : PCM playback 0-0-0
>   Period time : 0.046545454
>   Skew : 65536 / 65536
> 
> What could cause this drift?  Where should I look next?

It looks like a rounding problem:

1024/44100 * 2 = 0.046439909

Look to snd_pcm_timer_resolution_change() in pcm_timer.c for more details.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
