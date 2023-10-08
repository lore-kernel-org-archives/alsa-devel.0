Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABC4E95A67
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Oct 2023 09:45:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 021D4208;
	Sun,  8 Oct 2023 11:44:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 021D4208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696758319;
	bh=jjEmiAf0OV0VrKT//Gxr0LHVNIDFDe4FiHcIAfdqTU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Obg5gQlRl/herpnqT5nl05BhvEtuRMXdiJst2hrb0ZVkW6g/pjOJv/H1KlF3PkaDH
	 8vkl0tPOu+zoTHksQ43BCprC+vM5PByx39k3PCxChTZ7U/YSOeF04Sy8ej4d7kfFIz
	 ctrjgpC/n2XlxL72fLHA61+z3vQlI3oqst2IIKwM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A2BAF80552; Sun,  8 Oct 2023 11:43:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A1BCF802BE;
	Sun,  8 Oct 2023 11:43:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C995DF802BE; Sun,  8 Oct 2023 11:41:06 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A3558F8027B
	for <alsa-devel@alsa-project.org>; Sun,  8 Oct 2023 11:38:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3558F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=WGD04R4G
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3512efed950so15145335ab.2
        for <alsa-devel@alsa-project.org>;
 Sun, 08 Oct 2023 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696757886; x=1697362686;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fYiXpHzdursWStkJtczyobJvyoVD92PbbCoVYotrfY=;
        b=WGD04R4GiBXrHyqzKijcmsD3NPssivak/8WBvS6xLiYHrmVcVQfZDv+agV9SA0ABkW
         Z2k657q+JQ7xKw61VMQPQuuxHRJKlojWQTVL2SBfVSMplS9SHphrQ987I0LAXM/DbPAu
         n0N+MtG1fZGHLLguajOrnkzWrgjenPO0ExwJXnK/X/+XZ1p8WwM0AxkVufrPm9mNYT4r
         Blk7TyfYu+VOd4jol0/NlIq/UDkG3OwNHDZ0vMdxl1s/v1qfBW2z4ITLGH3Ept05DfJ7
         2bvesmTADkxAZknEcDpYuANSIjWpLD64fgImO5eUWAOf+rq+80HpbVLa53IyIB7zOurW
         q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696757886; x=1697362686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fYiXpHzdursWStkJtczyobJvyoVD92PbbCoVYotrfY=;
        b=iI+e4CGnUj6ay8NTFvAlQm0f3HTTNj4pdotvSE1NtD/LcHc4X4iK+SKq3zNYJbELZx
         Bhs5ph9MUAyk4S4sOf7/xFfayYTSePmLNKYKQaRPN5akEfM4cIm/OLWPYJ0An266EYqf
         vr/SdvTYq/NYXeMNHpdLKpcbcFskh2ogADkUzFMXUJm+FeY/xGHwoYSFaTfzbWCn6FkR
         f12ukN1Vl3yr123eEOBSD706T6TDa9Yq1IGkeddtIxBuGMOiyFt35GLcXSlqI5HBkRGS
         vL/EEpNKMleKzbbptsYgpiUJnbFKQ7ErMTZqnZ4fqq+NGSKALCwOscxx1UDw2+he5fsJ
         Kkrg==
X-Gm-Message-State: AOJu0YzpAwgk16Ci8AUi3wajLxIfJNXKsTtozlaYSGtmroeRjjVq9Ans
	kCg5cK96Iz6y8YO7qDPhcTrA4iNkdDb/UuSx+Nk=
X-Google-Smtp-Source: 
 AGHT+IFOPXqa1g6fZGD/2vL4Ek92lAQIZ3j/sZIBurFiKkx5uCP6NxLrJQ6ZaN6RV8gr8K1oXMJbJlZME8c7U+Lw4uA=
X-Received: by 2002:a05:6e02:184f:b0:349:3020:d103 with SMTP id
 b15-20020a056e02184f00b003493020d103mr15718726ilv.25.1696757886364; Sun, 08
 Oct 2023 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_681B0528D436898B1B945A8B2D46300C0F07@qq.com>
In-Reply-To: <tencent_681B0528D436898B1B945A8B2D46300C0F07@qq.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 8 Oct 2023 17:37:54 +0800
Message-ID: 
 <CAA+D8ANxyQbZDp0DuaxzvucHWvuU9N-ckWQYAEa89LAD7-whUA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix PM disable depth imbalance in
 fsl_easrc_probe
To: Zhang Shurong <zhang_shurong@foxmail.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: H5LUSABZEYPNQZUMGZEPBJ7QJ6HTTBTV
X-Message-ID-Hash: H5LUSABZEYPNQZUMGZEPBJ7QJ6HTTBTV
X-MailFrom: shengjiu.wang@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H5LUSABZEYPNQZUMGZEPBJ7QJ6HTTBTV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Oct 4, 2023 at 3:12=E2=80=AFPM Zhang Shurong <zhang_shurong@foxmail=
.com> wrote:
>
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context. We fix it by calling
> pm_runtime_disable when error returns.
>

Please add a Fixes tag.
Thanks.

Best regards
Wang Shengjiu

> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  sound/soc/fsl/fsl_easrc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index ba62995c909a..ec53bda46a46 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1966,17 +1966,21 @@ static int fsl_easrc_probe(struct platform_device=
 *pdev)
>                                               &fsl_easrc_dai, 1);
>         if (ret) {
>                 dev_err(dev, "failed to register ASoC DAI\n");
> -               return ret;
> +               goto err_pm_disable;
>         }
>
>         ret =3D devm_snd_soc_register_component(dev, &fsl_asrc_component,
>                                               NULL, 0);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to register ASoC platform\n")=
;
> -               return ret;
> +               goto err_pm_disable;
>         }
>
>         return 0;
> +
> +err_pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       return ret;
>  }
>
>  static void fsl_easrc_remove(struct platform_device *pdev)
> --
> 2.30.2
>
