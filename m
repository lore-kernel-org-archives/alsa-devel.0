From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Is there plans to support SiS7019?
Date: Tue, 17 Aug 2004 12:57:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408171057.i7HAvbv9012682@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: vrihad@softhome.net
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

The simplest I think is:

add in trident.h

#ifndef PCI_DEVICE_ID_SI_7019
#define PCI_DEVICE_ID_SI_7019=09=090x7019
#endif=20

after=20

#ifndef PCI_DEVICE_ID_SI_7018
#define PCI_DEVICE_ID_SI_7018=09=090x7018
#endif=20

and change this
#define TRIDENT_DEVICE_ID_SI7018
((PCI_VENDOR_ID_SI<<16)|PCI_DEVICE_ID_SI_7018)=20

to=20
#define TRIDENT_DEVICE_ID_SI7018
((PCI_VENDOR_ID_SI<<16)|PCI_DEVICE_ID_SI_7019)=20

and in trident.c change line=20
{ 0x1039, 0x7018, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },=09/* SiS SI7018
PCI Audio */
to
{ 0x1039, 0x7019, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },=09/* SiS SI7018
PCI Audio */

If driver will load it will still print sis7018 (but this is not problem).

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 spolahliva a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
