From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 3/8] snd-aoa: add soundbus
Date: Fri, 02 Jun 2006 16:07:05 +0200
Message-ID: <1149257225.11092.22.camel__3297.43631086803$1149257341$gmane$org@johannes.berg>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115846.852128000@sipsolutions.net>
	<s5hu0734qay.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0654591854=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEF4715A
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 16:07:10 +0200 (MEST)
In-Reply-To: <s5hu0734qay.wl%tiwai@suse.de>
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


--===============0654591854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ffYChtELi/7u6/Ory0yl"


--=-ffYChtELi/7u6/Ory0yl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 15:53 +0200, Takashi Iwai wrote:
> > +		int l;
> > +		length +=3D sprintf (buf, "%s\n", compat);
> > +		buf +=3D length;
>=20
> This seems wrong.  The above should be

Heh, no idea where I copied that from but I sure didn't write it myself.
Should be more careful next time I guess :)

> > +	if (strlen(sdev->modalias)) {
> > +		length =3D snprintf (buf, 34, "%s\n", sdev->modalias);
>=20
> sizeof(sdev->modalias) + 2?  But still strange if modalias has no
> nul-end.

Hm, how would I handle that if modalias has no nul?

johannes

--=-ffYChtELi/7u6/Ory0yl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIBGB6Vg1VMiehFYAQK5ig//cYt9Y2PqTg22PiRjVYOL1q7Bs1r+vDu4
g7RpjrX23008jHFldiBXNLccWjXKou8E+qx2y/nk3Dku0tgt6bxmrISyt0G1veu/
4okDdIkH3KA8t8e0ED2ZLN57sdO6C93HhvyfjaRNK6scpmVIRromGo+JvpF4oa2e
VC+G1/9UqsU8zT3VwmbnnGM5joInxp2FntIswzcRiZ6kDsYW0aHLlo5bs6fVW4Rl
zgyLCE/ddiRFtqHKlswvVgnKv+ZgwBy8h4rANU4T4Mc2KNvQsaTuw4fqHwRE9fxr
Ke70Hp3wF/ctLAIWzjYxjldsdNepsq9xBR5yu6Xcc6jxWH5iYSvOuyFp/xjWDYxQ
fQ0b2e+KGQE3zPRUMIkIKbEZRbtL7JRaDqnr1aLjj5O8loyFHuiXvVAz0phl9qgC
3FYc5COqkzBzb4lh4idfPp+yh6Df/+xyZZl1WaVkVv5bc2JtkNHb7+1HL2eVA3U/
qm1ioK9K487mfKjfS4xyoXqM4U9wKiUi+6mnwzaCaPB60NjPmUiFV3cDLxWfREDW
NXAXNE+Iq5nqoU25TZO6EaDO0QOidyHlspNcwqxU54e5ygPofjZX1mORlSwe0B24
hNdcDJ77AOMqV4QYTt10LCXcNr8tR7AGGbfZd5TxOwknDLiEtVg3KhjdZISQ/dbW
WstcBzBBFw4=
=+SAJ
-----END PGP SIGNATURE-----

--=-ffYChtELi/7u6/Ory0yl--



--===============0654591854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0654591854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0654591854==--
