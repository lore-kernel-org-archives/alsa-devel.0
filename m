From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Tue, 15 Mar 2005 08:49:35 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503150848280.1743@pnote.perex-int.cz>
References: <200503141530.20339.random.bits@rogers.com> <yw1xu0ndj2du.fsf@ford.inprovide.com>
 <1110846019.15588.28.camel@mindpipe> <200503142014.37841.mark@vuenyx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200503142014.37841.mark@vuenyx.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Cannon <mark@vuenyx.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2005, Mark Cannon wrote:

> How can I send down a short PCM stream, and have the 
> hardware repeat it until told to stop?

You must always copy the data to right place in the ring buffer unless
the sound fragment has not exact (or multiple) size of ring buffer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
