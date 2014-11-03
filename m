From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: use correct firmware name
Date: Mon, 3 Nov 2014 10:08:22 +0530
Message-ID: <20141103043822.GK28745@intel.com>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
 <1414666259-4450-3-git-send-email-vinod.koul@intel.com>
 <20141031125138.GX18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1099515515260176539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CB667260458
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 06:20:20 +0100 (CET)
In-Reply-To: <20141031125138.GX18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1099515515260176539==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 12:51:38PM +0000, Mark Brown wrote:
> On Thu, Oct 30, 2014 at 04:20:57PM +0530, Vinod Koul wrote:
> > From: Fang, Yang A <yang.a.fang@intel.com>
> >=20
> > The firmware name was used worngly, so fix it up
>=20
> Applied, thanks.  I am wondering how the code was originally tested...
The firmware name was not right even in the binary thats how we never caught
this early on.

Thanks for applying all the patches, I will updated the ACPI stuff

--=20
~Vinod

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUVwa+AAoJEHwUBw8lI4NHgQQQAIZHPnGIMqdFdfoN+pM/bY3Z
2Ncs1jENmp+XKaja/HYtmhwtPcPFY1KiU25gDWNnqlcBuu2zq6NLUYpMn+BtN7P2
cGTV9ZlFJDkBPYSO3catAT193O+5Xv95EN4QbfTjBXHlnquzCmjgytRMNwnAu8d2
Qh2qyakAXDbIy/XLWmXENLqeKvHSLPIjfBTi59VCI7eA0j3uQipH/slSsI02tHVK
YiFd5sArDFnBp05MKLwZPoSr+2GomVsnzbjRGsJgxPJPd5kxm1iO8l7yAmMW26GX
4/1scFSUpLNP6GHYvlPMOH9k0O+qC/EVVpfqVY4K6FV9rYjFAkyjYdEf2E4E7kMG
x1aRpIqQA4puOIqjhDmxK2GeI41I2X1aNHc7OFixnQFIEPf9Qk/rjKKAkXzwNZnG
lM7Jgi5uDUiFvPmcLdB7/fiHvEP4mGX+P6wblVZTeBoFVJvLO5YALRVJZmyCW2bC
6l9Uqpv2fbhuUrle5DNx6DBbBxxPF4u7WMr6el4IUw5E2AmT7gacPXGQwoYYhoWk
lx7kTp5N5BJAeGaBaJsb4WHPTXKtnhkVI38RRXVa8tsO7QvmW7CnhdsWI8OvQ2Zy
3e19fhB8Ig+gr2/g+PFEaPWyOD2eL2HM/2rgv2cLqme+T42IxFFn2gJngWqnp2fz
hGsVB3Yog/PDYQyTzMs+
=0MOh
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--

--===============1099515515260176539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1099515515260176539==--
