From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] ASoC: sirf: add sirf platform
 driver which provides DMA
Date: Wed, 8 Jan 2014 12:25:25 +0000
Message-ID: <20140108122525.GX31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
 <20140106170715.GK31886@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AC86DD2@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9131042318563542720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2900265184
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:25:36 +0100 (CET)
In-Reply-To: <86130EF012BDF348AA0D464A4F449478012AC86DD2@SHAASIEXM01.ASIA.ROOT.PRI>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rongjun Ying <Rongjun.Ying@csr.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Liam Girdwood <lgirdwood@gmail.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9131042318563542720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YoMA/30bvgA8rYEr"
Content-Disposition: inline


--YoMA/30bvgA8rYEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 09:01:15AM +0000, Rongjun Ying wrote:

> > module_platform_driver() if there is some real hardware here.

> Do you mean to add pcm device into dts?

> pcm {
>    compatible = "sirf,pcm-audio";
> }

Only if this is an actual dedicated hardware block which as myself and
Lars said doesn't seem to be the case.

--YoMA/30bvgA8rYEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUOxAAoJELSic+t+oim9MHIP/3+gHabE24iPkP3g5vN8OZta
zZEGGn/fKnTasHedSHUtkGstMk4maDghaZP8a+o9r8hiZq6s0grP0pFEUpsfvWRU
t4qs2hPbAZOEPca1rwxy/EZi443YJj7T4SkmnFip3q4WKP8Hmhkfim86WUjD/qUX
k97KfzvX8DRCFdsJi3put/pbxwxOo91NRke0AHeCnvNV60wkXbf8g57tXJ83Lruq
d3QoGXxMIprrhAi4K049nFSXsdiJuSS7ejEVGqkf9zeeKhMHg1ljz0gybLM49QAs
Isk3tl7UlRJlFkoK3oe8N7hJE7IT0Jc6MAvF3rEfpddT85vkXk3MU9gfHs2/YkJX
OlMttx2SP3QihlAkOGg86yEpWrG2il0/dSO/XKyrL7nB1hIpNLa4Htn9jeKU/F0P
oi57ncophail3lAled3nDJtZXmxY9ssNbD8VfScePRLcB1XaJqe7IPByPCjkDZF/
nKvBryNdm/L6sbrqq7qNAARvfeCdA99668GFI06MDw3KnWoauftRdmXyr142RG8E
RLJFxnACgCfPjEsti/sHxj39dazDXUDdSaLNfn0Z5s50kq3wkmsHTFgufuCHmW0y
qvITEVHp4waN3CilWRl+S7Obk3uk5ZP+qbkjRscS14rF97Po9b+jQHMlpj5oHMaE
i6mI2AtyLCrMAnzi041T
=etg6
-----END PGP SIGNATURE-----

--YoMA/30bvgA8rYEr--

--===============9131042318563542720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9131042318563542720==--
