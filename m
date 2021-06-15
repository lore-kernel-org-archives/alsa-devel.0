Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ACDC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 13:19:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878236145D
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 13:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878236145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FE5286E;
	Tue, 15 Jun 2021 15:18:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FE5286E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623763171;
	bh=/GB/FSkgMwQHniWR+6mJujhqtDWVZbA2REQv9FEeEGE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghJQv3JQu4A3c+TMfnl9zuklEe7WirKvOZAlumzmTWr5C56BMRPJ3mtxtU1VToeDJ
	 TnrQwvGmgCGtaxso4hk74kKlpqjxoR77Usv/lXKNJ4lDob+Onu3O0YKhKwZXmbw6ip
	 62TFMXERM28U9S3LD1m7p3dPAEKbaoaMP+N+2LXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BECC0F8016D;
	Tue, 15 Jun 2021 15:18:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5030F80171; Tue, 15 Jun 2021 15:18:38 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B479AF80113
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 15:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B479AF80113
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1lt8xD-0007qa-D2; Tue, 15 Jun 2021 15:18:07 +0200
Received: from pza by lupine with local (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1lt8xB-0000Sh-75; Tue, 15 Jun 2021 15:18:05 +0200
Message-ID: <2e369015776577c6c32ec2f7d05e35f796edf713.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org,  perex@perex.cz, tiwai@suse.com, mripard@kernel.org,
 wens@csie.org,  jernej.skrabec@gmail.com, samuel@sholland.org,
 krzk@kernel.org
Date: Tue, 15 Jun 2021 15:18:05 +0200
In-Reply-To: <20210615130326.2044-1-fengzheng923@gmail.com>
References: <20210615130326.2044-1-fengzheng923@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
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

Hi Ban,

On Tue, 2021-06-15 at 21:03 +0800, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
[...]
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.=
c
> new file mode 100644
> index 000000000000..78d512d93974
> --- /dev/null
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -0,0 +1,408 @@
[...]
> +	host->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NUL=
L);
> +	if (IS_ERR(host->rst) && PTR_ERR(host->rst) =3D=3D -EPROBE_DEFER) {
> +		ret =3D -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
> +		return ret;
> +	}

Please don't ignore errors. For example:

	if (IS_ERR(host->rst))
		return dev_err_probe(&pdev->dev, PTR_ERR(host->rst),
				     "Failed to  get reset\n");

devm_reset_control_get_optional_exclusive() will return NULL if no reset
is specified in the device tree.

> +	if (!IS_ERR(host->rst))
> +		reset_control_deassert(host->rst);

Then this is not necessary. Just use:

	reset_control_deassert(host->rst);

regards
Philipp
