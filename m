From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 9/9] ALSA: compress: use rate values for
 passing sampling rates
Date: Tue, 27 Aug 2013 15:27:26 +0100
Message-ID: <20130827142726.GK10783@sirena.org.uk>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-10-git-send-email-vinod.koul@intel.com>
 <20130827132959.GI10783@sirena.org.uk>
 <20130827132641.GC2748@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2302276938872069873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 114C326520F
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:27:38 +0200 (CEST)
In-Reply-To: <20130827132641.GC2748@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2302276938872069873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rex5+51txc1ort/q"
Content-Disposition: inline


--Rex5+51txc1ort/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 06:56:41PM +0530, Vinod Koul wrote:

> > > - * @sampling_rate: sampling rate of audio
> > > + * @sampling_rate: sampling rate value of audio,  eg 12000, 48000

> > It's not clear why this is a change in the ABI - the values written and
> > the types don't change.  Personally I'd not change the ABI - it's a bit
> > late now that the code has been in the kernel for several releases.

> the problem is the meaning of sampling_rate. It was SND_PCM_RATE_XXX. It was a
> lack of foresight on my side, we should have done values which we are changing
> now to handle rates not defined here.

Given that the documentation didn't mention the constants and there's no
example users I'm not sure this is actually a change at all...

--Rex5+51txc1ort/q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLdLAAoJELSic+t+oim96wYQAIxGasHSHWv/586Z6Y0g0OLh
lMbH7ftvvDN0afDWBPt4XEB+XyyThI+kpGYQ/oEPmRIRWTP3y5hCS6ZrYi51rfoG
IwXo4cbVFULPRE2ixr5i4m0alTEV0Ru2UP+L32EffA1cEEO7PXgD1oqXEhnFPpXK
RrqLC8i20pLtc+yYkFi8QgDaIMHYAOVcE3N36QqkaWpbCPNLIU0Scj+MEQufn77V
gY6Mf98jadh+En1uRESqBas0qGsILDXYPPWIKQpD4Pr2DfvBHMKpFVgGxGXvY72E
Loprlnql822fv5sY7e4xep+fBXRbNDhfG0tLi++SPy/L5zI3P49OCGtVgTeAbOCh
tmm1XmJSl5nBiZr2Rhnyl5oFUWmmkW4nrwx3vIy7CWSbbnaPHnR4gXO4NW+hy6M1
EAAe4MG3FN/MR9PY8lqGEfpctXV98DOdMCk6xZr+ab5qweAscabvrCxLiezpQsxB
F1vFgepTmacxEtUilMMxGbgXcVoYX242wLoqFU8vdGxeQoWq30ZuigA9S8xR5G+F
A/DevqpM7pQ5lFAnouLrPKfoOuXOQSrkkCMGZ2f5Gf/z//ZFpmpKdOCt9Y4zWsg4
Eu5D/nmmGMmpKJ5lTawxUBMEm3MifwFju7vgmLmNSZX8OT3lnKTJ7DhNUNLeNf1p
TiQ6Uu4zLbKIGNST5hIU
=dLtj
-----END PGP SIGNATURE-----

--Rex5+51txc1ort/q--

--===============2302276938872069873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2302276938872069873==--
