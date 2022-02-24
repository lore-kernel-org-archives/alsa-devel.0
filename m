Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952FCC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Feb 2022 23:25:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EC8D1AC7;
	Fri, 25 Feb 2022 00:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EC8D1AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645745155;
	bh=ykl5+gmxA4yVeV9VmJK6ewapdNVNECzVgJJevXCRQuc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kg5mqZ/tf7za0cGyaHZ5B4MgssUthC8YeWAcp5PNBKOtcIX7SNptOE/86dJDs2NlG
	 v4bQgSxB74ikMysW+Hbk/wvts2WBOIThRvCRvqQND7vLNXgRK3N1Z+LW9kVO+hd078
	 E3VjUfZEPRirnnuIbBhvwtSZCZnOtXIqWfnEd3r0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0FF5F80118;
	Fri, 25 Feb 2022 00:25:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F157F8030F; Fri, 25 Feb 2022 00:25:01 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC4AEF800B6
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 00:24:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC4AEF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="TqnUO6z4"
Received: by mail-oo1-xc2b.google.com with SMTP id
 189-20020a4a03c6000000b003179d7b30d8so4145136ooi.2
 for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2022 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to:cc;
 bh=ykl5+gmxA4yVeV9VmJK6ewapdNVNECzVgJJevXCRQuc=;
 b=TqnUO6z4Q6nA3vvMK4mvsAFxAm2dn/5v+tTeKoc+l5Bx/GpmNS+0w9whrVtnIekxTU
 Y8I0pVxPqJRS9yvOk8U+qh/lJUlnOu2zJ/2ALFyxMTPDBuazPTdITNufwlzT5F7g4qRB
 PHeHFonNG6dDZgQ1E9it56/ppFnxJ2JeZDODU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to:cc;
 bh=ykl5+gmxA4yVeV9VmJK6ewapdNVNECzVgJJevXCRQuc=;
 b=Q6cWrz7ZP7yeBf/3vHDO4850ysV00sdhimVG257WyCMDZWHTUPXn4hnlE78ycfLkUI
 W5fTe63aWVj///BW7GNKJe6Iz+ZZitWZkr67RHtCYrWQ7VyYuQKcOqRMq/bP/Cgw4tuj
 YyYpKe1nAVswlABndoQmMLPCqXBSdAbfQXGJUcOevA/40sIql1UmiPKQT2fLnyexDEvH
 CPf0YTTr5PWnkVv5F3LcHVRDvP6DqTDSo4lgM0zj+kunBviyD+lQOfu/aV+/s9AG0nYV
 kffHuHFpt1joKhm745W3Y6Ccpa6UhKhKYsqPHssNQxeqaBapAdSXFDuG9RAkl2HmCufY
 h8xw==
X-Gm-Message-State: AOAM530M/dBDK69LqdcbDeY3u/fBOFVZtJrs8gB391Rnd/zk8uxMW2/3
 jEHLoumXszFozOnwccZ7+7POpBww1RZPC8h8c2roHQ==
X-Google-Smtp-Source: ABdhPJxPu46LL0CWhZZy8QN5RXliJtD35auxrUHD4Ow5T5vwfCuYokKQpnP4+gcm1fxEoLSBSOT66tZKar/j9/lM6lM=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr233403oap.54.1645745096848; Thu, 24 Feb
 2022 15:24:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Feb 2022 15:24:56 -0800
MIME-Version: 1.0
In-Reply-To: <1645716828-15305-10-git-send-email-quic_srivasam@quicinc.com>
References: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com>
 <1645716828-15305-10-git-send-email-quic_srivasam@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 24 Feb 2022 15:24:56 -0800
Message-ID: <CAE-0n51Lc8N=yfx0N=sSGYQLDSpUK_q3HEUkb6d4s1sdQ6W_3A@mail.gmail.com>
Subject: Re: [PATCH v16 9/9] ASoC: qcom: lpass-sc7280: Add platform driver for
 lpass audio
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org, 
 alsa-devel@alsa-project.org, bgoswami@codeaurora.org, 
 bjorn.andersson@linaro.org, broonie@kernel.org, devicetree@vger.kernel.org, 
 judyhsiao@chromium.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, perex@perex.cz, quic_plai@quicinc.com, 
 robh+dt@kernel.org, rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org, 
 tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>
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

Quoting Srinivasa Rao Mandadapu (2022-02-24 07:33:48)
> diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
> new file mode 100644
> index 0000000..70c4df8
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-sc7280.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + *
> + * lpass-sc7180.c -- ALSA SoC platform-machine driver for QTi LPASS

Should be sc7280, but really the filename should be removed entirely.

> + */
> +
> +#include <linux/module.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <dt-bindings/sound/sc7180-lpass.h>

Is that right? Or is it supposed to be dt-bindings/sound/sc7280-lpass.h?
