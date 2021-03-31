Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B41C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 17:50:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DCE61059
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 17:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DCE61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 680061657;
	Wed, 31 Mar 2021 19:49:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 680061657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617213026;
	bh=/lUp2eV93TnkAkLISZMsTBeCC0/nrVGaqYQOEl3xGKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LvOYH1ot1kOgY70skCv/tXzxqouJWmvWXvE4zFV/0WKSnj4eZ3uXnPFM6A0ECA4PU
	 07dbTWPOKo6HivHc5iL6amNXJoZFGsz2lJ+oKk7M4IiTF+TL4du6RlVVn/IFqYs1Px
	 3MNoSilnubK35OTuOBF7QGNkCaUR9z+6VudsVbkA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7DFEF8015A;
	Wed, 31 Mar 2021 19:49:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB090F80166; Wed, 31 Mar 2021 19:49:33 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D93BF8013F
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 19:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D93BF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Lm2Vep24"
Received: by mail-ej1-x635.google.com with SMTP id kt15so31304664ejb.12
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uXLbaIrl2zDsEafC82IMdUg2Vdbjwwvm+kRTZ6woEAo=;
 b=Lm2Vep24XTDfYyfvicgBOQM8VSxdD6KXgHsUFoIQBMbiML3HP1W2JS4pD+sFRknIFE
 EkYYMekQCnlPfilY/p9RmEfvZ7ZKquJOnhEjF+67ucFekoV8Z2OfVvtdNsSojhYvQiTQ
 swtnEm9gxVJ3BNVS+OxuK1qo/0FMf8mz+X7R8PzSf8zS4NnoBzIdwBLQWebcl11ttWCk
 tDKxZgaFYULcuU9k9aI9ACIFLqZdfrSPnA0tq3UbQmmAbq050jquao27QRqOFkEFXLkt
 wJzYUGVGzn0fEyBFeM1KSUz83mg4OkycNdfpjAtyrfFP0Fc6D6CMHPSw9nys58loubet
 rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uXLbaIrl2zDsEafC82IMdUg2Vdbjwwvm+kRTZ6woEAo=;
 b=MJ2+qugADTkQkuP1YZg49alN5vIkpO3wTMGLxHMBN8Tb0x05xJBtvtIcKZjLlRVJqF
 l7gZm16Yvd7dCvXz1hxwNChg9UZMsOsNdmvjUhP3p9SJt6JLDBvS4zNkrQg3l4pydUP0
 DaqFB3qZK2FcAVa/Vd9xB3jxZN71xhsJymdxLi/d+fQ5fYMWxcIuf6F+mbp4yhIDIP1y
 xKCTzawVsl+YyOnwf+hAgnzTIhHrjgyrgxzb3Cn7Ke3z0D2MzTN0SjgNkRb5PU2ARUVg
 t8VEhpNqCt4tuAsWkArvzqYxtOOQI3+K1ciUkv93/NpbzZYLNQ8T1GMuRoLlhq8N2/H6
 GqDg==
X-Gm-Message-State: AOAM532pm2nQ2Q4K8e+2GCqYwHT/SScmItfuV2CqN+YwWp9M5YbEy+mS
 LX8B5AmMJz3z5vDGeEFwXo37QbxfuE0GtObeWy0=
X-Google-Smtp-Source: ABdhPJw6C4TJRcAaTGXv3GmFR+ipN19UP5ywln7WzlT16qr89z7BXh/thWmlgmJpPtEx2o5xjJnLKaiILskee3bZXZY=
X-Received: by 2002:a17:907:1c05:: with SMTP id
 nc5mr5073266ejc.320.1617212970535; 
 Wed, 31 Mar 2021 10:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOsVg8oCOSHrqx_7rU_KAYugOaYxmJ1vLvrS_wAah0VKFVZ05w@mail.gmail.com>
 <CAEsQvcuTb_3meXw-X08v1MduNpCA3xA6SXq-ezuJrcC7tP+faw@mail.gmail.com>
In-Reply-To: <CAEsQvcuTb_3meXw-X08v1MduNpCA3xA6SXq-ezuJrcC7tP+faw@mail.gmail.com>
From: Lucas <jaffa225man@gmail.com>
Date: Wed, 31 Mar 2021 12:49:19 -0500
Message-ID: <CAOsVg8rE8772qnGAHwFuK4+A9QA-AcDqAH4PkLJJf2GH3tmiVQ@mail.gmail.com>
Subject: Re: [PATCH] Fixing most Roland-related devices' USB audio
To: Geraldo <geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
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

Thanks Geraldo, I'll consider that.  I am fairly certain that this patch
won't make matters worse for anyone, because applying it to the VG-99
(which apparently doesn't need it), proved that it works fine with or
without the patch.  Then, again, there may be similar code for the VG-99
always in use, specific to just it.  I could try it with my UA-4FX to see
if it continues working...  Thanks for the pointers!

On Wed, Mar 31, 2021 at 11:45 AM Geraldo <geraldogabriel@gmail.com> wrote:

> Lucas, you can always email the maintainers if you're 100% sure this patch
> will work for everybody etc., just be sure to read
> /usr/src/linux/MAINTAINERS first.
>
