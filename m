From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 06:46:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGEBPDBAB.mknecht@controlnet.com>
References: <200308281204.h7SC4YeW005393@oud>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308281204.h7SC4YeW005393@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >> Mark Knecht is currently using this code with success, but the card
> >> behaved strangely with rev. 104 (0x68) firmware. He had to
> downgrade it to
> >> rev. 101 (0x65) for the card to work properly.
> >>
> >> [and Mark concured he had to downgrade the firmware]
> >
> >We have not made any changes to the firmware thus far.  Unsure if its
> >required or not.
>
> if you can load the driver and the "firmware" (aka "configuration
> data", done by hdsploader), then you don't need to worry about
> this, AFAIK.
> however, use lspci -vv to get full version info on the system you
> have - the "rev" number indicates the firmware you have.
>

Does hdsploader have anything to do with the HDSP 9652? I thought that was
only for the Digiface/Multiface cards. I'm not using it (I believe) unless
it's happening in the background somewhere.

For clarity - I can load the Alsa driver for the HDSP 9652 when my card has
the rev. 104 firmware in it. It's just that the card doesn't work properly.
The driver does find the card & load. After downgrading my firmware in
Windows to Rev 101 I can load the driver and my card works. All that is
required (apparently) to load the driver is a match in the PCI ID numbers
and reading out of the firmware revision.

I have attempted (last weekend) to upgrade my firmware back up to rev. 104
and tried the Alsa drivers, but they did not work.

- Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
