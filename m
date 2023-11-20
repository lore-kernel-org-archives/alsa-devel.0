Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C2EC197A0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 09:17:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A9DFBC0;
	Mon, 20 Nov 2023 10:16:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A9DFBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700471835;
	bh=NvotHLfVBduGKQUCC9ZYr1A959aByqhymkfjEWG51Vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qGVwgMlFzVkKYEW8tw1hV0Lu8DC6LgtKkz3WOawvr9kFoyiV4sXCO8GHMWb4BqpBn
	 gVDjqJcYultPF4rhWmSY5GehabAAXEmUjdvl1N/lOzz39Q/IVt+RkToJEwOHf9+hpX
	 xlIDjleNy0XK4vaqc6xXmh0/H35+Wo1NG0RZZL+w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 570ECF80558; Mon, 20 Nov 2023 10:16:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D96DEF80254;
	Mon, 20 Nov 2023 10:16:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C47FCF80254; Mon, 20 Nov 2023 10:16:10 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BEBAF80114
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 10:16:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BEBAF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=IqbPVQBx
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso640915276.3
        for <alsa-devel@alsa-project.org>;
 Mon, 20 Nov 2023 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700471764; x=1701076564;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpwOvzzEhozZ00SFHXEpmejOMEaeMFuJw7NXLVeDvN0=;
        b=IqbPVQBxENrviNzX2U0R+QAh/2Br62KejfKU/TvoGjnznE5/fEakM/tdI9B3W2zrqz
         yLaWzixPv67uZZEONmhcZZEkmcdSiuFjbr0C1UZa9weWZkpF4RSSP3gzlvPp8UZvW4H3
         pf+d3oDkdc1++y59tmoMintye/L3XRKoSuspP7xugK+CBin6+mZWmXraQWtC/qa0GXlV
         3rtSVxubT9EL2to+HfpfqDtcPB8HaKJrMnN84SzGGyxrM3G8WOK/QA9ZuyKB5Lpqjak2
         h/2iOJul/RSuWea83vSOdm+U3CgZxqxOiH9gRLmLcO8OAwsSEm3ly/rtNr5qQDQD36CC
         G5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471764; x=1701076564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpwOvzzEhozZ00SFHXEpmejOMEaeMFuJw7NXLVeDvN0=;
        b=cTLiwHXFnwKHLsxpBaj/EBFZgB4G0B70rTtkMFA2Sys+WnPte9rWDMK7ftlh10LvWf
         6lXmLlPFx3L8cJpQy8e2USrFa14VEvS3YsG9g2mTWTZ5IfAdZVEYM5voWc6f5lJAvVI3
         Tm3d26KnnPfCBzQBMB2jFeS9+PDgiHhwzdBA8PSv84sg4sVdTOOASupdUxq/S6bVoUPT
         CWklD2c4Sot2cPVVer8/w8B6/6OuqvlTGLKaDCyc4eI3brVrN49n+D6fe4bFmTUWloyD
         miacr7HpajX/Ptb4+++ESqjoLxVXA0SwJ30zHHWyRT4Zf71o8o7yDJJHrPcwt9wnXhHv
         OUKg==
X-Gm-Message-State: AOJu0YwCoKHkAP3eZJ5oRVDCwsV+3VE9TDPUKwDFY/OFAw10FIEO2sYJ
	YS5sruW9A0eLf0JBDisiFJgTyjLkpM/Ehnd8JN0=
X-Google-Smtp-Source: 
 AGHT+IHQZdFmExncdM9w92IhRdz9hY7vAbs09uTd8RTDMHe6yfQhLY+Jt6pDbPzwWpTI/d6kO1raiNKHVl+oY27Gx6U=
X-Received: by 2002:a05:6902:4e6:b0:da3:b87b:5b7c with SMTP id
 w6-20020a05690204e600b00da3b87b5b7cmr5863456ybs.38.1700471764148; Mon, 20 Nov
 2023 01:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20231119104514.25536-1-tanure@linux.com>
In-Reply-To: <20231119104514.25536-1-tanure@linux.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 20 Nov 2023 17:15:52 +0800
Message-ID: 
 <CAA+D8ANMZd1xT2nyNskaroz-X0pDTv2fCSPxKc+H4R2RS3FRCw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Remove duplicate linux/of.h header
To: Lucas Tanure <tanure@linux.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: S2Q36KH4BPR5MZE2P6RDRHWKZVI553RM
X-Message-ID-Hash: S2Q36KH4BPR5MZE2P6RDRHWKZVI553RM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2Q36KH4BPR5MZE2P6RDRHWKZVI553RM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Nov 19, 2023 at 6:45=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> Remove linux/of.h as is included more than once.
> Reported by make includecheck.
>
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
Wang shengjiu
> ---
>  sound/soc/fsl/fsl_mqs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index f2d74ec05cdf..86704ba5f6f0 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -10,7 +10,6 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> -#include <linux/of.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/pm.h>
> --
> 2.42.1
>
