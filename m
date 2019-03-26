From: Mark Brown <broonie@kernel.org>
Subject: Re: 'modern dailink' transition
Date: Tue, 26 Mar 2019 14:20:57 +0000
Message-ID: <20190326142057.GD10898@sirena.org.uk>
References: <21d1e439-7ecd-dd6a-9a43-e66e8db1ac85@linux.intel.com>
 <20190321141242.GE5684@sirena.org.uk>
 <87ftrbivbr.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8987415220296586693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D8CFF801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:21:00 +0100 (CET)
In-Reply-To: <87ftrbivbr.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8987415220296586693==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 10:54:52AM +0900, Kuninori Morimoto wrote:

> This is my understanding, please correct me if I was wrong.
> I think current many sound card which doesn't need "platfrom" are 2 patterns.

> 	1) select snd-soc-dummy as platfrom
> 	2) select cpu component as platfrom

> Current ASoC selects 1) automatically if .platfrom_name was NULL.
> And driver needs to have below if it want to be 2)

> 	dai_link->platform_of_node = dai_link->cpu_of_node

> But, I think one of them is enough ?
> I mean select 2) automatically can be OK?
> In other words, current some sound card which doesn't need
> platfrom is calling snd-soc-dummy platfrom method in 1) case.
> But, is it needed ? I'm not sure...

> It seems snd-soc-dummy platfrom is caring about DPCM-BE case,
> but, I think CPU is snd-soc-dummy in such case.
> Maybe we need same cade to dummy CPU (?), but *my* DPCM system
> is working correctly without it.

It *should* work without it.  If it actually does work is a separate
question - that code is a bit fragile so there may be some problems.
Since the most complicated user of DPCM is x86 I think if a change to
this stuff tests out well there it should be OK.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyaNUgACgkQJNaLcl1U
h9DlRAf+PRcYLMiWWNz89wO9T0YPT4urrvd2cm6VWyOfcHG6ls8k/Asi0ixM4gcl
wJTLUv8rk0FiFmv6Iya9hDEiBjwm7Ah0fqanoVB0/HyCVRs+DnBBkEk+Ko76wRT9
HbxUvsHhblGok0wBRRBYagG3mQYEKjxFDRLLI3YM3pg2MgPzT4wxfpllkLQ2xXAM
gG/fuuPPMmPuCIDvnNuOyLz4uj8mHmqU1jqwH6vY1PlqTKcg4THWOhOANMZESz9K
7IGQmluBCTLoTM8JjlVLPMi8gw51OpZCbGL94z9+ixx9mxemINlcpJJ618WfdL8X
vavfmdZT5jVgBF2q2Eitq/LTmI+jCg==
=Q2VD
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

--===============8987415220296586693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8987415220296586693==--
