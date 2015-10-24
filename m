From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Update for ssp
 node index in copier cfg
Date: Sat, 24 Oct 2015 17:26:08 +0530
Message-ID: <20151024115607.GH27370@localhost>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
 <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
 <20151023163052.GI29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0860401625718881087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A51AE26574E
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 13:52:50 +0200 (CEST)
In-Reply-To: <20151023163052.GI29919@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0860401625718881087==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2015 at 01:30:52AM +0900, Mark Brown wrote:
> On Thu, Oct 22, 2015 at 11:22:38PM +0530, Vinod Koul wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > DSP firmware has interface change for SSP node index structure.
> > New FW interface removes the dual_mono field and adds 4 bits for
> > TDM slot group index. This patch updates the ssp dma to align with
> > the DSP firmware structure.
>=20
> This probably doesn't matter right now since things haven't been
> released yet but it's going to become an ABI issue...

Yes, I am trying to ensure after this cycle is done we dont have any more
interface changes..

--=20
~Vinod

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWK3HXAAoJEHwUBw8lI4NHOa4P/2sB3P9LXvQ3C01Z5NIViBeX
GwH1SCb6KmSY+ifWF0H1qZiS/tuSylHfJyO5vD1Wero2Y+j/cMSCJSGrf0Yu8ciz
CU4lhNOgAqVlJg7JaGKSNmNAOtiu7oEmFDS8FzKMI5o/gdii3avPrspt9vdJlAqY
x76ooCgvN5EtMONfSS5eTXg4B3uU8hamDpc9Q7P1xU/pmKZ2iaLGuKX9pb4/4S3K
twNnKtMZvfS03n01v01WyERRmrtqWaR0bo4wboGMWV1mM88qqqMiTGz0G7T/lgSJ
gYGevER1ROGmA7DhEGlLA1wF7aKJPTdgFVb+9PkRGA920BSjlM5NkRITDSBc808t
JvYJEk476ljVDbxyqPiFclK+eOEUKpfg1+FfPLKBZa9caef4352+KHF4Tfb42kaO
OuIo18eXw90v6FU9RaKk6m7w0YpFiRlsNQeLXOuavChs8qA9W0tjQiI1DQbjo7F3
n7jHTTzz/jMYBeBEL6xY0wa4ToNnqmu65uzseKSMvPeZMAlptNdx+rOhtuMjo6YB
y2EbvNJnvOUhT1M3dgmfxFNLXmyFXhNG/nr4MK8uFrSZnH6aZcW2eIrkPS207eEO
SwE5aud42Olx9PtFEFYnEpjmoDQ2jk3/bJghY4rFg+O4qy9f4PBftYuseOtQTVKT
NLxvllvYTda9cAnFoDev
=63X5
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--

--===============0860401625718881087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0860401625718881087==--
