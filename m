From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help with driver
Date: Wed, 18 Aug 2004 16:23:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408181620170.1109-100000@studcom.urz.uni-halle.de>
References: <20040816131140.E996B101D9@ws1-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040816131140.E996B101D9@ws1-3.us4.outblaze.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:
> I can get the card playing sound but it plays with gaps and at the
> wrong speed.
>
> The problem, I think, is to do with interrupts. The card
> interrupts when a chunk of data has been transfered and not when
> the period boundary is crossed. When you get the pointer from the
> card, it returns a number ranging from 0 to period_size. The
> number in this regsiter decreases by 1 for every byte recieved
> (from the card's p.o.v).
>
> The way I had the interrupt routine working was that it was
> calling period_elapsed everytime....this of course is wrong and
> now I'm looking to fix it so it works in the way described above.

Add up the number of bytes or frames played, and call _elapsed when
the value reaches one period.

> Is there an already existing driver for a card that works in a
> similar way?

ymfpci, usb-audio


HTH
Clemens




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
