From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 12:42:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403121240380.2696@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F290B4@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F290B4@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Mar 2004, Gupta, Kshitij wrote:

> hi,
> 	:) maps almost perfectly ...thanx a lot.  Only other doubt I had
> was, why are we always getting underruns in case of ARM (as Russell also
> pointed out that there are some cache coherency problems), but I am not able
> to map cache coherency problems to the underruns we are getting.  We are
> getting underruns consistently, even with very small period size (about 1k).

I think that the problem must be somewhere else. Check the input data to 
the OSS layer. If you use OSS emulation, then the coherency problem does 
not exist, because appl_ptr and hw_ptr is updated only from the kernel 
space.

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
