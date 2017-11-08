From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: use do_div rather than 64 bit
 division to fix 32 bit builds
Date: Wed, 8 Nov 2017 21:42:59 +0000
Message-ID: <20171108214259.cjqcc46wikoslx67@sirena.co.uk>
References: <20171108213454.7048-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1776374419573498235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3104267683
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:43:26 +0100 (CET)
In-Reply-To: <20171108213454.7048-1-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Alex Deucher <alexander.deucher@amd.com>, Vijendar.Mukunda@amd.com, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============1776374419573498235==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fz7rez7cayifead4"
Content-Disposition: inline


--fz7rez7cayifead4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 04:34:54PM -0500, Alex Deucher wrote:

> fixes: 61add8147942 (ASoC: amd: Report accurate hw_ptr during dma)

Fixes:

> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-on: https://chromium-review.googlesource.com/678919
> Reviewed-by: Jason Clinton <jclinton@chromium.org>
> (cherry picked from commit 7ca726e80f21abdbaed9a5a70def1c33a26f8533)

This isn't how we show cherry picks upstream for stable (you need a tree
reference of some kind) and it's not relevant if you ever cherry picked
anything in your internal process anyway.

--fz7rez7cayifead4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDemIACgkQJNaLcl1U
h9AX8wf+NfV9clmMLrgfUHhNH+fjLljri7qc2tiaH74YqU6ITCYabPv+lfVLr/nF
Lis6oXJgghN24Q5IcqV5qo69Sl90XgxKYCT5Wn91ehJRz8VhhHozw9LRMzg8t4km
tWaAXz6iFC7gN8uhq8bPZfKb6a8pkCdvm3c2lF7P7ZmeayTAO5GERVcPlaa0bQxu
2bt/KVeccCXmLqg2xgT1njyFSH58LEszECaymaBTWMYV+zy3e/TNQH3Y/hZR//jI
couPUbwL1j4Yw032vKG/U2aTewQJ3okVQF30CGpdDOGywMbPr5NB9CFwlggel5FU
kuqp7H7KUWazE5MeyCtwxddAneST2A==
=MnMd
-----END PGP SIGNATURE-----

--fz7rez7cayifead4--

--===============1776374419573498235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1776374419573498235==--
