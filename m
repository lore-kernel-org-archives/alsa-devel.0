Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE05CA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E0621928
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TGJsWVHH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdcFQ2zU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E0621928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25B9815E0;
	Wed, 23 Oct 2019 19:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25B9815E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571850224;
	bh=zzuRFtrC8bABOh36SE0DrDALU1zxjQJMU0OauBR0O74=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TGJsWVHH2M3HvOxOPVy88P01MpRTZTsxqZsS4IOMfYx7/2o+MD98BiHVCRFWN9NpM
	 jXKFaY9vosYnTOX57Vqe9tyLw9kcg7yq/bWpiOV3E1skwnYTriQyEkJuaeQPyyxXFT
	 NevzKfMlgnMMLEqM01ShV7KgJTzig1gXYXWev2YU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9531F802DF;
	Wed, 23 Oct 2019 19:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9875BF80321; Wed, 23 Oct 2019 19:02:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A50B7F80112
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 19:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A50B7F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hdcFQ2zU"
Received: by mail-wr1-x432.google.com with SMTP id v9so11649747wrq.5
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uE+JT7wHDVEVCFCaXnlKwOa/x//+eH+0rrCYoIVQybw=;
 b=hdcFQ2zUY/rueFZGHLdqdRB9qPMuXANKL7Dri/nGl2B3Pa9FXTy2AaYT9r36MHFT96
 Ra2i8+ZVAGdEFFCyg+a+6zLGt0YjIWyGoMWqDzugdGTC4LNGfHAJv/l8BXXNyfXNnfjh
 KIM7IamgKeZxwMOoFcFeAfnf8HCtiiN2lq7Wu0L9VsfZEdqKod85nwNYCqRExTHIJ2OR
 HqddchhglFrDb2LbDyYPkwI/YCaH0aLO/gBs4V4viXymySnVNsGajYG1/eXvFazI7xCD
 jo82jTMLTyYb5MLv+yf+Fj51wkZFEWi1/6zXlGn/8rIexAszIlILyfZ29NFjL/aa5Qrc
 HXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uE+JT7wHDVEVCFCaXnlKwOa/x//+eH+0rrCYoIVQybw=;
 b=rCpdKyni2dMnRN7bomu03oNhgd3EE8NLbyx36AuJPq3XliyWlHUBYgRm+J6vxH9bgb
 yamTUD4zANgnpcmQRngIGaJ1k0FNiRjfzGVEiYYPUt3WLtjmT4BmFNDY0ADmdJN1quUj
 2bVefzN38yvzkdKhx3ruuCcTAufICqgVy/W5gyU2zV+2FRwvwQC2Ug7dmE4pULWRK6oK
 z5GXM851YtVRp8u7LDEqh8TW3ucxtvm4Dd9U829LIJWO8aaz3is0Bw1nuApv4N1sPUMv
 7sltee8Q87YDfumcf+GpsvnBJr6CnJk32U2XB6OA6IbbKZdQb9zTo7Flx8FE4YXfb56f
 83wg==
X-Gm-Message-State: APjAAAVMWFlI+HVPsfiGs3286TUlv3/aWlonG+sBgw+nZ+hD7IMC9/x/
 /c1QPlNaPhIShMrK5LYJfLhSIyLR6g9i9RifJXY=
X-Google-Smtp-Source: APXvYqwKaaeVTZXxQEbsOGXCB6psY3x+O5JGaYe8yWIL+BMJIlbnjUl4R/04c5J7fW3IiWXmm/qzxgPZzn8N9DNDyKw=
X-Received: by 2002:adf:f592:: with SMTP id f18mr9927875wro.33.1571850166694; 
 Wed, 23 Oct 2019 10:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACtB+u0=M5kn6OWXad=1Z=PQaqbjtNStmpxDMpei_V6btwWBEQ@mail.gmail.com>
 <abfa1e3c-b292-f045-fce2-b5df47b1cfa0@perex.cz>
In-Reply-To: <abfa1e3c-b292-f045-fce2-b5df47b1cfa0@perex.cz>
From: ed nwave <ed.nwave@gmail.com>
Date: Wed, 23 Oct 2019 18:02:35 +0100
Message-ID: <CACtB+u1mLsyGriHymyARLAwKytqkEG_F8F0YwUKJJ324mfDttw@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] alsaloop change avail_min question
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

OK, next time it does it I will post the parameters. The CPU usage is very
low for 44100 alsaloop in general. For future reference what does the
avail_min do/represent? Knowing what this value does may help next time it
occurs.

Thanks.

On Wed, Oct 23, 2019 at 5:25 PM Jaroslav Kysela <perex@perex.cz> wrote:

> Dne 23. 10. 19 v 15:44 ed nwave napsal(a):
> > Hi,
> >
> > Over time I see the message below and the value slowly creeps up. Is
> this a
> > simple information output or more of a warning? If run alsaloop for a
> long
> > time - many hours of music, will alsaloop be prone to failure because of
> > this value increasing?
> >
> > playback plughw:Siso: change avail_min=7299
>
> It's difficult to say without knowing the details (the used parameters).
> The
> avail_min increase was added to avoid "no wait" loop (100% CPU usage).
>
>                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
