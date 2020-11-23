Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61184C56202
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 13:53:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCF3206F1
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="viYUh3VC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd3Wj26o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCF3206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90C681670;
	Mon, 23 Nov 2020 14:52:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90C681670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606139600;
	bh=boR4AkcrEEwH8YMVfzi8MbbJuQfQ+H1mW665VtBRB8M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=viYUh3VCUvWgm54I2Jlqcx/oAqcuw4oiYUZ576Mh3I5iXf7u5dui0sQlfrvfHPeY3
	 h/1rScvLL2lWZboIMm4hF9Vue+VZ5gWPb6uvUJ+NQqPZJzAXfj3J/KeaE3WgUYAlWz
	 JUQPTkQMRsC1/mqRM0pzKVRA7Gao0eP3V8HSnVlY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34195F8015B;
	Mon, 23 Nov 2020 14:52:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29867F80128; Mon, 23 Nov 2020 14:52:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44C57F80128
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 14:52:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44C57F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kd3Wj26o"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37DCF206F1;
 Mon, 23 Nov 2020 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606139540;
 bh=boR4AkcrEEwH8YMVfzi8MbbJuQfQ+H1mW665VtBRB8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kd3Wj26oXt4JkqWcLdAI/UrZXil01vAUiLm/nvJCnf8AVE7PYeYDduM+1uDwVfIpJ
 XMpuhEG6GQIXDG/ob3aJ3qfwUCCfdfURursriDpm1NXI6ZiG2GOvsKA/1Bq91lbH5p
 3f/h/EfCIfR5S4zs1qxj9Me8X10eUbu88dyBiqx0=
Date: Mon, 23 Nov 2020 13:51:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 1/2] ASoC: stm32: dfsdm: add stm32_adfsdm_dummy_cb()
 callback
Message-ID: <20201123135157.GF6322@sirena.org.uk>
References: <20201121161457.957-1-nuno.sa@analog.com>
 <20201121161457.957-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20201121161457.957-2-nuno.sa@analog.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Olivier Moysan <olivier.moysan@st.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Takashi Iwai <tiwai@suse.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>
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


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2020 at 05:14:56PM +0100, Nuno S=E1 wrote:
> From: Olivier Moysan <olivier.moysan@st.com>
>=20
> Adapt STM32 DFSDM driver to a change in iio_channel_get_all_cb() API.
> The callback pointer becomes a requested parameter of this API,
> so add a dummy callback to be given as parameter of this function.
> However, the stm32_dfsdm_get_buff_cb() API is still used instead,
> to optimize DMA transfers.

Acked-by: Mark Brown <broonie@kernel.org>

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+7vnwACgkQJNaLcl1U
h9AvSAf/WFgrIuqIQDUIs360km6F5GwWucfjOP8gILvJEZDQP4/3Xv4CapLrxp8q
hAQg8uPm5B03L0l7jdvlQXgbHfNn2QT//ZoPQAq4JLFk4nKy1KreuVrCWlTIvk1i
JViW06D8pOIW9hB8SQ6IGCaOO/rU+jUTjVtXEi6gWaCCcBLvBdt+YHX6WZdb7mef
vNIvjCUNfH8NOd2GFqktNJ2aQ7AVIYK31vry9J/lUdl/+m1g/8oirvKKgwyauu3m
8Q/qXGi7NWciyLvoDyWmOfnxuOIPED4Xt7THFt/Q8Stj/JXGbklrY5IdJxV4pINT
DwLj/DSU8UP7+SPTZ5VXzamcUgFtUg==
=qkiq
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
