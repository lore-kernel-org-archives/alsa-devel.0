From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Fri, 17 May 2013 12:15:23 +0100
Message-ID: <20130517111523.GM1627@sirena.org.uk>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1272819119953601811=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 29B9D26031A
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 13:15:39 +0200 (CEST)
In-Reply-To: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <Baohua.Song@csr.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1272819119953601811==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2013 at 10:19:37AM +0800, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth handsfree is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT handsfree driver.

Sorry, should have thought of this before but why are we calling this
"handsfree"?  It's just a generic bluetooth link as far as the host
system is concerned, "bt-sco" might be more appropriate?

Otherwise this looks OK for ASoC though I'd expect to see a change to
registration of the OpenMoko BT device (perhaps I missed it though).

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlhFIAAoJELSic+t+oim9LfEQAJcRUit1LsgP/esBDm3+WXLj
+bRsvzn53Cu0UU6vMaEFMo0C7Pr5mkJVHbNuIrFKeQ2n7gUVNe7SqXjSJ3ui2Mii
sD4KJ/GW88xbg9w+dIYwcS/DFYEGqg7DKR2mCD0e4XLa6I1d0ntKB5MyWAjIIKRY
IJa8R79AW0OaiL+/6pGwBr5lLg4a5YhRMrV+W67UDT6Wn/Cz+6WL5A3wFWLu0dek
SJjXQcziaDMv8cQEhb6Bwdhk+vrNxMWEDgVbaKSCN37Xe57z2IQicoOx1QAzQcla
pri6eOJqRe9CIgQNI2AL86F6uURVsd4bNx39Rr1sYeNcjCa+sjYo7YGZ0sEpqb/Q
wHBcoG8qXstUkk01N1HBEYPvkIXV4Qgk57DQ4Adw79tLN5W5egclVYaLd8KnRcfW
cEE5PIXXUoiethgpz1KWnF5JaJJVy/IcDql6OTm8n0Q28Da4JLGMbO/w023dUU2a
ZnTfabV7rOLqO+rJCBLyJzIp+lGZ5+zkAMl0b33P2ONBrXFoxmRcFxVOrnriirM3
hNlZPpNF0EAa+rCddthZ+M/eYwUbOnrcsz8U+6zr7iN/FKaiMm3/mazjgrrZRAdY
ajzkWJYwCZStioI2LeFbIulXRJ/Lo5qCK9VWtu48MuozNV7x/5yV/jvrDuymhY7K
PLDyZ0e30pnVhBEB7vDg
=EX5n
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--

--===============1272819119953601811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1272819119953601811==--
