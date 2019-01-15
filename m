From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Tue, 15 Jan 2019 21:07:16 +0000
Message-ID: <20190115210716.GI5522@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4746549609875117680=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CFB2667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 22:07:20 +0100 (CET)
In-Reply-To: <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============4746549609875117680==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 01:35:07PM -0600, Pierre-Louis Bossart wrote:
> On 1/14/19 6:06 PM, Mark Brown wrote:

> > just pushing the breakage around rather than fixing it.  Can someone
> > with an x86 system take a look and confirm exactly what's going on with
> > binding these cards please?

> Beyond the fact that the platform_name seems to be totally useless,
> additional tests show that the patch ('ASoC: soc-core: defer card probe
> until all component is added to list') adds a new restriction which
> contradicts existing error checks.

Yes...  I'd been coming to the conclusion that it was a huge red herring
here. =20

> So if we want to be consistent, the new code should be something like:

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b680c673c553..2791da9417f8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1154,7 +1154,7 @@ static int soc_init_dai_link(struct snd_soc_card
> *card,
> =A0=A0=A0=A0=A0=A0=A0=A0 * Defer card registartion if cpu dai component i=
s not added to
> =A0=A0=A0=A0=A0=A0=A0=A0 * component list.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0 if (!soc_find_component(link->cpu_of_node, link->cpu_=
name))
> +=A0=A0=A0=A0=A0=A0 if (!link->cpu_dai_name && !soc_find_component(link->=
cpu_of_node,
> link->cpu_name))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROBE_DEFER;
>=20
> =A0=A0=A0=A0=A0=A0=A0 /*

> or try to call soc_find_component with both cpu_name or cpu_dai_name, if
> this makes sense?

I think calling _find_component() makes more sense here as it will do
the check it's actually there thing no matter how the link is
identified.  Assuming that does resolve the issue do you want to make a
patch given that you got there first?

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+S4MACgkQJNaLcl1U
h9BEmgf/StSJlLNq7xDriTlZVfHoP1uS7tq7ARPUsYy5hv82x0djcFHMfKwaaSF8
S0F7dCRPSko+Qn9l47VSnfC5d4u59YdEdfRJM+yktKgojY2EribB9Y7XldhNJRO1
FMnnMdPZWFHFMcGgs88h5xo/N7pr1lBvPcbksbXaSIAGead6WrrD8DTecYu8V+Kb
UEv2MEOmtSv+GJo+QT4Gi/NiKoaCn183hgulOkQSmkMLXGaBQedOSvxOt4fUvYKb
GIvJihjl7zjOohlf85V0l4wXVy0qKZm7szCz037yfiXWMPzr2Fo1sm0ZoGXd4BsJ
2JEQbrNH1hlj/8Jv6J1lZhVPScktHw==
=gEjB
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--

--===============4746549609875117680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4746549609875117680==--
