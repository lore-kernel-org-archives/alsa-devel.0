From: "Ash Willis" <ashwillis@programmer.net>
Subject: help with driver
Date: Mon, 16 Aug 2004 08:11:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040816131140.E996B101D9@ws1-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey, I've been writing a driver as my spare time has been permitting, and=
 this is the first driver I've ever coded so it's taken me a while.

I can get the card playing sound but it plays with gaps and at the wrong =
speed.

The problem, I think, is to do with interrupts. The card interrupts when =
a chunk of data has been transfered and not when the period boundary is c=
rossed. When you get the pointer from the card, it returns a number rangi=
ng from 0 to period_size. The number in this regsiter decreases by 1 for =
every byte recieved (from the card's p.o.v).

The way I had the interrupt routine working was that it was calling perio=
d_elapsed everytime....this of course is wrong and now I'm looking to fix=
 it so it works in the way described above.

I'm having a mental block at the mo though in working out how to go about=
 this so any help would be appreciated...

Is there an already existing driver for a card that works in a similar wa=
y?

Thanks, Ash.
--=20
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
