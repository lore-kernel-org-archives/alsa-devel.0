From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: M-Audio Quattro initialization problem
Date: Wed, 22 Mar 2006 14:43:29 +0100
Message-ID: <002a01c64db6$9dd3d510$a578e4a0@supelec.fr>
References: <e5643d89521b5bfebcff2478bdf7ed90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <e5643d89521b5bfebcff2478bdf7ed90@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
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


> The following issue has been CLOSED=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D48>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Reported By:                giggls
> Assigned To:                Clemens Ladisch
...
> It seems to work, but it does not record any useful sound.
>=20
> Unfortunately it does work occasionally (about 50% of the time)!
>=20

This issue looks exactly as the bug I patched for the M-Audio Audiophile =
Usb
device.
I'd really like to know (if there are Quattro users in the list) if this
issue has been fixed in CVS.

The problem is certainly that the Alsa driver initiqlizes all available
endpoints (both 16bits and 24bits) at startup. This leads in a corrupted
state of the device which expects only that endpoints corresponding to =
_one_
sample depth to be initialize.

Anyway, if some Quattro users still have this issue, you can contact me =
to
discuss the way of patching this.

Thibault.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
