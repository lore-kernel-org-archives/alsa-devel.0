From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: mediatek: mt8183: add
 mt8183-mt6358 machine driver
Date: Fri, 25 Jan 2019 18:10:46 +0000
Message-ID: <20190125181046.GC6939@sirena.org.uk>
References: <1548139153-18783-1-git-send-email-shunli.wang@mediatek.com>
 <1548139153-18783-6-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7842742457287653816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8114226680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:10:47 +0100 (CET)
In-Reply-To: <1548139153-18783-6-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shunli Wang <shunli.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============7842742457287653816==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 02:39:12PM +0800, Shunli Wang wrote:
> The board uses mt8183 as SoC and codec as mt6358.
> Between SoC and codec, a mtk-properity audio inferface
> is used.

This one also breaks the build:

Applying patch #10781729 using 'git am -3 -s'
Description: [5/6] ASoC: mediatek: mt8183: add mt8183-mt6358 machine driver
Applying: ASoC: mediatek: mt8183: add mt8183-mt6358 machine driver
scripts/kconfig/conf  --oldconfig Kconfig
sound/soc/mediatek/Kconfig:119:error: recursive dependency detected!
sound/soc/mediatek/Kconfig:119:	symbol SND_SOC_MT8183_MT6358 depends on SND_SOC_MT8183
sound/soc/mediatek/Kconfig:109:	symbol SND_SOC_MT8183 is selected by SND_SOC_MT8183_MT6358
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

make[1]: *** [scripts/kconfig/Makefile:69: oldconfig] Error 1

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLUSUACgkQJNaLcl1U
h9BJ4Af/YrLhLJcJcSiPwU0QrlKm6wH4XqoZHRsEbtjsD6EJ6lXNVOEJXSfnrR5u
c/ykZhI8CmoedZkE8TrOMqyuYwSccR3nbZmIM87N4ywLTDwALppymEA/sKCK9Owy
g6mYQtG8BLCOJlhpsMH8JZGvRT5gCZEci34fbNSbtaLLqpUJgJLCvPoKoWtQ6X3O
6FzPF3kHMokmJZolQ4kuI4zsvGqh8iQDQxrLvwSz2sMG6wwjup8v80zHfAlz6GF9
gEeNHKIoDzqmlCjyIjleI/bvvx/+kffMQ6AHXYWx/RJu9znr6ISRbqs5oX9EwhQQ
UtDA9lV39NDy+jvvSINTjMLucwvWBw==
=CKCi
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--

--===============7842742457287653816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7842742457287653816==--
