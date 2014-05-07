From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Remove card's DAI list
Date: Wed, 7 May 2014 10:21:38 +0100
Message-ID: <20140507092138.GE22111@sirena.org.uk>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
 <1399361981-18518-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4873329349348446536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6817D2610B0
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:22:05 +0200 (CEST)
In-Reply-To: <1399361981-18518-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============4873329349348446536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NTDLp0XeCpa8ZytR"
Content-Disposition: inline


--NTDLp0XeCpa8ZytR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 09:39:37AM +0200, Lars-Peter Clausen wrote:
> Commit f0fba2ad1 ("ASoC: multi-component - ASoC Multi-Component Support") added
> a per card list that keeps track of all the DAIs that have been registered with
> the card, but the list has never been used. This patch removes it again.

Applied, thanks.

--NTDLp0XeCpa8ZytR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTafsfAAoJELSic+t+oim9E/gQAJi82/bnq83pDzul1kqg+Vmu
dJMVVbO4tFH6FOHbKswzn29LxUaGwq4DeG0SqypM2Ss5F1AqaNdn1S2JbcEORxaX
eAbCPIO+VFsWKN6E/eDkNFJ22J9NTRnoFJab7Bl0Uo55z9WpJgr/C24RKKlXqDOm
wEj8zYVFCoGImQArP3S0A+Y/fxWOPoKq7fX9w8qfN7t3X5iBmOb+rS47Leh7Bb5d
yzT//o/+JaRblH9stPq0MU0Rl1OZzl+5vIyiqahT6Goff4/LtZN2xaDghZYN/vMu
qmHuAMo/QHTFDQvbgnJSBMyluZ4uTBOSdsY7jrBASvOSTJ0T8jAiEtXJd48xw8NB
p9gUZlCkuDRj1g074N67+M0IyPUEAdNNg2ip1Jpe6hw+pkmh2Ds12TNSPfiwkJ+o
IAALXRn2E5tWezyrIoE5zS7/iE7OxlAMH3JN4ntdYT8xEj2x7kHFZSXWmMMombxk
yD1i1RuoztsIvDUzj5tmYTVB8mXJCOz/iYsBuZ8KncU/s+8kfya726jcQfnTJEfV
0gg3fTQs6/rocNNWVs9tBMw6/vbRugbFptfbG3YPnKK7EIfsMcU4DPvutS5gH7ZU
J/ggXoXYH5BC88n2uZa5UsAONLFA2RMDr4v2/YqIek4Nrl9hGTcf/FGeR7P7SVP+
z/bNkcNZMRL9e2fIVhWE
=G886
-----END PGP SIGNATURE-----

--NTDLp0XeCpa8ZytR--

--===============4873329349348446536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4873329349348446536==--
