Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9716C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:58:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629D520803
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C+cDMby7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjK94ZRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629D520803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E02D1614;
	Wed,  4 Dec 2019 13:57:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E02D1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575464284;
	bh=GCWtwP+F+slJCnbcDQ2hu8Cmc8nkHGaRhJcScqwigMc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+cDMby7xBpUFWJTD1mbTswCcxjdy/3eWIjmaEcVgym0EOfFd8JaEUsuQMHd3Ut2U
	 geE+CwdliqkEhsGOtscOND2vdcI01WIwoB+t/lt14HPQf7Z3J1PzzP8EkfnUJ/yIoU
	 Jj9N50Q5MS2V7LgM4OBgDmFvVIge3us+Rsbjdv7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C16FAF801D9;
	Wed,  4 Dec 2019 13:57:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A39FF801EC; Wed,  4 Dec 2019 13:57:12 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97D7CF800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 13:57:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97D7CF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CjK94ZRk"
Received: by mail-wr1-x442.google.com with SMTP id a15so8458742wrf.9
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2019 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WX9DsnxjR1TLkIQAS0BjsZD23PSgQu93DSuzJlaRss8=;
 b=CjK94ZRk2M/LKqEEX5rm/3WkZf/HiI3Q+vVXDbZOZxQNFGaqW6DwTHkkkx84vRfS+M
 U4ORtkjPBA9iSMbi9wpu7YmMFTp+pNz3ylxcjalwvJv2KZQBId8X2noNPl++SsRNODK7
 QHPvskaMNV5R762Lpb7nY4iTA+SdVhlMhJxfRgfvM6jxwD1ZNI97gcI1rUhzyzNaVE+Q
 k0Bc2/yGbWtp6U/eTSBRlksg5lobZN4iEcrEFCI2rqfgwYhIgxNwI1rIPCeNNltPaVVM
 rHvfdkl+vcc+QKkCwM59zcflNAcevYc8jww4nTJSaG3Zq6ZEE7D6XZBEvNXC3R/zck1W
 +j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WX9DsnxjR1TLkIQAS0BjsZD23PSgQu93DSuzJlaRss8=;
 b=Pf9p06jSPQC6KoDlFlznWEE8egS0iDaV8T8xDwi/WiQ/ka0bsGBZYOuUP3vf3YeWOq
 nZg0JDwoqsqhrn7ZzbU3d2Cfc2eSXam8OtkRkYPEKZZuqgVWDHUZMWwJg5luF8U+ojrd
 KaQPB6kzE7dHkITq3mvQocAsV8Z6d/37BLkQd3kRvkHiu4rJvH29OXc3stJ2ZXGzsD2Z
 IXGEvFiI5fDn2PQvrRr/t9ryUkw+hfYQ6ZkmUlKNlo6bEFmm+01f6VodUpUEb9vqqxkJ
 gmSR7DUzS2lCpxbVRMbws4BmCbNC0ThjbREiMwLb5+S+MalAuzIzlZ9zjyPKT0XYiltv
 MfFw==
X-Gm-Message-State: APjAAAWPdqWt9GxjBJF6s+Bzck0biwKw6c2J2qjkiyp7n+1SvLoSLGBj
 5rBI1BkyQS1uiKE3XvOZl/F+PXS/a8IVRm/nOa8=
X-Google-Smtp-Source: APXvYqzndsNueQS92Xe4B1d71REsjlvqx9ynvD8CvVkru+ORVDr1gVmjag6dLc6gMBN+1fpeYUjla8YjTCCO/YsvQMA=
X-Received: by 2002:adf:dd52:: with SMTP id u18mr3950790wrm.131.1575464228649; 
 Wed, 04 Dec 2019 04:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20191204124816.1415359-1-colin.king@canonical.com>
In-Reply-To: <20191204124816.1415359-1-colin.king@canonical.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 4 Dec 2019 14:56:57 +0200
Message-ID: <CAEnQRZAEExdNS+=aSFb86OCgWfezEFHYvoAJBV4=DshEprRGrA@mail.gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx8: fix memory allocation
	failure check on priv->pd_dev
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Dec 4, 2019 at 2:49 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The memory allocation failure check for priv->pd_dev is incorrectly
> pointer checking priv instead of priv->pd_dev. Fix this.
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Good catch! Thanks Colin!

> ---
>  sound/soc/sof/imx/imx8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index cfefcfd92798..9d926b1df0d7 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -209,7 +209,7 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>
>         priv->pd_dev = devm_kmalloc_array(&pdev->dev, priv->num_domains,
>                                           sizeof(*priv->pd_dev), GFP_KERNEL);
> -       if (!priv)
> +       if (!priv->pd_dev)
>                 return -ENOMEM;
>
>         priv->link = devm_kmalloc_array(&pdev->dev, priv->num_domains,
> --
> 2.24.0
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
