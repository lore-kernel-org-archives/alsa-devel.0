From: p z oooo <pzad@pobox.sk>
Subject: Re: VIA 8233A, 8235 with ALC650 codec
Date: Thu, 20 Feb 2003 07:19:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302200619.HAA23828@www6.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: gbdj@linux.spb.org
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I tink, there is still small bug (I think) - via82xx.c

else
   /* slot mapping: 3,4,6,9,7,8 */
   val =3D 0x4000;=20
   snd_ac97_update_bits(chip->ac97, AC97_ALC650_MULTICH, 0xc000, val);

is this correct ???
val =3D 0x4000; (I think, that there should be 0xc000)

try change this

Peter Zubaj
=0A____________________________________=0AP. S. V. P. U.=0Ahttp://www.pobox=
.sk/=0A=0A


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
