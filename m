From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Sat, 30 Jun 2012 19:24:47 +0100
Message-ID: <20120630182446.GA28922@opensource.wolfsonmicro.com>
References: <20120630113949.GT28922@opensource.wolfsonmicro.com>
	<1228563845.386649.1341061389052.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7766120829952654764=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAF5C244CF
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 20:24:49 +0200 (CEST)
In-Reply-To: <1228563845.386649.1341061389052.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7766120829952654764==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5wOvoHkaccQRDme"
Content-Disposition: inline


--q5wOvoHkaccQRDme
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2012 at 03:03:09PM +0200, Beno=EEt Th=E9baudeau wrote:
> On Sat, Jun 30, 2012 at 01:39:50PM +0200, Mark Brown wrote:

> > Actually I'd really expect it to mean exactly that.  DAPM is fairly
> > fundamentally dealing with single channel audio streams and I'd expect
> > that if we did implement stereo controls they'd allow these streams to
> > pass through without getting merged.  There's a couple of things that
> > stop us doing that right now but I don't think we should add stereo
> > controls that don't do that.

> Can you be more specific about what stops us doing that right now?

Nothing if someone wants to implement it.

> Should we drop this idea for now and simply remove stereo from
> snd_soc_dapm_get_volsw()?

It's going to be easier to remove the code if we're going to do anything
at all, though there's no great urgency.

--q5wOvoHkaccQRDme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP70Q7AAoJEBus8iNuMP3d1TUP/ROFUEBl8hgI4l0GzCOXmnlT
QkHsWKD/3bVfZm/9BfoUGgUCpYJNRTFbQGIf3w+u4TqlWLsOtPMLB53uSGIH5fbp
ISXGjH5IxmjaRUkzshdd0zrcY11vnhTH6o6gKjsCCIM8t1QuO0QD4sJUFJ6jMnWX
7HDuPOyM94StFHavAMbB8tMoXmbZuQ44t+5vxtoE7jt2FsYwspnY2l/ZbxbUDrSy
nDW+ZgJFOcOyCg0ufP31PeITtAkkqWctJxjmNUwOW4TW0x3wLMF8nKCxFxHUel92
hnO/a8MZNyu9qTPdRIVBYgUOjFo+uv/rx5Kji/ZpJFfTXMBew435dC7M4l7/2qha
AVuujLHkismCvJmHTu+wZXazpcpeRkf65IahGArDvjAbxeoCMq2YT4nGiZhVV49q
hLYspPrQuvKE35xeTsl0voeSforDIWWZAsMxPexCYWhy1ZkafizNlQiczsgxLLJg
qTCUZZHlTzLIGbRhLoJLGSS1H60rPxeLGSIe9dbspzm0ZGNZ07al7BKCU8932GJl
LpjrP5LPqR3rgZWtea00ynPougvh0cc8LUt7bZHIK0z6vL6By/O+f0WnVMUMmI0H
rqOAOwzG07L4FDIMT1J0Gfcuf1a2FZBaYTGdfvSuYtjG8kC/yoqKXlyRE7PZktzq
I4gwz6GBnkfaB3EG6Hhd
=BdPW
-----END PGP SIGNATURE-----

--q5wOvoHkaccQRDme--

--===============7766120829952654764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7766120829952654764==--
