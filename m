Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA22C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:33:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02F02076C
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KILWALxT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2kFpEQIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02F02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 352E616AF;
	Wed, 22 Apr 2020 11:32:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 352E616AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587547992;
	bh=lIl6HImVJ6Dh/zIbLnzk79LumoD5Vgqca2ZsZri1L9M=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KILWALxT32bTVkqjEhAmDJslqVQ+DnB8FOcNvxljqSZnIX9KOu4tGr8P6MVEr/4sG
	 qcUxWZp0GRKuCdv9CWla/5n+iPlLJxwK2fXqurV4GraZG1Yv5167N10nxufbx3Q1oU
	 zQpKS7k/Jgto60fBeJOVFI3trRhMw5HXv2tlaUjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D335F80142;
	Wed, 22 Apr 2020 11:32:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33F21F801D9; Wed, 22 Apr 2020 11:32:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA8E3F80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA8E3F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2kFpEQIZ"
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D5752075A;
 Wed, 22 Apr 2020 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587547936;
 bh=lIl6HImVJ6Dh/zIbLnzk79LumoD5Vgqca2ZsZri1L9M=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=2kFpEQIZIJ4lZcUA7T08f6TV99oT5xXQrAyVh3KqbohiFsYKkNCACfJshaKBda9So
 +KF0TH5tFfnbWpkpLSNVOi293lHsXSjKFMQpENVaZmDlvdcYnH4bquNMpfJ3m2rtlE
 K8cQcvWAtne6L9kmuXBUpKWpRUHvUgUvOLvn+P3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409195841.18901-13-pierre-louis.bossart@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-13-pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 12/16] clk: hifiberry-dacpro: add ACPI support
From: Stephen Boyd <sboyd@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Date: Wed, 22 Apr 2020 02:32:15 -0700
Message-ID: <158754793532.132238.9824423478783177623@swboyd.mtv.corp.google.com>
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

Quoting Pierre-Louis Bossart (2020-04-09 12:58:37)
> On ACPI platforms the of_ functions are irrelevant, conditionally
> compile them out and add devm_clk_hw_register_clkdev() call instead.
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/clk/clk-hifiberry-dacpro.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/clk/clk-hifiberry-dacpro.c b/drivers/clk/clk-hifiber=
ry-dacpro.c
> index bf0616c959da..d01a90fed51b 100644
> --- a/drivers/clk/clk-hifiberry-dacpro.c
> +++ b/drivers/clk/clk-hifiberry-dacpro.c
> @@ -114,15 +114,22 @@ static int clk_hifiberry_dacpro_probe(struct platfo=
rm_device *pdev)
>                 return ret;
>         }
> =20
> +#ifndef CONFIG_ACPI

Use if (!IS_ENABLED(CONFIG_ACPI)) instead?

>         ret =3D of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
>                                      &proclk->hw);
> +#else
> +       ret =3D devm_clk_hw_register_clkdev(dev, &proclk->hw,
> +                                         init.name, NULL);
> +#endif
> =20
>         return ret;
>  }
> =20
>  static int clk_hifiberry_dacpro_remove(struct platform_device *pdev)
>  {
> +#ifndef CONFIG_ACPI
>         of_clk_del_provider(pdev->dev.of_node);
> +#endif
