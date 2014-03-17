From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sirf-audio-codec: Remove
 snd_soc_codec_set_cache_io() call
Date: Mon, 17 Mar 2014 16:53:35 +0000
Message-ID: <20140317165335.GU11706@sirena.org.uk>
References: <1394785572-28315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7841936937844943010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4695E2619F7
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 17:53:45 +0100 (CET)
In-Reply-To: <1394785572-28315-1-git-send-email-lars@metafoo.de>
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
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7841936937844943010==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hLTC+yGFJlatjToQ"
Content-Disposition: inline


--hLTC+yGFJlatjToQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 09:26:11AM +0100, Lars-Peter Clausen wrote:
> There was a overlap between the snd_soc_codec_set_cache_io() cleanup and the
> addition of the sirf-audio-codec resulting in the sirf-audio-codec driver still
> using the old signature of snd_soc_codec_set_cache_io(), which will cause a
> compile error. Since the core is able to automatically setup IO for this driver
> we can just remove both the snd_soc_set_cache_io() call and the control_data
> assignment.

Applied, thanks.

--hLTC+yGFJlatjToQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyiMAAoJELSic+t+oim9B2gP/RB5Pnu9lHlTF22XL7leLWkw
YreLT5ccuM+4f3ycFI+bq8YXrXxbyVbuTBF2UqEodE9yYoAPTe/UfEkoyUM9M+6i
IHh4wOY0MtHve1AqTcm3EHvvc2JLhmSZkRR7zsYeoU9AnU5/G8BE64KKpUarbNeW
5ksnV05ibT4qRt4c0dSh4/5ewVdki5xzL2Vi6W72YkJNIyWtRu1ZnY+4P4TKJuXG
VbXi0bMl1+fpfcT/ZYbBATEcX+ZLOWaEsUzE/J/N+8UTZA4oQbVFrcPYmRLh5exQ
M700/h2oih4IekhRP8S1Mw5kdlnplSShy/lVEkCz02wTH0Gm+wufCM61qdA/OTAu
phBA6ii/wHxIjolT+2cYMlXxzcv/IvLH+p7Hx/pApfqeWucwKY6OUPx9wIR71B8v
/8nhqFD5TnOyeBPdwDeXuU2RKX2inc/qjGxX19E3PJEyJ7e+W2mDpAttIT5kgSVe
4CC1C4EPbihww5un3tlTNMft5/QXdtfvrBoEe/FoesoA03ETGApVGW3C6jM4Ne1J
SI1ddG+C/dxhJmx0XqEoHL/PwXSJdSjPgDRdQvM9Ms1muKBpjRvLkKg5pqIHR1Ju
gfsH1Q9XMRdpvLov/xqHaTXYcblKBOtHBZMEwy0MnOx6EIyJtjbJL/UTDy39OXlT
SGQF521A+tCZ9UM5wJjD
=FLLN
-----END PGP SIGNATURE-----

--hLTC+yGFJlatjToQ--

--===============7841936937844943010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7841936937844943010==--
