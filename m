From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: Add a set_bias_level()
 callback to the DAPM context struct
Date: Sat, 21 Jun 2014 21:34:32 +0100
Message-ID: <20140621203432.GA22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0100303639371600434=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C47242619E5
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:35:03 +0200 (CEST)
In-Reply-To: <1402935191-18398-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0100303639371600434==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:05PM +0200, Lars-Peter Clausen wrote:
> Currently the DAPM code directly looks at the CODEC driver struct to get a
> handle to the set_bias_level() callback. This patch adds a new set_bias_level()
> callback to the DAPM context struct. The DAPM code will use this new callback
> instead of the CODEC callback. For CODECs the new callback is set up to call the
> CODEC specific set_bias_level callback(). Not looking directly at the CODEC
> driver struct will allow non CODEC DAPM contexts to implement a set_bias_level()
> callback.

Applied, thanks.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpexVAAoJELSic+t+oim9nx8P/01gg0qJyDytDk4oCgAWhgeo
3tmXMRgxYzRx9kYw/8go0QL1NoWSaT8h8xrRbouWEOx3OJl2xeLdpXpmrIXMwY5p
4nFYqIdCm8bvo+HjbwcnqhcKUdkKULm7dmhpFzASmRbl043pY7YGHK6YdzVbpk+g
MUGe6pKEfshaxDSLjxrRnaoZlA9lXveqntX3O1LfpyB7j/QqMyjDvw886mEPnYAX
csCJWTIZGXvpKMGCEBUuA0pSn+lIzORSmfbfc0TZnvgynMRI+pRdNIvsDr2x6avG
M+JiI+OPAqpDAmoSUDpqEIVVuB94IQvtSy8x9/cRbFxI0h6MXvNhqeJO5RIdS8xp
qciN3wF4WCd7XzDS+NDnmkU8CLGubso/OizKXVTQ/8nT0TCpxTdqDwsW65nk1rot
npEqFP1AZKzF3T+bHqmnXDs5egb94ywtS6NgLfrQCW7tOmiNKEGXXkqt1tQGNvmO
2auUU0YaF0Ay1VSi7dHA9SRhNwkThUe9rtYhvBvrXPD2KlPdqpTMmCE7Hnel+6Yb
V9oelMUQOTbieUJzQI/LvmIsRYgU7twoRGFVhXHDtTUQNddex1DF1sPvBS62eQ+r
RMBzaYu1vUqL3OmSbw/eecckUxHFIKb7ECL3Rhl5fJKjwLVq2Dxn+iCSDA0vgXAT
NcuO62DUitMr0cKOt6c7
=Gfxw
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--===============0100303639371600434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0100303639371600434==--
