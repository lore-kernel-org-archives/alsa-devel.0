From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: FW: DMA producer/consumer
Date: Thu, 11 Mar 2004 18:43:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403111840580.1961@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F29093@DBDE01>
 <s5hznanjven.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznanjven.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Mar 2004, Takashi Iwai wrote:

> unfortunately, the current implementation of ALSA PCM middle layer
> isn't well suited for this kind of hardwares.  it'll be a bit more
> complicated than you think.

I don't think that's this case. I'm not sure, if the basic midlevel 
mechanism is understood: The midle level code expects that driver 
start/stop the stream in the trigger callback, so if you can queue
more 'periods' into the DMA engine, do it and abort/pause the transfer
only the trigger callback request. You don't need to check appl/hw_ptr
in the lowlevel code.

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
