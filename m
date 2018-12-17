From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Mon, 17 Dec 2018 12:18:58 +0000
Message-ID: <20181217121858.GB13868@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0190393745984609847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D9EDD267A94
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:19:00 +0100 (CET)
In-Reply-To: <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0190393745984609847==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 02:09:00PM -0600, Pierre-Louis Bossart wrote:

> There's no mention of any buffer so it's likely plain vanilla VAD here.
> We've seen two choices to warn userspace of a acoustic event, either use a
> uevent or a kcontrol. I believe we ended-up chosing the latter on the Intel
> side in the past and that was also the plan for SOF.

It sounded like there were some separate audio streams somewhere along
the line, it wasn't super clear if that just went into a DSP that did
the VAD and wasn't visible to the rest of the system or if it's
something the system can see.  Generally we have gone for kcontrols for
event signalling.

> In terms of configurations for the PDM we have completely different settings
> since we pass explicit coefficients while this solution passes qualifiers
> (cut-off, quality, etc), not sure if there is any point in trying to unify
> those parameters.

Yes, I don't think the specific parameters are going to be joined up any
time soon - it's more the overall shape of the solution.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXlDIACgkQJNaLcl1U
h9ClJgf+OLM4U6BF/ObfLIVklTQIFe3fnUCsAjOD91k7AY2TiZoQxvLazrtoOE+i
dRjGs0PQwqS652wDuHAz8g3sB0IPsNekYqAk/dA5sy1vTSXGjOqljs5Gp6xnGZnv
634cmVPiM3tKVqBsSb9QPLoy58Q7XTlzNnAp1bRvDdQXw1OPHs0M1NFY1KXEDshI
HKwEmnw8R1G+661GVA2nnOcmsHDBYyY0Pf1oOjOGsekU8eCx+SfTL+5sHZxDaSto
AlHuok6Qd8z5qm+DOdoFo2l5BV2Wa9ikc901Vouvy7Z+0Xp/inULSYBuFuIZknui
/8a2LFoYBkHelcGJJwJorSFUzlCBLw==
=WGuC
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============0190393745984609847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0190393745984609847==--
