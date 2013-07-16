From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tegra_alc5632: Remove unused
	mach-types.h include
Date: Tue, 16 Jul 2013 17:00:28 +0100
Message-ID: <20130716160028.GP22506@sirena.org.uk>
References: <1373972129-13767-1-git-send-email-broonie@kernel.org>
 <51E567FC.9050804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7450962819663789857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C63F264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:00:31 +0200 (CEST)
In-Reply-To: <51E567FC.9050804@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7450962819663789857==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7PAM/4G1BR2SfWzg"
Content-Disposition: inline


--7PAM/4G1BR2SfWzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 09:34:20AM -0600, Stephen Warren wrote:
> On 07/16/2013 04:55 AM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> Acked-by: Stephen Warren <swarren@nvidia.com>

> Don't you see similar issues with:

> sound/soc/tegra/trimslice.c:27:#include <asm/mach-types.h>
> sound/soc/tegra/tegra_wm8753.c:31:#include <asm/mach-types.h>
> sound/soc/tegra/tegra_alc5632.c:16:#include <asm/mach-types.h>

No, I don't see any issues at all - I've just had a poor quality problem
report :/

--7PAM/4G1BR2SfWzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5W4ZAAoJELSic+t+oim9IUcP/jZINwI7LOfH3qG1gdVEI0Hm
YkjAXbxdUhU27onV30pij+X0BOfeYlgZ5ZVFJYGREnRJBOY0YDftdT+BLEPH1QBN
ALArcPNNQC0L3DKlODK1eOiGxSFp0JnxDg6iKeC3oTQwdTQu17VgPEXx5gEvjZ8P
oSUH+SjNvec0aICE5SBb5u4fd8bKIerUvIgZBeqn8XKw+IaV8DOSbwnzWgribyQ6
ajSxckVWCMnc1dzM2iucMhz6/Yw9/vbQfE4UmPCNlGBrA7VY/pkPupKKwXsp64+o
mTCNvdf9IjaE3jbUNQbhdhv513OpP7+lazAxt7jLp9PJkpoYBX+DGxcpQASweHbl
lLNtZKcHoWSd+5qymetcsukHVs/VuIFpEbCTa04cSLQ11hK5ujoLk8my94/zqH9z
y3OEqxC7adF2El2U2qy+AXq9YfidaUsowRXleI/IS8iFlRTkdheYjepPiRMe6Kku
EDivZ1chP0tZ4fLA9tlWDcvZoW9Wq4aD5Dw9MFJ/BMmMpqd7qzAi2vpRV2tueDz+
RQe4KYcpgG8Sd3CFUS9EE3KTCkP910PcG9rMEyv9ZN5NWHnwe/yAwlbvRjlbxwer
D70Y8x88kWbWUV+ahmuzAbuTBj+yLb8ayLm3MafdLEP1dT6GkIwjfuDFtmEIJj+c
3HpIlEPP0i83FU27Algv
=KyqG
-----END PGP SIGNATURE-----

--7PAM/4G1BR2SfWzg--

--===============7450962819663789857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7450962819663789857==--
