From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: mrfld: Fix runtime pm
 calls in sst_open_pcm_stream
Date: Fri, 31 Oct 2014 12:30:03 +0000
Message-ID: <20141031123003.GR18557@sirena.org.uk>
References: <1414645736-24426-1-git-send-email-vinod.koul@intel.com>
 <1414645736-24426-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2214800041939597223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADB38265802
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:30:26 +0100 (CET)
In-Reply-To: <1414645736-24426-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2214800041939597223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/1aF9qoWKhphZS4n"
Content-Disposition: inline


--/1aF9qoWKhphZS4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 10:38:54AM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> It's already done in open/close.

Applied, thanks.

--/1aF9qoWKhphZS4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4DKAAoJECTWi3JdVIfQLdQH/A/NYDJQ33+HuyKgdOhTYp1q
UD8CStPuLytjkfWDU4r1mfMhkzBxEkU4vxced9ORtMMVRh2o31MwjoJjxzzToqmT
oornO2lxXdH2iI4wefpLCIAB5FRmq8SHAj/Ph4iYcAUDfh85Tz9HQcofUeWbNX0D
R+VxxWt8LmOZgJOp7ihvkThVZ0yhYblEw0yGMA8KFQitPjr07DfWtihNysCyigGx
AinJF4iFtHQ4LlbTKsATGdFPrhzEuTb4a4wTf1llRTxPoVG7ZFAR+xOFeB1QS+UX
W42NxR8iBV7v2ID5rh7NQ/tRn87I9/xIRtg6ZqI4tXd5LhjkKQF0lKmOLzCoXKg=
=WRIP
-----END PGP SIGNATURE-----

--/1aF9qoWKhphZS4n--

--===============2214800041939597223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2214800041939597223==--
