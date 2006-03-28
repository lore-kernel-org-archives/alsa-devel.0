From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa problems
Date: Tue, 28 Mar 2006 17:33:35 +0200
Message-ID: <1143560015.12961.5.camel@localhost>
References: <1143547835.13615.25.camel@localhost>
	 <s5hu09i7m3k.wl%tiwai@suse.de> <1143551506.13615.48.camel@localhost>
	 <s5hr74m7lqi.wl%tiwai@suse.de> <1143552082.13615.51.camel@localhost>
	 <s5hodzq7ktj.wl%tiwai@suse.de> <1143553451.13615.57.camel@localhost>
	 <s5hhd5i7jfs.wl%tiwai@suse.de> <1143555036.13615.68.camel@localhost>
	 <s5hd5g67ipv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5NwzB4T4mGwO7CXYDW62"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00A181C2
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 14:36:47 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 90D8A9923E
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 14:36:47 +0200 (MEST)
In-Reply-To: <s5hd5g67ipv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-5NwzB4T4mGwO7CXYDW62
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 16:21 +0200, Takashi Iwai wrote:

> Ah, that sounds OK, too.  The driver can return -ENOENT, so basically
> it looks same from the user-space as if there is no real device file.

Good point. I'm returning -ENODEV right now, but ENOENT might be
misleading, the open can also fail in the same way if the codec chips
behind the i2s bus aren't usable at the moment.

> OK, I'll pass you a patch later.
> I think, however, this won't go to 2.6.17 kernel since we have no
> caller yet.

No worries. I'll keep the current workaround, I'm not aiming for kernel
inclusion in the short term. Thus we can keep your patch on the queue
until my driver enters the queue :)

> A good point.  The handling of compressed formats is still under
> considration.  Any comments about preferred behavior are welcome.

Will think about it and send another mail.

johannes

--=-5NwzB4T4mGwO7CXYDW62
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARClXTqVg1VMiehFYAQLeEQ/5AfcRounHAHib5Uj7/I/YBLUuEQMs9Diq
VIYv9u7sqp8gUx1FuO1+fP0euRH2+/yu5qp756GHAPfQF9KQXG/ISu0plQ9mOR+A
Dh+r8ZRtyPYO+sCrO+j20KhI8rMQesMoA0EbrvGsIiJwN06I5aBHSqeo9dJUEts6
EpS7/ZBUYmluDWU1AyAOPxf86V0bZnWN5H0IQUCDIyTbead8XFrd7dUUJIpQ+MkF
8RUWNOKUtr3cM+O0Y348Gx7l1due1f9bvnVODW4CKOlqrszVyg2vdRhD/vBo4MvK
bLntwWF98BQrSVJGjjfd7z0DiD6ycz8KyiHxElIhxmH0zWp6rfjYF7LjEDJWmiIa
XhhP5rfG609UrJoMSok66J5MT9g0m6LrfAc9xB+uahBijeT616j8BQUD9WgStOUY
xDQVAcVktFGSvMIaeTh6MVvEPVt4t/C22HSvkd+uFp9+QL1R67PM9ZKtTsN0n03u
YuBeX/XeV/EeEjg5EKtX5yZSK0tfzI0n/L5+6wEm/F/PbU8q29QHpUkm2/VZ2YZS
jUs6bFh3GIzZ3+coisUh0rUSsGTEBB/UQmT/cme2cgKUahDhIVIvkBp7g9V6/WCC
yuynStsvk0vE/SqRpkJye98/U0rYS3g3TVEY///qlVp5SQ6R9NSDG2tNWnAMA2Jy
yOzZmOU1lWo=
=Dw6H
-----END PGP SIGNATURE-----

--=-5NwzB4T4mGwO7CXYDW62--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
