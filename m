From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RME Multiface OSS emulation outputs on all 18
 channels
Date: Sun, 22 Feb 2004 09:12:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402220910450.1872@pnote.perex-int.cz>
References: <40386386.2080600@starhub.net.sg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40386386.2080600@starhub.net.sg>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Chan <rspchan@starhub.net.sg>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 22 Feb 2004, Richard Chan wrote:

> Hi,
> 
> When I use the RME multiface under OSS emulation /dev/dsp output occurs
> on all 18 channels (of course I can mute the unnecessary channels in
> TotalMix).  Is this the expected behaviour?

Yes, it is. The in-kernel OSS emulation is designed for consumer stereo 
cards. If you want a more "fine" OSS emulation, use the alsa-oss package 
which can reroute OSS program to alsa-lib (thus use all features of this 
library).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
