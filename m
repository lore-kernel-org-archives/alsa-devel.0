From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Tue, 15 Mar 2005 19:49:59 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503151949320.21135@pnote.perex-int.cz>
References: <200503141530.20339.random.bits@rogers.com> <200503142014.37841.mark@vuenyx.com>
 <Pine.LNX.4.58.0503150848280.1743@pnote.perex-int.cz>
 <200503151349.02376.random.bits@rogers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200503151349.02376.random.bits@rogers.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "random.bits" <random.bits@rogers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Mar 2005, random.bits wrote:

> How can I get the hardware to continue to play using 
> the data in the ring buffer?

Use no-xrun mode (set stop_threshold to boundary).

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
