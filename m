Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF2AC433EA
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:36:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAEC2065D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CC/QfcH1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5zWQW7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAEC2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 547A2852;
	Thu, 16 Jul 2020 16:35:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 547A2852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594910166;
	bh=nxkcrc5P7Qd7poz1LmdDvcMFnguH4wq4okmKRFsmWhw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CC/QfcH1ZgdEVjlpSyZ6etVVx4Cvsn8eZalbwyRbypf7EtT0CK3TFe0M0kfB7icOG
	 f9HPG9I8z3VOl56i4UTBWhzNfJGWlpN3hvnlA9mtAQZc9xNlr/PP12CevHHXty1Rru
	 ry5yars7UEqVGwQRtRSnLvPASIhmTX8lQZsfy4wo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C283BF8016F;
	Thu, 16 Jul 2020 16:35:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3EF2F8014C; Thu, 16 Jul 2020 16:35:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4AC6F8014C
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 16:35:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4AC6F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d5zWQW7K"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4C7F206F4;
 Thu, 16 Jul 2020 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594910100;
 bh=nxkcrc5P7Qd7poz1LmdDvcMFnguH4wq4okmKRFsmWhw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d5zWQW7KcwQQwGsZLtlihkD9diBPlVE3DBlaRFuftlKxZJ9FVattsI4I5Lc5ENbS6
 68oniVnmgwkk+HemvqlyT3+a+Hh1TY0Gnd7IxVfpyVYoSt8jOuG0WBzyiv3oJVZgbP
 AkJnG3L9x3uLfQ8tI5QQ0QFX+YzK4k1rEXAGhr6k=
Date: Thu, 16 Jul 2020 15:34:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: add the missed kfree() for
 axg_card_add_tdm_loopback
Message-ID: <20200716143450.GB5105@sirena.org.uk>
References: <20200716132558.33932-1-jingxiangfeng@huawei.com>
 <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
X-Cookie: This login session: $13.99
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, khilman@baylibre.com,
 tiwai@suse.com, linux-amlogic@lists.infradead.org,
 Jing Xiangfeng <jingxiangfeng@huawei.com>,
 linux-arm-kernel@lists.infradead.org
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


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2020 at 03:29:39PM +0200, Jerome Brunet wrote:
> On Thu 16 Jul 2020 at 15:25, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> > axg_card_add_tdm_loopback() misses to call kfree() in an error path. Add
> > the missed function call to fix it.
> >
> > Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
> > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

> Thanks for fixing this.
> Maybe it would be better to use the devm_ variant for the name instead ?

Yes, that should be more robust.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8QZYkACgkQJNaLcl1U
h9B59Qf/cQ/Ssu6kfNi9QbWnYWdZOWPmbzLXNPPSbdpuW2McJvjhrFAscgfM5b/m
+ShTyHn5oEztIfyoIXlaCPsfmNJRBjLotRdmo8xlZ3FyzgxAE810aNDKwR4uaOnv
lSByiQZOnNa3EhV5P1naQaRf/MLw35gsHixOxQBO3kLkkokx5GpL1F1quQC33N9l
cNu6tviX29PziUhmYNdjr6nhhSsHB4qC7+l6YwQmR3DzEPeVTiW8b1lWsmWL1YQq
fhLlNWrqQSBTs01/EUEmvCHnHZZTZUhJRpIozH8eGjvhvg9YeY1nRj0ggxClpGHh
Dzc0HtU/KTKfLk8zhuQLhLrKBKGvzg==
=gap3
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
