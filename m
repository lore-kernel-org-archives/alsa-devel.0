Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE0C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:36:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED9D2076B
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XGAJICBq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoecbU53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED9D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23A8816A8;
	Wed, 22 Apr 2020 11:35:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23A8816A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587548169;
	bh=5DNBkHR6a+WVtLqdbWXqDmcSPGo1U6AntaC8sObehFs=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGAJICBqIYMkExl0JX52zJ4P8h4sKbNpzHFJQ1WdqVyBFlqkpVLiR2ieD3sn0EvmD
	 kw4pAx4a0VCHcmiwCU5oxeDNSjI1XHMzS7RpwzQYnh3GSOrY0YWaW8KZtwiUjXY2QR
	 S/uGET7MWnG37yyGrIHV0qFlf5Fp7QNsI4Q3m9EM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9753DF80142;
	Wed, 22 Apr 2020 11:35:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62952F801D9; Wed, 22 Apr 2020 11:35:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B41CFF80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:35:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B41CFF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IoecbU53"
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1FBB52076B;
 Wed, 22 Apr 2020 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587548108;
 bh=5DNBkHR6a+WVtLqdbWXqDmcSPGo1U6AntaC8sObehFs=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=IoecbU53MGHU4OIbquC13L8j+2LL3jXiSkDNYkI3LvP3Y10smFBzY5WmEkRy7npAz
 RNOFynyvWuaqMOctvCNmFdqSjX837qKSiX1XDaX2YCQrP3UEiRHY+tipBTJVFawHUP
 ARfRcyfM6HeUv6bogHBFQq6LYoG0he3xbL6z8MbU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409195841.18901-14-pierre-louis.bossart@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-14-pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 13/16] clk: hifiberry-dacpro: add "sclk" lookup
From: Stephen Boyd <sboyd@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Date: Wed, 22 Apr 2020 02:35:07 -0700
Message-ID: <158754810745.132238.7647643247125302962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Daniel Matuschek <daniel@hifiberry.com>, Hui Wang <hui.wang@canonical.com>,
 Matthias Reichl <hias@horus.com>, broonie@kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
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

Quoting Pierre-Louis Bossart (2020-04-09 12:58:38)
> devm_clk_get() fails on ACPI platforms when a NULL string is used.
> Create a "sclk" lookup to make sure codec and machine drivers can get
> the clock.
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/clk/clk-hifiberry-dacpro.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/clk/clk-hifiberry-dacpro.c b/drivers/clk/clk-hifiber=
ry-dacpro.c
> index d01a90fed51b..36210f52c624 100644
> --- a/drivers/clk/clk-hifiberry-dacpro.c
> +++ b/drivers/clk/clk-hifiberry-dacpro.c
> @@ -24,10 +24,12 @@
>   * struct clk_hifiberry_hw - Common struct to the HiFiBerry DAC Pro
>   * @hw: clk_hw for the common clk framework
>   * @mode: 0 =3D> CLK44EN, 1 =3D> CLK48EN
> + * @sclk_lookup: handle for "sclk"
>   */
>  struct clk_hifiberry_hw {
>         struct clk_hw hw;
>         u8 mode;
> +       struct clk_lookup *sclk_lookup;
>  };
> =20
>  #define to_hifiberry_clk(_hw) container_of(_hw, struct clk_hifiberry_hw,=
 hw)
> @@ -121,15 +123,34 @@ static int clk_hifiberry_dacpro_probe(struct platfo=
rm_device *pdev)
>         ret =3D devm_clk_hw_register_clkdev(dev, &proclk->hw,
>                                           init.name, NULL);
>  #endif
> +       if (ret) {
> +               dev_err(dev, "Fail to add clock driver\n");
> +               return ret;
> +       }
> +
> +       proclk->sclk_lookup =3D clkdev_hw_create(&proclk->hw, "sclk", NUL=
L);
> +       if (!proclk->sclk_lookup) {
> +#ifndef CONFIG_ACPI

Is it to save code space? Otherwise the ifdefs are pretty ugly and I'd
prefer we just call of_clk APIs and rely on the inline stubs when
CONFIG_OF isn't enabled to be optimized out.

> +               of_clk_del_provider(dev->of_node);
> +#endif
> +               return -ENOMEM;
> +       }
> +
