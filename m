Return-Path: <SRS0=N3b0=HJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA038C433DB
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 10:41:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8AC64E44
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 10:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8AC64E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67DF21683;
	Sun,  7 Feb 2021 11:40:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67DF21683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612694458;
	bh=20hj3qydBhZUgiiokp0bf0KvDFtGozei2M8GKll6ORs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XHFfq/fgarJ3jxRmmwbcHB6xIqti09jftdAsHm66Tit6tyVumdHboWSWiH1cjSCBC
	 GBXf2YjMH8LXZLs+rrl8mjDyOJUfyzuYv120KxV4kcxU11XcsheXAI+GCN05/8x2Y7
	 cW5O9EkydLFc+DD0nYvWy6sjlWKEYT2mlj+NEJZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC072F801D5;
	Sun,  7 Feb 2021 11:40:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69CE7F80259; Sun,  7 Feb 2021 11:40:05 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07036F8013A
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2021 11:40:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07036F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LBCLzdU8"
Received: by mail-qt1-x834.google.com with SMTP id l23so8361422qtq.13
 for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2021 02:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=20hj3qydBhZUgiiokp0bf0KvDFtGozei2M8GKll6ORs=;
 b=LBCLzdU81y9o5/qZV7zQywvN4c9g6glsF4wPCS98T1Uq96mQgXc9nVzxqpTCtn7vre
 NZV3Z/YpFRF+rSP9Usy09HyA4mvfM24P6xflvDoLpY0g+YnFcMxW2U2JE3bsEgMb+RcF
 OkN4o2Bj743CP9gPU6huSBJo7Q247Uo7yu1ymJUUwmtAvwNO4eH5Tcs43X++Kpl9QJQN
 HCQIbIAyi2pc+/w0ugk9RrkRODiiaPdGtJyAeBourSniDSAbTwfbvrqM1dmQEbIlgC+i
 sZY/Q9IPlNx8qipobDUvnPb9aAA9ZisPZjsdlXFQTpCYd99AW5x7arFphahJlLPVM2K4
 Uucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=20hj3qydBhZUgiiokp0bf0KvDFtGozei2M8GKll6ORs=;
 b=oWuW2SBzFEkcuEeat3vypU2l+S5T2NPUh74UTVIQSHcwmQ4G1MaYNGrWJLIKwEi6kF
 VnMLi53sGSkBVOa46baGrhPROaOHPwDDH9Hqmpm1hV/pACuUv5AUS43LuOXNvrm/rUqI
 76cs0oEaEtlAQ+UwztzP4TUkxhSjrK/xJEntektYOO0n48//AzrdXt4i4zPluJYx2+c7
 I8XEPf7xaVedPATchkAXcExR6EOxw8RO3mKL26+ptHQa1lyhkWe79DTqOShu7DcOvpNm
 NQwZBMNMGpQ9hm2Mdb4o6R96fweromGWTeAOIGJ/afBn/hkkAggyFvsiDdkxvRQ91kLu
 0yWA==
X-Gm-Message-State: AOAM532bPG+3U5hc+LFu0yr7TuNIxt5g0fX8oEiikj7UMuVIFF+DCB5l
 9nqYLfg3RtH06gnVwppCPKLEv2bs7yYBOTG5lEU=
X-Google-Smtp-Source: ABdhPJwoEbEUOlnM0FGPKfUHzaKbSg0XE+7DswKNyxc5DKJBUqzSttdcofbQNesZzy5K26sXGZt9Qfl/646TK2nCisw=
X-Received: by 2002:ac8:1408:: with SMTP id k8mr11226310qtj.204.1612694397862; 
 Sun, 07 Feb 2021 02:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20210206142753.536459-1-festevam@gmail.com>
In-Reply-To: <20210206142753.536459-1-festevam@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 7 Feb 2021 18:39:47 +0800
Message-ID: <CAA+D8AMgN_53yu1MDgY3NPQaQ5fsFN4ituJZ2Ah-e_AiaR3f9w@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Remove unused 'imx' field
To: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
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

On Sat, Feb 6, 2021 at 10:28 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> The 'imx' field is not used anywhere, so get rid of it.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
