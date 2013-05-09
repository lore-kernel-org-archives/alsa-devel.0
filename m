From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: da7213: Fix setting
 dmic_samplephase and dmic_clk_rate
Date: Thu, 9 May 2013 14:29:25 +0100
Message-ID: <20130509132924.GB3200@sirena.org.uk>
References: <1368105260.10534.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6987474370979873834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1872602F2
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 15:29:29 +0200 (CEST)
In-Reply-To: <1368105260.10534.0.camel@phoenix>
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
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6987474370979873834==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2013 at 09:14:20PM +0800, Axel Lin wrote:
> When set dmic_samplephase and dmic_clk_rate bits for dmic_cfg,
> current code checks pdata->dmic_data_sel which is wrong.

Applied, thanks.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRi6SxAAoJELSic+t+oim9LNEP/jQzzQrhKMWkbqknFw1XIbVR
fZwK0wS3I9dLhpSohRHEZcEkPw4FPo8+RPZvheDu6RyFskM21M0barzDAlUcgC6p
kNFnozmoUNagKNy3pns7wJC1ibkOztPN5V68uiAeonDlH7bSPoVz/Bc4wS5LJhMU
5cHsUJk/+PnzkaRfZpnbWvyADKlFU02wBDupskXDiXrl4y7270H10aGcuiO7f541
CZSC5xVQjjD8mfcnGdMpmipRZdY/1K605+pZ7SDA7iy+TBnNYvaaOvYWRW1C5fvg
GWbIryS55/ICPZi4toBD+8E2O9KClokXrYGW9jRwOC1Z/WibX2OyjBEE98kXy/lp
vW3iw32KjmITJSc2mAF4YGB6sKqeFV9YO1aieemj1e9rckgj04XKY1cnS1tuPS0r
12lznWTWP9AYHtNtaWJA+sW24ax6bPIU8fop85cKZhWMCDNP93b9Cqjh1mc8Xs5Z
cDSE1JJs4au8Za8T9fAlTrVXODwY0Ee+APk7XUDz5I/fkEgCXErqHWk79JomhZNr
I095B123gdan57OTG7FrdE86ZpEhPO8DhQsE95SceOdx+8ds1VZzDoHDVPwgFRl8
liHwh2c7OI8hpJII547eaIZKbK5e6jnuJUFhvi88K3fA4kZO41PclnwZDcm7E59f
apSOfEO2oIrSax9oyLaN
=VRpf
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

--===============6987474370979873834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6987474370979873834==--
