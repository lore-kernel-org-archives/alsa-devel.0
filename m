From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
 polarity
Date: Fri, 3 Nov 2017 17:20:49 +0000
Message-ID: <20171103172049.d5o3qy54b5ci5jhe@sirena.co.uk>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
 <20171103114526.hjjmkkmkbxmotkpo@sirena.org.uk>
 <403c4e22-7caf-0a31-90b8-46586f8f53a1@taudac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0419662770112000903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 52779266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 18:20:55 +0100 (CET)
In-Reply-To: <403c4e22-7caf-0a31-90b8-46586f8f53a1@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0419662770112000903==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srweh3d7tdpwhaav"
Content-Disposition: inline


--srweh3d7tdpwhaav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 02:05:30PM +0100, Sergej Sawazki wrote:
> Am 03.11.2017 um 12:45 schrieb Mark Brown:
> > On Thu, Nov 02, 2017 at 02:23:02PM +0100, Sergej Sawazki wrote:
> > > After checking the code and the datasheet, it seems like we are handling
> > > the clock inversion (SND_SOC_DAIFMT_NB_IF and SND_SOC_DAIFMT_IB_IF) not
> > > correctly.

> > This doesn't apply against current code, please check and resend.

> It applies against "for-next" (e67852427fb). Is it the wrong branch?

It didn't apply against my current for-next branch when I tried, are
you sure you were working with something up to date?  I don't even have
a copy of that commit locally, even in the reflog...

In general I apply things against any existing topic branch for the
part, or against any fixes branch, or against Linus' tags.  Exactly what
depends on what kind of change it is and if there's a branch already
there.

--srweh3d7tdpwhaav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8pW4ACgkQJNaLcl1U
h9AF0Af/duL/kVdQBICfmHplA3MHAVmueU6kf7uG6BoT5z6RemEtQ/u5nKk0bCZi
9uq37LLG8Lv8vCWPRd18P91dK4iZVXiHTMeRd7F4BItqlh2P6waeweWXaQP8/CRx
uB7C5dI+C/SD2A0Cz2cOX2mvz5XnDPTqY6AxmwU+l3Gk3gZIzsd5rESGwznAzGPR
NexNYI0Mf1L8uPUeJz3UBk1qa8LzuUHW5XPd7qhsfTNoiVvdBGY1J+vxAAHN7qq/
7XDbWYBjmudzVf0UGHcNvTs6MJASBVupQvPR2YjE7E4GjBmGaSiNtB4KLtCAHaCH
sk2ZXVziqsRfs8kjDo3JNK5K9Mtw4w==
=cSYe
-----END PGP SIGNATURE-----

--srweh3d7tdpwhaav--

--===============0419662770112000903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0419662770112000903==--
