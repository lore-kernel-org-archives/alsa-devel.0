From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: uda1380: Avoid accessing i2c bus
 when codec is disabled
Date: Mon, 4 May 2015 15:27:05 +0100
Message-ID: <20150504142704.GD15510@sirena.org.uk>
References: <1430676707-30423-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6138338431818402552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66DE2260534
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 16:27:15 +0200 (CEST)
In-Reply-To: <1430676707-30423-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6138338431818402552==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qTzJm9l2qECmSDiM"
Content-Disposition: inline


--qTzJm9l2qECmSDiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 03, 2015 at 09:11:47PM +0300, Vasily Khoruzhick wrote:
> set_dai_fmt_both() callback is called from snd_soc_runtime_set_dai_fmt()
> which is called from snd_soc_register_card(), but at this time codec
> is not powered on yet. Replace direct i2c write with regcache write.

Applied, thanks.  Of course the most robust thing would be to convert to
regmap and mark the device cache only when appropriate...

--qTzJm9l2qECmSDiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR4GzAAoJECTWi3JdVIfQGIMH/1UPl/uEW/+peo017tPmpyq7
sA26Llklndt6l07+kQMRQCOXJXuInG3OVcGQcW5W36DujmwkvV2eLU4Em9yNoiDZ
D8cuTON/ZQBr6mUB2OlbkGaC94Pii6cMkc9PRnkrkzvI3oapvpjPBo7jbSzTy95Y
neiDknLB/kyYUjhRFUh2kdWS7HvU1Z0E/3VlzKRuiE3uJQcsjtMKiOrfYdGfWaTZ
FeEMzw7kIHSkU2RR22rBMv63GnF8EjIrmLNIzcAKikacaBHTRUpWNntOj+/GCzJe
yY68dmldjRnrXy5WjXFioXRJ3WPhd3npF23EWMKM5MvdtPirVVGqHGlBi6V3L6o=
=ngTL
-----END PGP SIGNATURE-----

--qTzJm9l2qECmSDiM--

--===============6138338431818402552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6138338431818402552==--
