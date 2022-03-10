Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F400C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 04:04:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07ADA16CF;
	Thu, 10 Mar 2022 05:03:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07ADA16CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646885049;
	bh=GrKdFSYsZlVt8uhCN2U6sNHmV3u4KOt5mcwLajvsZOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xe3qx9QaO0FFqU/Ez3ZJWf2GVf+FeIAW/AwJh7Ddw1yhZPtdy7ed2oq2Txk4sFIxn
	 TeqYIF7qF36mCm4Z59j+zyL+HBAFOZn2iTg6rdKCUra9Lp/hz8zsqlTmGaTc0/OnE2
	 kizUtUjlTIB3dArS9yMJ+8oS9U2cnPdGM7Ev8IYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65AB6F8012F;
	Thu, 10 Mar 2022 05:03:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D5E2F80137; Thu, 10 Mar 2022 05:03:15 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D107BF8012C
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 05:03:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D107BF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ONrKwNau"
Received: by mail-ed1-x52e.google.com with SMTP id b15so1289956edn.4
 for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2022 20:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GrKdFSYsZlVt8uhCN2U6sNHmV3u4KOt5mcwLajvsZOw=;
 b=ONrKwNauEyspuXAuyaYf+2s7frYnXQgKz3I3C/XTvDB8gnwd6/YlZl1iyEk5kZ2T9s
 CflKU1uQ3xl/8qFQRFY21+vq6dhEYhcFsbFQSMmoStDu0ZoDIcmz4pWksO1uCcP5vX2b
 UlrJuWB0okTvlUvCk92Sb8C9A4PlLlPLdBTVRDRdynYexSvalJOaM+uiDgfbbfn9mGph
 UkcupGs9lFCOqR+O5d7tp2IeOcyUUwZRS4C98tiYq3YE9X4Lgervcc4mnfH+/FM/xFnU
 IxfufytJXbxJI+AxXNgaE37NoMNafJs1zKfW9mF15vroPEb2zGDpC8giAcxDjTKstxsn
 HEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GrKdFSYsZlVt8uhCN2U6sNHmV3u4KOt5mcwLajvsZOw=;
 b=gaPOIi35UvdhYP9xksXilv2QNXwrOUkSVtvxWjyFboZ6fl3PPVoGX7CgNF8Zp3ChzK
 Rbvjc4JhwDfWuSM169O1a0nHJ6GHAMfyaRlGg9M563OORev6AcUGgG+7+JIPZrwo9GHH
 ibyyUQpSDyiWxf6Py+fIfjsZ+hj7d0CQWrvtaQeeJxD5HGsdVgz2QiHddUvfVvUIbi1i
 lnmlp/dSEuokCNrHnAzWe0mW/thTQlK7ZAnthjHnnMfZAJuA9pYzhKOEmy3W6QeX9Ptu
 1QGh2lqgMliBPODq3YP3+x8N4gV10sEkStGE6CgrWssJp9og8/cmU8wqvwhdPkzeL7Qf
 9Itg==
X-Gm-Message-State: AOAM532TrGaeMONwvuRel3RmfMfEXNKurHAMWswJ/I0noqEnJoiTt2fa
 YEtn/84zc5XZvUwvVy7r404mypT61eue5Ts66R4=
X-Google-Smtp-Source: ABdhPJwkgjgmWZTe/uzCw13LmTJ+AMMbnaHvJVc7YxhfBh+pWiN0kj2TdHmcSbojsH78j+QzOvhAaEGenMZA45d4jKA=
X-Received: by 2002:a50:9d0f:0:b0:416:95a3:1611 with SMTP id
 v15-20020a509d0f000000b0041695a31611mr2430187ede.77.1646884986448; Wed, 09
 Mar 2022 20:03:06 -0800 (PST)
MIME-Version: 1.0
References: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Mar 2022 01:02:54 -0300
Message-ID: <CAOMZO5DCm8TzajeLCECxpdsoKBMOzr2MgmoYbUSN7SDYRhPL4A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Disable TX clock when stop
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 11:46 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The TX clock source may be changed in next case, need to
> disable it when stop, otherwise the TX may not work after
> changing the clock source, error log is:
>
> aplay: pcm_write:2058: write error: Input/output error
>
> Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
