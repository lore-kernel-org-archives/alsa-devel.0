From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 04/11] ASoC: topology: ABI - Add flags
 and private data to PCM
Date: Sat, 29 Oct 2016 12:43:01 -0600
Message-ID: <20161029184301.i6nau4cmjy2vmmlr@sirena.org.uk>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <ca7df25320660c431215fab29e74727029048702.1476166990.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7402500142608437493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5766266702
 for <alsa-devel@alsa-project.org>; Sat, 29 Oct 2016 20:43:17 +0200 (CEST)
In-Reply-To: <ca7df25320660c431215fab29e74727029048702.1476166990.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7402500142608437493==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ayxxdmjlvno7aggt"
Content-Disposition: inline


--ayxxdmjlvno7aggt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2016 at 02:37:26PM +0800, mengdong.lin@linux.intel.com wrote:

> +/* DAI link flags */
> +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 3)
> +#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 4)

This still feels *really* ASoC specific - both suspend and pmdown_time
are very much ASoC internal implementations of generic ideas about how
and when to manage things.  They don't talk about what the intended
effect is which makes things a bit more obscure if we come back and try
to change the implementation later.  Why are you using these flags, and
can we add *that* information to the topology file instead?

--ayxxdmjlvno7aggt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYFO20AAoJECTWi3JdVIfQltYH/Ajs/PDkVrjtrvsi4t2e+Xrk
FnjWou3XTVPj5Hh23lFXHakPdKF3udgWC5J2yxvRSV0U0+U0r+BT4LPVlSwKicDi
ySHNZrC7zK4djQxcrhqGBGXnboyGsM8O2VaQ7UtAfV/tZPusF5y3/AoOTv6hhCkR
2zVQg3ev1yAyhUPrABgAsSJZxjXOGWwvsBr/KN3bGrV1CHnTVRflJW3PKURg4ndb
fD0BuAoWX0n7vOO3B1SjXOPFEM5LIHIes1TlRO5W+FbDieZexSgoQGNi1fSR6tbL
vZu3zKlBg5A4KD4qYkn7/UzijyRF0otmVB18+z3dJHidZkTWfYMUEwVgDXPT6Pg=
=gTlC
-----END PGP SIGNATURE-----

--ayxxdmjlvno7aggt--

--===============7402500142608437493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7402500142608437493==--
