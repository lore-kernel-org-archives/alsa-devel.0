From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Remove unused
	snd_soc_info_volsw_ext()
Date: Sun, 11 Aug 2013 12:00:41 +0100
Message-ID: <20130811110041.GV6427@sirena.org.uk>
References: <1376163190-25039-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0964292526902624599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 046722625CE
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:00:44 +0200 (CEST)
In-Reply-To: <1376163190-25039-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0964292526902624599==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="56jnwYyHVsKJlmXZ"
Content-Disposition: inline


--56jnwYyHVsKJlmXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2013 at 09:33:09PM +0200, Lars-Peter Clausen wrote:
> The SOC_SINGLE_EXT control has been using snd_soc_info_volsw() for its info
> callback since commit 1c433fb ("[ALSA] soc - 0.13 ASoC headers"). The
> snd_soc_info_volsw_ext() function has been unused ever since then, so remove it.

Applied both, thanks.

--56jnwYyHVsKJlmXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB27WAAoJELSic+t+oim97yQP/Am3DJ/K7i8fAp0dlmovRo8K
4qyo1U0bRYp8ELhSa6GWfWaU3z6jXoDMkioxDqMmfggggst2I+hIooQyxL6xMH25
YGxru3xBnfOgb/afZsYDMVak3f+v0mMMGGpPnvL2EINqKBfO/W+X/KFYyjOgXS27
BRw5OzdqNxU8YCxCi6t7rHTUOJjbV8u4vDmzvG37TKhMrPpFvlET0TaOQKMYfM66
Q27pH1OZ1V9MSoSG7AeMRcA615+Wwq7dPvCj+dNZqMtqxZz6I1OjI/wyr87TA5NE
BXtkCJWi2FqL1EkqhddqjEkd21ORtfPzflp7OufYDSIlw17fU0VnCQgcf5rhfR8+
xsFb92eAOv7HlV7PEmGPUlQdVOvAxxt22l2vZgns1FTx2eEiVcagvacH/KFBVrzT
JZSz1aNZwRmuwFrRQBB9Xu11gGB3wmb9w39gR/rOz/0o59zaSsokO+hnb1qJ7Mr9
RoxhQIThODqPOiZFUufce6/+cs84LZI8+dtb1hjmzwIickjZhqBFYLRlPucWYriZ
a3d7I07tH8xRefmcFTzAd/Wc+zdu5MQfnnHBCGmMs2io3BamYTyyaYquWg6ewOrC
YejSqrGIjKFB4er3WF41aqFqqisGlJi1S65UiOYDvnhnvXaNFtW42NL0tDmc2WPg
nhwAuWdfH6ZCB3tTq39f
=wxfl
-----END PGP SIGNATURE-----

--56jnwYyHVsKJlmXZ--

--===============0964292526902624599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0964292526902624599==--
