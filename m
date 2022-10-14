Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B45C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Oct 2022 21:12:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA60F7165;
	Fri, 14 Oct 2022 23:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA60F7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665781955;
	bh=6jwfF09RX9SPB61+LJj7nv1vEfRoVd60VC+o2CeyfvU=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A7aqVGFnuy/rUUYKcrUubYrI3ScMMxTtRQukVlth3xSDEQrvv3of0nZn4eeL/h96l
	 BYW/v8q2R6A4suk66YEQRO96RO8AAHFh4+H5vDtB0u4CUiVv+tDDNyZU8M83Zvkow9
	 /akOj0yfEIYDFaeG3dBErGkO+XATY3JTOm0BvJmw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55A3BF80224;
	Fri, 14 Oct 2022 23:11:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1183EF800F3; Fri, 14 Oct 2022 23:11:44 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C63F1F800F3
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2022 23:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C63F1F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="iHm36fzo"
Received: by mail-lj1-x22d.google.com with SMTP id m23so7455017lji.2
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2022 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=to:subject:message-id:date:user-agent:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6jwfF09RX9SPB61+LJj7nv1vEfRoVd60VC+o2CeyfvU=;
 b=iHm36fzoSenUKyJ54SzKpNGU/JQ0oDueku+u2hzC1q/MCUUZTYHSLR/ZfvBB1C16lQ
 RzDHaiWQooj1MlWHUEIVEKXTGc77LVM8ONn6Ic/+4yxdRvQAPFnznHieKyhYsXAtLPnm
 xTlysvwOarVxtq/fOp2kw6uZF4CHGS+b2QRlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:user-agent:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jwfF09RX9SPB61+LJj7nv1vEfRoVd60VC+o2CeyfvU=;
 b=fJVmYrvcGwrJQrwfDjmk9ZpshRNNfvZiBolj3gmicVML2hG4MzKV6R6YsIWbO3zDAn
 huY0bVW5Mepn9kxao60e+/V+t6yH4QN3nVAo0K++pRoOZ5UxwngA4sJ7FKzka00TzGvc
 nqoANJy+whLUvPVmf2/JYT1CvbOYva3f3+2ujci0irESn4oECw0cj/TCpMA/kSapwPNI
 LOE1VhdUXQ2PT84PO5yvuZuE8x18ss3qYeO+t8DEOWFU7vJU1vPR8anRua+97o5DRxHp
 05cJZ5vIUPKVaL36eDLaDawqsBuPEesLSpJTqbLt/joJ3f0djw1PKEg2ynI7gC1q9YKX
 yraw==
X-Gm-Message-State: ACrzQf2DE1Lr5vBG+6hpOM+w4plcjIlzBkkx8PZS1pSLcqlKoe9srtR1
 5F3ag1WYZJRQ8FtNjrDaf348/8m7BfrCAdp8xkgDHA==
X-Google-Smtp-Source: AMsMyM6dAMgpCNreqELEnwCjhZUQh7Y6izlRrC/9R2k8ZvsYCFHyMOajVJ8CIsdxwJYjy9S2SJJo7cEKYi3hfFZxhEc=
X-Received: by 2002:a05:651c:1112:b0:26c:7323:3f2c with SMTP id
 e18-20020a05651c111200b0026c73233f2cmr2649758ljo.4.1665781895643; Fri, 14 Oct
 2022 14:11:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Oct 2022 14:11:35 -0700
MIME-Version: 1.0
In-Reply-To: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 14 Oct 2022 14:11:35 -0700
Message-ID: <CAE-0n53W3+MgRzpkV-9kBc6Pcvzta+ear3oxgMA-0rpNyJyJwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: mark HDMI TX registers as
 volatile
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org, 
 alsa-devel@alsa-project.org, andersson@kernel.org, bgoswami@quicinc.com, 
 broonie@kernel.org, devicetree@vger.kernel.org, judyhsiao@chromium.org, 
 lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, perex@perex.cz, quic_plai@quicinc.com, 
 quic_rohkumar@quicinc.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org, 
 tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
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

Quoting Srinivasa Rao Mandadapu (2022-10-12 22:08:31)
> Update HDMI volatile registers list as DMA, Channel Selection registers,
> vbit control registers are being reflected by hardware DP port
> disconnection.
>
> This update is required to fix no display and no sound issue observed
> after reconnecting TAMA/SANWA DP cables.
> Once DP cable is unplugged, DMA control registers are being reset by
> hardware, however at second plugin, new dma control values does not
> updated to the dma hardware registers since new register value and
> cached values at the time of first plugin are same.
>
> Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reported-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

I found that another patch in this area hasn't been applied[1]. Is it
still relevant? We're still carrying it in the chromium tree. If it is
relevant can you please resend it.

[1] https://lore.kernel.org/all/1602596728-11783-1-git-send-email-srivasam@codeaurora.org/
