From: Mark Brown <broonie@kernel.org>
Subject: Re: integration into ASoC
Date: Sun, 9 Mar 2014 07:48:53 +0000
Message-ID: <20140309074853.GI28112@sirena.org.uk>
References: <20140307165335.GT607@lukather>
 <5319FE01.3070909@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3183520686666518171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D9D265550
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 08:49:08 +0100 (CET)
In-Reply-To: <5319FE01.3070909@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zhuzhenhua@allwinnertech.com, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============3183520686666518171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7Uw1KoBlYAJvhhj"
Content-Disposition: inline


--n7Uw1KoBlYAJvhhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 06:12:33PM +0100, Lars-Peter Clausen wrote:
> On 03/07/2014 05:53 PM, Maxime Ripard wrote:

> >I have a sound IP that is part of an SoC that I'm willing to write a
> >driver for.

> Which SoC is this?

I'm going to guess it's the Allwinner stuff.

> >Should such a hardware block be handled into ASoC, and if yes, how?
> >If not, which other framework should be used?

> It makes sense to use ASoC if there are components where the driver
> can be shared e.g. the DMA in your case. Otherwise you can also use
> plain old ALSA.

Right, though one thing to consider here is if the device is typically
used with external components - some of these systems provide a line
output which is then connected to external speaker and headphone
amplifiers which can be things that have ASoC drivers.

--n7Uw1KoBlYAJvhhj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHBzcAAoJELSic+t+oim9jroP/1Xedqr7WkLKB1rRJ+UfC8WT
pM5C2FIdj5RKo8WEhwPJ58G4RrXBXV6mPv/6vo1vCOA6Ff0ezBT3wU4/YJRY90Tp
H9vx3tFUakcCky/G5iIcTVPO8J2JKZjJn7WmVGRfH7IGmyiv2ZmRUS9mgZt/xVSA
a6kVofTt4jpfGewaHlgkOmk4ftqZt7+UYxaNdVPRpRHesUlkcStbw8zoZQa4V/e0
sC3WWAOjvM7frxBcYjh/ArFb8U1SnNABM8O1EHHxh5tXj+zhJBjAxRLN4fQ9AF4T
AJ+DEtk2BBChY45gTJtcSsFyzidHuUiQM3COGiRB2LFJhq0HAsGuAIqMS95aYmgL
kHZNj1SuuC/NTRyhNAn+Zqp3b6fJzKaLARWe7w5PxUic1YgR3eaDBYG1OUJjzMsW
1lqm/V01xclZdXIlq5LLiZFsGdi6UNFfFI0HN+8t27DGGlliTR1uLFRLRPGpKMdP
K8baaw5t+Gg3PjUXOoW1TXIjiYSfDYXxt6xmaXrxJye7rwOvcOyfgXsOBDGTEB5c
bX0ZCcOKVpXr21jlis7y6bS8XIjJykEhyNh3GMwDPeAtVzwiSm6AItjjQeMZQiiP
asrrMjq5Nzf9PIXzftlVKIQaRFJqARDpg/xHL14Hqy2ox319RJG8DfCKs1TGUqH0
TkrDmEkJn4s70MLk7wRr
=XvB7
-----END PGP SIGNATURE-----

--n7Uw1KoBlYAJvhhj--

--===============3183520686666518171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3183520686666518171==--
