From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: correcting incorrect ac'97 codec clock
Date: Mon, 21 Feb 2005 16:26:32 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502211624520.24184-100000@studcom.urz.uni-halle.de>
References: <1108996683.3174.4.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1108996683.3174.4.camel@icampbell-debian>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ian Campbell <icampbell@arcom.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ian Campbell wrote:
> I am working on a piece of hardware where the AC'97 codec clock was
> erroneously set at 24MHz instead of the correct 24.5764MHz, this causes
> the sound to come out slightly wrong, a 1000Hz sine wave is ~977Hz or
> so.
>
> We'd prefer to have the kernel correct for this error rather than
> expecting every application to do it.

bus->clock is set to the sample rate of the AC'97 bus, and is 48000 by
default.  Setting it to 46875 after creating the bus should help.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
