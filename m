From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5640: Staticize hp_amp_power_on
Date: Fri, 13 Sep 2013 11:36:01 +0100
Message-ID: <20130913103601.GI29403@sirena.org.uk>
References: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
 <1379065938-26728-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699843031111312280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B07D72615D6
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:36:04 +0200 (CEST)
In-Reply-To: <1379065938-26728-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============0699843031111312280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bIGFD+ZFpbo81WO"
Content-Disposition: inline


--4bIGFD+ZFpbo81WO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 03:22:18PM +0530, Sachin Kamat wrote:
> 'hp_amp_power_on' is used only in this file. Make it static.

Applied, thanks.

--4bIGFD+ZFpbo81WO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMuqOAAoJELSic+t+oim9ypwP/RFNEOG3mVBy+C1kgesjEnL/
lXN0FTDGfzJeicascqP+UpZRCKq/RbY3rdKoh2W9vyCdeRaqJBr0ZjGQKxp9p6dR
5JL6BBTP84OcZDigvEZWwjW7008lpf01h90tTcjMpFazcXLuskQa/PqbA3pu4ffn
908pvNRtFQ9xGKbi8u3iBh/7QNXhL5sUNLVMHmtlQ1wBH3soUisfpH7PGBhHnbWx
jmbP54OjcQuTh2pQlFFAi0byMUnHjP8sUs4qk/Sv4ynEbg3iyDR9kRlPbp2Uuusl
V1fyAehf7MOacFIpqpc0yh6yHE2LC4fnsNx8ojWC9a2R4SJqq9EtXb2SmmtRHlj3
CYy0VDdOdHhOVADPETsqI4WeCb7b5/HpSyuSQj5o/JH7gPhGLamDxhPWjo3XrdJi
/k56s69MYUhikTzKqWHcY9WqPb7/BNmyzoiUuJcaZqDH1Wu1Qgv6aYrEofvAQslZ
RvxhotLxbH/ZPCpekGrhEqAP671BnOQPXiyHV6cBBy6TD4qIydMKgCDPv4gz5ygJ
j0AnmZmWrcw0Sh1ipufMMFN02Nmady0iQqyzBbzVxBeeYsOHGEbxUnE6DwOxRHYy
T/qgeAcKXbYymYjVkXqaNm7CpVDvq7kL2hrZEJiiBfLaZzCsEhehg1uGySPFvIPw
ss738K4xU4FMzylM1//Y
=+IAr
-----END PGP SIGNATURE-----

--4bIGFD+ZFpbo81WO--

--===============0699843031111312280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0699843031111312280==--
