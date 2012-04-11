From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: ac97: Fix build due to removal
 of 'runtime' definition
Date: Wed, 11 Apr 2012 11:43:03 +0100
Message-ID: <20120411104302.GI3163@opensource.wolfsonmicro.com>
References: <1334097504-14729-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118861731969516198=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC65D104324
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 12:43:06 +0200 (CEST)
In-Reply-To: <1334097504-14729-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1118861731969516198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Content-Disposition: inline


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2012 at 07:38:23PM -0300, Fabio Estevam wrote:

> This was caused by commit e6968a (ASoC: codecs: Remove rtd->codec usage from CODEC drivers),
> which removed the 'struct snd_pcm_runtime *runtime = substream->runtime' definition.

You're missing what I was saying the other day.  What I was looking for
here was something more like "commit e6968a was intended to remove uses
of substream->runtime purely to find the CODEC pointer in order to
support CODEC<->CODEC links but in these cases we're actually using data
directly in the runtime so the removal shouldn't have been done here" -
the thing is to explain what the change did wrong and why this is a good
fix for that.  Sometimes this is just that there was a typo but in cases
like this where the initial thought would be "why are we not removing
uses of runtime?" it makes it much easier to see why the fix is good.

It'd also have been good to just re-add the declaration of runtime here.

Anyway, applied both, thanks.

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhWAvAAoJEBus8iNuMP3dO0QP/2XNDkA7RoZvP3+izplKgsOX
r1+hE9NpkHBCP3zy5/GFqKlwLFUsN3dkLlyhABCqjOn0eKM2GW6pAzKi25DVosQW
WUfNqannz1FBguyqVld4PZyKinMGnILLQgGfQWo+aQKQJkRxLe76oMDj/l+G1jDM
UatFp/K0fiSbHKy5RTL1ccJsiazXgdZB90MLlw5rdvZe3qJeDjKN6way4Fr9fpPu
k6anlAdASNEbSnSsXOiUPNk20uCaqhMa5Sm4wX85Az+88KZjFlIt4eSSZYp/1SiC
jYHo1hXXVdF18k/Eap2iCF5aTADVLicR4wkXLwu/9RnXYLME9IGQgVjthN6qae1x
ZDggH8EyX334i8TBdYt2Z9S6uQudWtvUcpOx/waZHA7xzsn+pkS3NJT0mpoKMxE2
j0N8sADUSlU8T2S5vdMly/rvYVMiV4VxGSreKeeKtNYxy6nqpeWOOZ8NuY8FOhqJ
2YLDEO6kvn4+8ntT7NGCa8/pbsOnbWxV5q0MAe8UQgW8u55NgeN0XfU0K47wcKAM
mK/eKMYMssQlKCTOZ3VmXl5UNCr3COekGvswPb5CXuW3BcqJC1uugTySnYdQ5wS7
PU7UYs1uP9fpUl2N6VL0PWSViDMofPRen7VWVWh1oikGJpfEQbK65GiJUL7HzMAS
Pd+W6QYL1tyqgaMbepvk
=AtOI
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--

--===============1118861731969516198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1118861731969516198==--
