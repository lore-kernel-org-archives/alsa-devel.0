From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: A suggestion for better resamplers in alsa.
Date: Mon, 4 Apr 2005 17:49:27 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504041709240.17949-100000@studcom.urz.uni-halle.de>
References: <s5h1x9qdcex.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x9qdcex.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> ...
> IMO, the only "perfect" solution is to change API to allow variable
> period sizes.  Otherwise the size mismatch always occurs regardless
> what trick you apply.

This is yet another case of a constant-period-size device, like USB or
ymfpci.

> However, the variable period size would introduce the significant
> changes to the core part.

Maybe we could generalize what usb-usx2y's hwdep does.

> For example, currently the hw/appl pointers are accumulated until
> the boundary near to INT_MAX.  The real DMA buffer position in the
> ringbuffer is calculated as 'hwptr % buffer_size'.  With the
> variable period size, it's no longer true.

But buffer_size would remain constant, wouldn't it?


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
