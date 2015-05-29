From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DAPM: Add APIs to create individual
	DAPM controls.
Date: Fri, 29 May 2015 11:24:44 +0100
Message-ID: <20150529102444.GN21577@sirena.org.uk>
References: <1432574477-7350-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4247598958204349665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A22260692
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 12:24:50 +0200 (CEST)
In-Reply-To: <1432574477-7350-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4247598958204349665==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3EIvqNBXxBDuQt3l"
Content-Disposition: inline


--3EIvqNBXxBDuQt3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 06:21:17PM +0100, Liam Girdwood wrote:
> The topology core needs to be able to create individual widget controls at
> runtime and driver init. Add a regular locked and unlocked API calls to
> facilitate this requirement.

Applied, thanks.

--3EIvqNBXxBDuQt3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaD5sAAoJECTWi3JdVIfQ/zoH/RV8uFhBaW6OaAj6fBIzMZQ4
vWjS9VhhCIF/QaGDOgpUCuE25Xy6cfsjCFI+3wddEnC32GXUJxUvbx4d6kRPSjve
wRSsJriAK5CzVCVGWiva92XDwOUVeSuXqorB8tfcYtvl/NMHsNpxpi8yACdW0l9a
gz6N60WQ0xZeEYQThmTWYSbrV071wmQtKtfL0yHg4/uNFbgPi0pVMqEGY2VPN4zk
9CvfwXb2ILBD4ZcPy9w+5D4kr/VTmJBGsUqnqsRL3KxmGbVVu3MMWmohLiIS8H6/
O37r8bnhSwtKRSRFK+YNwNneRY+FdkrdwI2R2zD1oecwRkMNir5ww6gTfFzmarM=
=8RIt
-----END PGP SIGNATURE-----

--3EIvqNBXxBDuQt3l--

--===============4247598958204349665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4247598958204349665==--
