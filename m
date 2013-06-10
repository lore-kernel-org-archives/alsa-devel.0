From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2518: Fix trivial typo in
 checking tx_mask and rx_mask values
Date: Mon, 10 Jun 2013 18:06:30 +0100
Message-ID: <20130610170630.GO1403@sirena.org.uk>
References: <1370874233.25883.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3836578465406051265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A66692616FA
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 19:06:34 +0200 (CEST)
In-Reply-To: <1370874233.25883.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3836578465406051265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8WA4ILJSyYAmUzbY"
Content-Disposition: inline


--8WA4ILJSyYAmUzbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 10:23:53PM +0800, Axel Lin wrote:
> Otherwise, ssm2518_set_tdm_slot() always returns error if slots != 0.

Applied, thanks.

--8WA4ILJSyYAmUzbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtgeTAAoJELSic+t+oim99VoQAJtufvfO0Nz8ciuEMSbAwIe6
zTkLVZnIXh+3Pvexfp0jgPRr4b7einfttWM29vlW2f63uG1LvAnYL8wZ8rJpXFmV
Ec0d8iJM3h6LUTTjZWUs+W1APPCfK5UgXy7BSu2rhDAqK8DRauhc8uTC6jw6Uf43
kZr2Xbc80Vr/TFJg0TMIlVC67Xa5DhS/lS0+3YDy6xDcdRnbLx5Tcu3hx42jjgF7
DBShnmYYYqfdgYgfqq4Pm8GrDCKgnXKLheuHtoov70nTr42GEvcXEMraieKSFyKm
hQoKfGUzpDI5Uxl2F37pUeK/TYkJD8YMyRSYSkHh1r53y1GO6oh2KzbNtjRLV3jZ
VhdFn2cLwUYr9S2UrCx9dm3k+/8grfK9sJ2BgrZ5uWeF1m04glS+n1yN/Dtaly+D
u6raPtBRtnxZDrkXaNlkXvA+Y2UytXpG7jyoRXIAib3Oz6DnCfait0EEP0XYwHnC
1hW85R4Kv0KFzf0kxZc8NoRb0e5JNkEGrjcLFRdvg+WqtQpuXSaN0W05LHTCYBTk
5DcHcuH7Vbe4IH3RgFTX7Z7n/1A9vRMjrJMSmqjWLZUPqR0c+EDTVwdGRPIc9D8S
B2Isq3OMwZoJm1A/MSMTC0wbqKTKSB7FdO086cJyeJqDoBcMHp4H526RNGwJxsGF
SbW5i86ATP52rvXLi4iN
=3q3R
-----END PGP SIGNATURE-----

--8WA4ILJSyYAmUzbY--

--===============3836578465406051265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3836578465406051265==--
