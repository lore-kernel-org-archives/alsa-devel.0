Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 21:04:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE03960F92
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 21:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE03960F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0627116B6;
	Wed, 27 Oct 2021 23:03:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0627116B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635368644;
	bh=K1cJbfN0OSOMsbFbVCJ0EO8mI0HlFfWYSQvqTD00ru4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EvjAEPU45n6+pzZUS5EakO2jpKql4d5QzH7hI/jYnffg3En29/nULBvReaeuNUcK9
	 fg0b3RjPai7L1h4WWehFyNvQQgKByrhznOWPAiHLAsMz+CzgNHLEODnjRVJmfYKvYh
	 ZEdB32QyRYzVblXDdETtVH+J1b343wvzYkIyye74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 865A5F8025A;
	Wed, 27 Oct 2021 23:03:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 694B2F8049C; Wed, 27 Oct 2021 23:03:12 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8C97F8032B
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 23:03:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8C97F8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="e35MzeQr"
Received: by mail-oi1-x22c.google.com with SMTP id t4so5281623oie.5
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to:cc;
 bh=K1cJbfN0OSOMsbFbVCJ0EO8mI0HlFfWYSQvqTD00ru4=;
 b=e35MzeQrMXHSsSdMjyOv+zh1luLWn9GrVbs5Hb4Oy5C4QMhydNIfOOCx+V/4wuT2OA
 JpTpTEp4av9Ds5cnAqZqJVPlFqwB9A1Ib8loZUcuXgaKd/EJzTs9oikW/u8LH6DR7IdR
 hSoYLWZ60pjeAEQxTcKpMn041AieviHlkwWbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to:cc;
 bh=K1cJbfN0OSOMsbFbVCJ0EO8mI0HlFfWYSQvqTD00ru4=;
 b=r9SrJ2fPPxyZhgKTWMER4GGIf+qZ2yKht3qKYfRVAm6yfWdOKeAc7ONc8oE+Ef7gTc
 izSeNl0WSsXZJu4FlQKO4e5mFVKrv4dGeDwA9fvTQjFF0n+esq4VFniUCSWvA2ZOfpCZ
 PKYOaaMWkPbKeyacQ+yYYckYx5BaYq91V2/EoH1fFHd/OvdNFnlQPQoTKE3h6b9f/VNd
 U9Qbkq07918b8zxnJ3E9pHWd3oyLIeeXDdAr0XuXqXjn83u4NeHc17IeHgNUk2JY66BS
 aeqs18QWPlmg6v0V8S1YK/1Bmd+1PV/M7B/Wi4Dz21qUACv+43n0DhMeqhdPCPIxGfn5
 0J4A==
X-Gm-Message-State: AOAM532/0hjxPgeeV6ixaMcWqCXDCMfhj+c1f7eJHl1zDD5sR4jot/XG
 9H5z6clnKu64r/NTpwN7iy96/uJlhefwUAwYpEDwUg==
X-Google-Smtp-Source: ABdhPJxHw7dmKoTIvG/anG/8Dw0L4C9jo9mZ+kAZqCRF0a97PQ4X738EkYlKk/qVhI6mGSLA+AD4D7F/zXlNIYK+1ME=
X-Received: by 2002:a05:6808:23c2:: with SMTP id
 bq2mr5657582oib.32.1635368585748; 
 Wed, 27 Oct 2021 14:03:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 14:03:05 -0700
MIME-Version: 1.0
In-Reply-To: <1635250764-13994-2-git-send-email-srivasam@codeaurora.org>
References: <1635250764-13994-1-git-send-email-srivasam@codeaurora.org>
 <1635250764-13994-2-git-send-email-srivasam@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date: Wed, 27 Oct 2021 14:03:05 -0700
Message-ID: <CAE-0n51A80C3J6t+GeADU8e4dVJBu6JX-DmVXquWK+a9ysfyWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: qcom: soundwire: Disable soundwire rxtx cgcr
 hardware control
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 alsa-devel@alsa-project.org, 
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, judyhsiao@chromium.org, lgirdwood@gmail.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz, 
 plai@codeaurora.org, robh+dt@kernel.org, rohitkr@codeaurora.org, 
 srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>
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

Quoting Srinivasa Rao Mandadapu (2021-10-26 05:19:22)
> Update soundwire master rxtx cgcr register field to make clock gating control as
> software controllable.
> It is required for soundwire v1.6.0 and above for RX and TX path to work.

Why not do that when the clk driver probes?
