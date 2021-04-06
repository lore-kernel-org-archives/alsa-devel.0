Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB29C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:13:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AA8613BD
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA8613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B31D615F9;
	Tue,  6 Apr 2021 14:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B31D615F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617711233;
	bh=udjAav7bT/GtX4j2qZfPClvGjEVb3zFlDKNJCDqZeSY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D11Kf0kmBb87m+TOAdMTrugwOQlks/lOa4TgtMpc/VLGg1pLMa1haAG+SLry+pOZa
	 CU0sbkLtCyuhoh5Yiv1QS8fYil3ercnqC56RQvs3BceS92K+IEqdVnzI4txXUP8Upl
	 VIbfc7uM7AhMo/jlbEcyS5B+SnG++NpgTw0ZsizA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F290F80169;
	Tue,  6 Apr 2021 14:13:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B42EF8020B; Tue,  6 Apr 2021 14:13:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40BA2F800E3
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 14:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40BA2F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cl89ruGu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D82E61042;
 Tue,  6 Apr 2021 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617711170;
 bh=udjAav7bT/GtX4j2qZfPClvGjEVb3zFlDKNJCDqZeSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cl89ruGuxDJojTuuUHgLsaNaum9Nub+GdQNUVjNMkmFQlj5Q82TgxnLsNfzei4dxL
 Y3tQAOwZr6AlffDNWfXgSVgLj4wau9Uj3k9+I6N75f+lsRy78WumgNdx90zJB+ttK+
 tmSVOYsv5H2HMQUZDAf+AoGhMdpc/1BmGqlc040pCTq2JR4ROc5xHxTpc3ZFVDv2Di
 p/YG5fc7bYtDUxOXmk6jIE5jfmgaZk8N3jLLI2gh3iNj7Jl6QV0H7FageymyR/wW9P
 karah1MJbN1LEfKCExf09OL/bxwt87bgEL251YSZZSizL9+BS8AegDlXM+cMIu6hVX
 wkh1M+gEa8stA==
Date: Tue, 6 Apr 2021 13:12:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 2/5] SOC Codecs: TLV320AIC3X add SPI: main source code
 for I2C and SPI
Message-ID: <20210406121233.GF6443@sirena.org.uk>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-3-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <20210406105018.59463-3-jiri.prchal@aksignal.cz>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 12:50:15PM +0200, Jiri Prchal wrote:
> Removed things which are in header file.
> Renamed functions and removed their I2C related code.
> Moved I2C code to separate file.
>=20
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  sound/soc/codecs/tlv320aic3x.c | 105 +++++++++------------------------
>  1 file changed, 27 insertions(+), 78 deletions(-)

This is not moving the I2C code, this is just plain deleting it which
will leave things broken after this patch - things should build and run
after each patch in the series.  As covered in submitting-patches.rst
each commit should do one thing as a standalone patch, and the changelog
for the patch should clearly describe what the patch does.

You probably want something like a patch to factor the I2C stuff out to
a separate file and another to add the SPI support.  Look at how other
drivers have done this transition.

> @@ -147,6 +140,7 @@ static const struct regmap_config aic3x_regmap =3D {
> =20
>  	.cache_type =3D REGCACHE_RBTREE,
>  };
> +EXPORT_SYMBOL(aic3x_regmap_config);
> =20

Everything else in ASoC is EXPORT_SYMBOL_GPL(), why is this
EXPORT_SYMBOL()?

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsUDEACgkQJNaLcl1U
h9A88Af/aJhsU8nK98jA/6Qk8CIbn4dakASZSCUSHvjhgexMDbCeQw7dB1+jHYu0
p6mmPDliAIcJ/pTB7S9Dh8CNI4oU2lA+71fCtkpw5DtOEkGDbU6okZpXzFVju4tU
pPijPZqbLzMCq9Y7A4H+ciZ4S/3oeNX1F/l1uK4HC3h2kF9TpOaD2pPJvqS9b2nL
cem8lzQ8SMdKQeczmbKBnRi5W+3UrckkU5Xz9zrfywWnEACzFfvUhCPqwi8Qm8VX
mb02AkSfMIgbbhhokiANjrWx+bv28bGCxX8PB4DGTUE3kWdP/o34s6bKPpOabJdp
678L1gzHhiyW8Cccbclu6tYvlXh60Q==
=LBwy
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
