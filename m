From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 2/7] snd-aoa: add aoa core
Date: Tue, 30 May 2006 14:44:31 +0200
Message-ID: <1148993072.3102.10.camel__16160.9794981361$1148993242$gmane$org@johannes>
References: <20060528190026.754474000@johannes.berg>
	<20060528190124.579130000@johannes.berg> <s5hac919jzl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0469351363=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 83A1914F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 14:44:49 +0200 (MEST)
In-Reply-To: <s5hac919jzl.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0469351363==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wDOrYlhNG7k3O3MhfTmY"


--=-wDOrYlhNG7k3O3MhfTmY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-29 at 12:57 +0200, Takashi Iwai wrote:
> > +	alsa_card =3D snd_card_new(-1, name, mod, sizeof(struct aoa_card));
>=20
> Usually the first argument here is the index module option so that
> user may specify the card order (e.g. secondary card) independent from
> the order of module loading.

Are you saying I should add an index module option and pass that?

johannes

--=-wDOrYlhNG7k3O3MhfTmY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHw+LaVg1VMiehFYAQKs9hAApDarzZ7JMqB6V9e97xqnoKGIh4g3RUqA
T6azyCCmIJUYdhgIpaOVI0byrd2imNbzO29Mmzkd4/OzbaSQxNAlDkW3W0p5QS6X
5KeLFjL7KxQ6tikNZz+LFRBBouDzkB1TpzzObqjV6Ys5A95hSDwerEi0Yy2Pnb2i
SQi4fsbPyksq0bd5XiBLKRUU0hdPokSQaI4d2EJzBx+EM1pwNKQ6oP4VdFNiPiza
GNT7JPWsh8phm0ReglWy0jDGIut8GEvBeMrCApO/2nSrUfq9gSlN2e3meX4LOvom
7Or/NyXOK+H1ObkZ1Sml7Xi1SevqvlQf68Re4C7PTtyhbn7sX/u964By2GqDczT+
r1SHay3JW1fFyV4PpZuXa2PXqxPFy4lv8jJFpcoIb3nViMVY3xvwLJzAXNyQHqMa
EMCHKszBYbZnmlq7YKmGkdhhxV1OJNDP2xFf1fVPkN3GKngPzwycXVEDrqM2PM2u
Nt0YGyc5Wo/t0mr7JEV0NQG9fwKlnR5x/zgFqfF4HnOZITwTBXcbASXrltCxV1IC
/PjlDlIQBNolLwe/HxAjfJ68bzLFSc2q1PkxLz24lYxnpaeTlSmYOuYEE7dbZSe3
kfowcgRUWxEAPFv2pWyZn1gDl02C6becIhaMLQH05tx8oFplPuVTKzf2ejADXEy9
JvD6g195Tcg=
=cwPS
-----END PGP SIGNATURE-----

--=-wDOrYlhNG7k3O3MhfTmY--



--===============0469351363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0469351363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0469351363==--
