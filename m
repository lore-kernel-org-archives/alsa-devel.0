From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 4 Aug 2004 12:20:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408041220190.1857@pnote.perex-int.cz>
References: <200408040018.i740ITg5017942@localhost.localdomain>
 <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz> <4110ADEB.9050807@wildgooses.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4110ADEB.9050807@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Aug 2004, Ed Wildgoose wrote:

> However, 2048 samples looks to be *just* enough to make mplayer work ok, 
> but there are still some problems occuring which look like they might be 
> driver related.  Main issue seems to be that the 
> "snd_pcm_status_get_avail" function only returns space in whole chunk 
> size blocks, ie with a 2048 sample long buffer, then I only get results 
> of 2048 or 0 (you never see 4096, the driver feels that this is an 
> over-run condition, which I guess is fair enough - some of the other 
> drivers, eg my RME96 PAD seem to give you that one remaining tick to try 
> and fill the buffer again before overflow...).  Same thing happens in 
> mmap mode

Set precise_ptr module option for your driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
