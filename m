From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] ASoC: ak4535: Cleanup manual bias
	level transitions
Date: Wed, 22 Oct 2014 11:34:24 +0100
Message-ID: <20141022103424.GM2344@sirena.org.uk>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0366781370916719283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 406A926060F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 12:34:53 +0200 (CEST)
In-Reply-To: <1413795399-29952-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Johannes Stezenbach <js@sig21.net>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Sven Brandau <brandau@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0366781370916719283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 10:56:28AM +0200, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied all, thanks.

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR4gvAAoJECTWi3JdVIfQsisH/jFdcLiJn68856ZI8SPrU8ht
/RoAMBbSkRJYKSFO2kF+bRAul0/fJDRRUBVj20HyQV6POozeZlmgF8tZ9tR7kvp8
yVeBldkHyF5P/JE0YE6bBDejdapF4RyvLLIzLJLBhsOdrzz6Q98ST8GkmFdm6XJn
9Shn9auNHZES+DPqjzNcxtZmoxvkUpAPjcqIy4e2zss3EEKkA69QwDLOg/dxLvN3
Uo7Ze8lrWqhiz7f8UFBhGLekXdM67GbOIrSzpfX98XCHKc0TrWkG8jNEMa8as2qn
06sgV1mQ6WzK9XgHIzMLZriacK0esWJpgqAmP5XUsQ+absnViaBU4RAWo/mnWiI=
=Ogmy
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--

--===============0366781370916719283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0366781370916719283==--
