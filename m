From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Mon, 12 May 2014 23:09:45 +0100
Message-ID: <20140512220945.GA12304@sirena.org.uk>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1706665136267412891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 103FF2651C9
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 00:09:59 +0200 (CEST)
In-Reply-To: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1706665136267412891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwZyvDTMZq1NcpkN"
Content-Disposition: inline


--LwZyvDTMZq1NcpkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 04:47:43PM +0300, Jarkko Nikula wrote:
> Commit 10df350977b1 ("ASoC: Intel: Fix Audio DSP usage when IOMMU is
> enabled.") caused following regression in Baytrail SST:
>=20
> baytrail-pcm-audio baytrail-pcm-audio: error: DMA alloc failed
> baytrail-pcm-audio baytrail-pcm-audio: error: failed to load firmware

Is this needed on fix/intel?  If so it doesn't apply there...

--LwZyvDTMZq1NcpkN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcUamAAoJELSic+t+oim9YFgQAIrbC0mleCPR7ocMYEPrnKOM
OK9aFoeFTJxIwtwCj0b/JUCCGTuTTGYz9o9uUyEjszxYtiol1vq5BeZYlheT/wFZ
E6FZwmh18Rv+iZIn3XXwSsNvoPzlg1xsouSpgzVGYGaw/N9jKrVDUHVjQIsBuJRy
jdyTeUQLEvJCy1L8YuogmcWFutZx5UOBKKAW5mqVZLow+n3uALH0ifhwUC8RxLeX
kmUAdmTGTvMz7j4RgAP3SSaWmWC5q0QulNEVkARBSEAMEhz4APOxJlgbWRhjk6iE
bA9zVvqRpXz8aWvX7RG4kfpmJB3UDbJvyKRce4ODhIvMKW4UhkFhM7zBVMdOdl+R
HDkRmqLcgLGQEQdHnFEaz2AlZb7s2fXFTUvgENiDbjG9PtwqQDK2ExQ6sDV3N89k
nQGwSuDEuHDmY7K/5YcdDsstWs7GVBL8xazAp/MVELE+r0U9q56h66zGIAmcS8RI
Nlbrf5A/kSM6b9H0uNjN6i9NnJLqyPb00yteib9pFZv7hD7QveCgOMc6ChTC27bq
VfYX9aLnDjzNKoY1iNQxnL0qlocdfBs6etcP+UXYCOKL+z/eIy39Erw25Dw6VsiE
r55y3vqklXhNvqVXY/0v/LPZurQe5UVkm5/qg20gmgi6VBnfsikiahZkeWAbGo/i
wdyWm6N0TkNgFT2iB/1b
=yr9l
-----END PGP SIGNATURE-----

--LwZyvDTMZq1NcpkN--

--===============1706665136267412891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1706665136267412891==--
