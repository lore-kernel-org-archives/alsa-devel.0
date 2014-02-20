From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/17 v2] ASoC: ams-delta: Update locking around use of
 DAPM pin API
Date: Thu, 20 Feb 2014 19:27:41 +0900
Message-ID: <20140220102741.GM2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="12fN/C3tTlpYbwJo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--12fN/C3tTlpYbwJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:22PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so. It looks like these were originally locked
> with the CODEC mutex and not updated since the patch "ASoC: dapm: Use
> DAPM mutex for DAPM ops instead of codec mutex", so remove the original
> CODEC mutex locking as well.

Applied, thanks.

--12fN/C3tTlpYbwJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdiZAAoJELSic+t+oim96hMQAITwdHnNXV8KQqa8o3xa179F
UgDN8NCN7/NAO/QgGwg8o5w+gRsXmedjFO3j0PoyG6gnbRzzJE/8i2Zj5QvycPWp
XzHNZ0xHbUET+A7kdW4cwJNx6MW9HxLPkh9csxb0CdbEFE1c1iU8otfSmgHdKnyE
qrMAK4VsJJLPtVbsIxEjMg7Bvm7ZRE+RvUZQscwSFfN0+XuzocTrinu+cW9bKoP+
VgvDcppR+++ecGX6iKtjiCS9VMsxREJEMw6TU029WbzCf2xShkbrRPSoO+za2wBn
DUxw7nL03oviSEMnLvJsSN8vemXUpxAVN9MdCH2f6VpuCcjptBxF8a/LRCzJ+zjE
w0++84D3s8prvmRTPuBR1sbP3g82D/wnUC/7EH84EF+lZYaixvK7+ply9THjlxqi
1T8DuAvPMpkrChgNSaTxqpkNpjv/9pNgn9pOd72CcCAuUHVJaNfGvVn3KCWWivii
fSMH6bRwTDDmz5QtCJGc6RmQ4aJEYyOQ1eqrxGgAm3fcs+Ojh0hnzxAdnupEzykF
aO3V1z8PDfquLP7kRgf5dDB+BHBFkGeE7iiZcpy7QJoS9WopA6m7FHhMqdYGIcxx
Rwv3qc/ITaL5F/cnv/NldPtfGPz3F9zoF8GCbug9hQtQeNV5Bad30P4VANElVmTO
a+mrWn1/qtDH64EbJYVu
=CrFx
-----END PGP SIGNATURE-----

--12fN/C3tTlpYbwJo--
