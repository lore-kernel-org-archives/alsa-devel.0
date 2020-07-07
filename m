Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A2C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 01:52:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1A206F6
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 01:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kilFvsQD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOfLIPJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C1A206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5196915E2;
	Tue,  7 Jul 2020 03:51:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5196915E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594086765;
	bh=CoEo0HK06HV6q5IkdPMMkbmW0osiCboSkyQ2ivTKVAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kilFvsQDswe+8dzzkCFoP8J5Bw7MaM+1lansm5NLfXMtM1W5/6kiaaMnh18P9dmei
	 DfbqRrQ/XIUEK3Uk+WNn1kWxFImdkfjo1Me+yCXiGeSUhZ7e+dR8X3ZQ0q8oOb491V
	 yTnuu7E76d+jcs+H37JAT0y5G/QIA2sruMmq+KKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8FC2F801F9;
	Tue,  7 Jul 2020 03:51:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F8C4F80216; Tue,  7 Jul 2020 03:51:52 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A598AF800DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 03:51:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A598AF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JOfLIPJL"
Received: by mail-qk1-x741.google.com with SMTP id k18so36792769qke.4
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2020 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qx/C0isL60DPbKTPxrph0kJVnu1AM2M66vCo2gvDUxo=;
 b=JOfLIPJL+2nxndCtc9jPaSJdkd+AmzkyaD1JzoVZhJb34tgPdJuaPVJbdhGbbmlot1
 nP0PCUA2MnDCVjOTzLofNt5MbSHBNXQxCZtyBJJABBz2HfoEZbvQdmxYmb7leoUTt+DX
 hLzm1z/RZbt8s91F2R4d+0vl+3C0GK31Catd+BJ3duwE76ybY8oTZisVGdhKSxuv+eQJ
 HnaAvpjQGIkO0c1lLMZNsMXGcVW/f8n8D9tDW/DKceRkvWp9rTl9lqt0AOwOMH3hp17c
 g+nXeOpHlQsh/gG9W0Nkmgnc6EpRs9y15S8Up7ybEJLf3nOF7TMorGn6XpoLBKi0AF8+
 vY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qx/C0isL60DPbKTPxrph0kJVnu1AM2M66vCo2gvDUxo=;
 b=OXeZV8PlqGaHeA6cduGq1j7Q3yzEh6cUx39ef8WKFNF1V0VEb7EMwqHXSannVylGlR
 RQymHHY1RnuVZYiAxw649DNPQM2w8FT4CYX6gsnpCpyIDzWPMkRLGYz5afDQHVsn6wed
 W0o+eEpD71T5d351vqYx9SOWMzQzkXUqXVwPheHu5cO5KBlDjhp6BPBL3U9hOQndVJID
 v4WfzIJOSgsmXZE1195kQW88FpDkOk2j99KUWow5Drqr2nLnZJtoAoB+j6aBDnS9BQ9e
 cAqZKFG44emqv3qzJQT9UjKHjgWzl5lF11Qy95CAvAeCSsaarGyJwzKXO7fc/BDqgGpI
 9cNQ==
X-Gm-Message-State: AOAM532NoYKgKyxeAz1iFX8R++WC9l9c6vQ50m3hHN6zfAhIlTPeFctC
 CvaS7KCiliEWRGs/K2/mBYtmOYFNsDFsP1JrqlM=
X-Google-Smtp-Source: ABdhPJxbdu1UR0UwC4VJ18/+W8RImTA2mJWd60dbnKAprt4YwcWVw4xJ/jqDfQmncoedyIwf0fGD5hIXQ2ivhdVou/E=
X-Received: by 2002:a37:bcb:: with SMTP id 194mr51351661qkl.103.1594086702672; 
 Mon, 06 Jul 2020 18:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702193102.25282-1-nicoleotsuka@gmail.com>
In-Reply-To: <20200702193102.25282-1-nicoleotsuka@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 Jul 2020 09:51:31 +0800
Message-ID: <CAA+D8AMMKKDyPXXN0790LswNh_sOfUUDVw5PiMoLB-U4qX8G9w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to reviewer list of
 sound/soc/fsl
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Li.Xiubo@freescale.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 timur@tabi.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
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

On Fri, Jul 3, 2020 at 3:33 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> To Shengjiu, please ack if you feel okay with this (your email address too).

Thanks Nicolin for nominating me as a reviewer.

I'd like to use my gmail address "shengjiu.wang@gmail.com".
with this then

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
wang shengjiu

>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 496fd4eafb68..54aab083bb88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6956,6 +6956,7 @@ M:        Timur Tabi <timur@kernel.org>
>  M:     Nicolin Chen <nicoleotsuka@gmail.com>
>  M:     Xiubo Li <Xiubo.Lee@gmail.com>
>  R:     Fabio Estevam <festevam@gmail.com>
> +R:     Shengjiu Wang <shengjiu.wang@nxp.com>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
>  L:     linuxppc-dev@lists.ozlabs.org
>  S:     Maintained
> --
> 2.17.1
>
