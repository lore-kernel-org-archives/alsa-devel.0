From: p z oooo <pzad@pobox.sk>
Subject: Re: VIA 8233A, 8235 with ALC650 codec
Date: Wed, 19 Feb 2003 07:51:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302190651.HAA14535@www7.pobox.sk>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I played with 8233A ALC650 and:

1) this part of code is not working:

switch (runtime->channels) {
=09case 1: slots =3D (1<<0) | (1<<4); break;
=09case 2: slots =3D (1<<0) | (2<<4); break;
=09case 3: slots =3D (1<<0) | (2<<4) | (5<<8); break;
=09case 4: slots =3D (1<<0) | (2<<4) | (3<<8) | (4<<12); break;
=09case 5: slots =3D (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16);=20
break;
=09case 6: slots =3D (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16)=20
| (4<<20); break;
=09default: slots =3D 0; break;
=09}
=09/* STOP index is never reached */
=09outl(0xff000000 | slots, VIADEV_REG(viadev,=20
OFFSET_STOP_IDX));=20

I think that 8233A uses this slots mapping and this can't be changed=20
with previous code. I changed=20
case 6: slots =3D (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) |=20
(4<<20); break;
to
case 6: slots =3D (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) |=20
(6<<20); break;
and this doesn't work (no change).

channels slots
1 - 3, 4
2 - 3, 4
4 - 3, 4, 7, 8
6 - 3, 4, 6, 9, 7, 8


Peter Zubaj
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AVyrazne zlavy pocitacov a prislusenstva=0ATos=
hiba Pocket PC e740 v cench u? od 24.300,- Sk bez DPH=0ANavstivte nas na ad=
rese http://www.somi.sk/akcie.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
