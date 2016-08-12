From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Add token
 support for topology data
Date: Fri, 12 Aug 2016 16:25:32 +0530
Message-ID: <20160812105531.GL9681@localhost>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <20160812104107.GB9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7695522831922908676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C6B7D265D12
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 12:47:48 +0200 (CEST)
In-Reply-To: <20160812104107.GB9347@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com, Mengdong <mengdong.lin@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7695522831922908676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 11:41:07AM +0100, Mark Brown wrote:
> On Fri, Aug 12, 2016 at 12:29:49PM +0530, Vinod Koul wrote:
> > With topology changes in alsa-lib, driver data for modules can now be
> > passed in topology conf file using tuples.
> >=20
> > These changes allow private data to represented by tuples of type UUID,
> > byte, short, word and strings.
>=20
> A question I ask quite often: the topology code has been in mainline
> since v4.2 but still has a big old #error at the top preventing any
> actual use from userspace.  We're now more than a year after the code
> was originally merged and still no patches to actually make this ABI
> usable from userspace.  Where are we at with that?

Mengdong was working on last set of features for providing DAIlinks. After
that we dont have any more updates planned on topology API.

So I think we cna remove it for current cycle. Mengdong cna you please
confirm..

Thanks
--=20
~Vinod

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrasjAAoJEHwUBw8lI4NH0TYP/0ovezHdJhwAQyl4z7aoB+cC
mRxKmrXZIlh9Q+APVNydEwn0JH+xGKflzWmyhevQtrD6LTzp+UwaqO8igHiv8gIT
vsDj59t/qduwoDknkNdm1Nne5HXpo3qHnecUTX/QTHRc3b9spLDOdDiryoFkg0aC
sUDAQjI4ooKX00lV8JM9wPfbrMHWp/0ey2oZmhp1YWmvvEHOxVubxicC/OLjE537
RGCACLbI59u5nEaE9skC9XhvEoFztTbeqR7SkbMAdMEiq3X8zoUUYobDxCAhEuaB
pOawVt/C1f2m9O1yp/GJDrhWrlPcxFbqHiXsX7on7uvlCX+C4ne/s8M1TStfSR6c
pVUSM0Eh+xt34zseo3Feu+WEroewKvhFU8O4Z3v/jAFaUQOtCr/8cEWo0WP5W6t3
N7oIdvzhaBOc0H/IzgNO/wPwWGEyfcm9zCjujWNy8XrbGIigWY9vBRUHRlY50HJ6
ZeefH0ETSC+IqGOZxwdnT3dkaMwQUjheUQsxbGNcl6n67C6dkr+qZJkWCzHQjG2Q
NTsrO9kxFS9ZfplGiqpWtwGcfHy+e9O9pethIIDHsfq3pDecoMcTj5azP55USlMz
2KZUHZvU5eFTCjUTExjzRiZT2tSR82Tgvk8m4zc6ket6RdvYFJK8v+Ji403axxYn
l7XPdQdKCmmiVmDQG8vx
=4SJz
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--

--===============7695522831922908676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7695522831922908676==--
