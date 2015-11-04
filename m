From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Wed, 4 Nov 2015 21:37:18 +0530
Message-ID: <20151104160718.GM12910@localhost>
References: <20151102153229.GP21326@localhost>
 <20151103112458.GO20228@sirena.org.uk>
 <20151103175708.GH12910@localhost>
 <20151104142958.GG1717@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7870879696070512296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 61482260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 17:05:10 +0100 (CET)
In-Reply-To: <20151104142958.GG1717@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7870879696070512296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2015 at 02:29:58PM +0000, Mark Brown wrote:
> On Tue, Nov 03, 2015 at 11:27:08PM +0530, Vinod Koul wrote:
> > On Tue, Nov 03, 2015 at 11:24:58AM +0000, Mark Brown wrote:
>=20
> > > I'm having a hard time seeing the difference between this and what's
> > > going on in sst-acpi.  They seem to be doing the same thing in slight=
ly
> > > different ways, they both match tables of CODEC IDs to machine driver
> > > names with the distinction being that this doesn't provide a firmware
> > > filename whereas sst-acpi does but the mechanics of mapping a CODEC t=
o a
> > > machine driver seem otherwise the same.
>=20
> > I don't disagree with your observation, the code does same stuff and on=
ly
> > difference is the data we require here, so commonizing becomes tricky
>=20
> The only difference in data appears to be a firmware file name?
The one atom code uses is quite different, but i did manage to create a
global one and ignore those in other places

I will send updated patches moving all to common apci match code and then
add SKL to common code

Thanks
--=20
~Vinod

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWOi02AAoJEHwUBw8lI4NHc8cP/i8Szd4BUN+C1l0Oygb0T5AN
vvrqrvrvcMTCVq3pHKuE22K4gkBeXApNiw/UtqNQKA9kC0PXrxa8YNdw539SFpWf
6Pomnh9zpkGUG8n2p6WSlI6xgYSt1YxShEvBRPvJVafI+wV2BxTglzoxuv3xgIiQ
2nu1r4DyyQ30uzK8gImURKXgvWPxtMlwQT18Bkutj3jWni5yDj6RizSLaXMuwQT+
blDJ7D1RUdOpspQgt2XZ/pcSe1w5PmyFJOoZGeX8PGlMclp7+Gqz2L2p18HiazPx
wStsP9w9hmrhfwy1Oqb5Rc3EH1zsAeUmfrc34TNa8f2jY4fbwTxPlm58bLm+djaO
xLO6HrvyHX4ImJ88ZezmvZP2NJWLlJwLzDgqIdsI35soCT9f/KtSbIKLmwe8l/tF
8yLTU2NvROKCrCcZc/IyklzHhkspUxKfoCYEvAqK+Qy/hAnTrk1M78RELLN1hU8y
YQLDOjgdiva/rk/kMA+dkCmUuoECpmen1MHFWxRa08Yc4Oo3bdEIfEkBrom4jS3l
+mJtTBa4OBDTMGM6nuRVYL1aB3u7BYUHn4OWlOI0PLkHTC1YIdosG4ARv5q9Jw1C
kv1ZCLKOqPeAKNCrfxUhhYqqEEH9JMz0tPhYKAN6Blqqi5cY62DnViyA0W2Zq+wK
b+M0K3BtnXXkQdMbwAqQ
=VGlt
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

--===============7870879696070512296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7870879696070512296==--
