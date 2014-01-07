From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: Fix lack of platform
	bespoke_trigger() call
Date: Tue, 7 Jan 2014 17:11:24 +0000
Message-ID: <20140107171124.GB31886@sirena.org.uk>
References: <20140103091918.7387cfb5@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2429829407131674623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29196261A7C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:11:32 +0100 (CET)
In-Reply-To: <20140103091918.7387cfb5@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2429829407131674623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7aBBD6ClYIPKzb+y"
Content-Disposition: inline


--7aBBD6ClYIPKzb+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2014 at 09:19:18AM +0100, Jean-Francois Moine wrote:
> When the platform driver has no ops, the platform function
> bespoke_trigger() is no more called.

Applied, thanks.

--7aBBD6ClYIPKzb+y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzDU5AAoJELSic+t+oim9JuoP/iq57Qtxuqy+TJo1IXiHobdb
ETFSN9IRS3aHXfYHgnVYoPyJvJxOuSQMlFeahnSgrg2973HrpJ4T++k7c3SKFRQ1
6IUj4A7PRNk5dArbArihSY32wqLnl1GsP94fRKRQTVMMwGC3VInu5tRW1bydK4Nj
Q/EBKdA/n/uD3OoRaFA3SFaI7j513brdj5YI5esAwqTNcpdWHBiJutoYQ50nLaS0
sfYlfk6sFbEprKScHVL8KeUAvRL8fNMxzgXW6NQqiwofCfV0PbBuGyN04QxTD/M9
0+SvW1B4PcC2g3OwnoDA1oI25Z3s9q4jW9ZMkzviBN328NJzGkY1MObVcJXvRFhC
yijfZSW29/w5C25+YkpbpT+BIWzNqJbsRJi9MmZLy6wrAPDYzO0W88hwH8nS34Ej
/DHkBvQpOG8wt4z3kGNwop6HtmcueV7I9JLEXuynPQsHfK0987q28BlL/KhlAhoo
hST5E2NJRieHziidmnHiIVSgOyR5FKS3U2/TqVou90q9BsB7DLnd/Khm6rH1jkEV
37xBtjXyqHtTdmEhqdw/h162wIrjjVrS1f8ouH1O3pUor2dwk104kzJbM5YSC/3l
f3CmgAysKM8f/HwaIeSlciKLWypPC6osIBoOIqfPyV2xJRHDKCQ6txpbStxG8gP9
ViLGzXfFwYItyyk8VCnC
=MsxE
-----END PGP SIGNATURE-----

--7aBBD6ClYIPKzb+y--

--===============2429829407131674623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2429829407131674623==--
