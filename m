Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C856AC4332F
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Nov 2022 03:07:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6A2815CC;
	Sat,  5 Nov 2022 04:06:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6A2815CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667617635;
	bh=xNSaBFpCPCSy5V9ezP5/XPw/Y/8OJ3YvViK2wKs5eOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqQsOAcw9qaQaXrWK5ufAkBnk8rsYNn5kZFDBLNUkgDyj9Itv0xy4QhTdDZBuvgso
	 NDulPmzDvSm80poybOtX46ve7Ar+wmW8+Zm/iOEapSxQsXl1GBA/1YgSvSE/PIJfM/
	 dkgzkifCTk/f1rvq+zw5KIMN1zkXEsVroVJiF5BU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D26AF801D5;
	Sat,  5 Nov 2022 04:06:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4960F803DC; Sat,  5 Nov 2022 04:06:21 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26050F801D5
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2022 04:06:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26050F801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="CPY+9w/N"
Received: by mail-yb1-xb2a.google.com with SMTP id y186so3167262yby.10
 for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2022 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nGToQRK0DXw7c1IROX4VhPmgoLvBloa1KH2z+OM+UGg=;
 b=CPY+9w/NotyoR2K8mPiZ618PyK22YxCp0SaqY76wYG7svkV22RWzh39pDuI6fnl3FJ
 lFRykuJZDpWiXOOBqTppN7aoJJbtQ0+rE/DWuw+XX0c/dSRay1rp1Ey05/E+WCvZ/Bjg
 igMiRkow60smusWFCyrq66Y2D4f5KUT3uuNRQh+Aw2jKJq1PHnxOyspGtuCpec4Q5C/c
 gx4CNCDSi+NFSNArebSYNtz3DJ7NtHf1Gs46UJtqtk9hgYD0LTl6PCAgyN5xli1snCgU
 op2YDQQyZ7vxi33xnLvxzgSVd/Xb/ncJY0CKciD/67fDX5RceabOytbAHDRo1ymjHMuW
 qmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nGToQRK0DXw7c1IROX4VhPmgoLvBloa1KH2z+OM+UGg=;
 b=kuW+dc8oNnaDVamCedKCTuMbYMyIkWSUoWK89AX2mu8xdVQG4otMjuh2NqalE1RV0m
 A4g2tbK1q4YPqCXP39LpIk+rnu0cMvDrUAeE/V07utSqzUJuwnTyRaCyafv3pChIezsc
 S/eTwMAzh1eNEZDt5MSsXTkkQdq/ZzBHgw+aoGIppSNTWjD9JHwByIDkl2idyIpQWF4N
 mC+4VNNYz1v8pHeMyJHuJvP5s+UaZDVZuHH4tVeWz2LKvcEzJaNqKddiBqphaiP6gJ+q
 RDepBmhvy11kXk0toPvYhdgt+T1t7NwWzOmF07Jk8/5dYfsahfO9bmPXxLqhLKg5LFpH
 xVgA==
X-Gm-Message-State: ACrzQf2YW+C6Bi93XRPf0czV57HbY5zhGe+0z3V9ElS6Y01vSVF2tzPd
 ewO8za3oYWKHQihgljnUeftFGJRrXLXlFJG2I+eDBw==
X-Google-Smtp-Source: AMsMyM5mjEha55s4t7TntUfGRbOeZ7n0QwDmEGTRga0tyK+7SOuQhQiic2xIjVB8WFzL1IEvui/sDKGlN11imSJp0FY=
X-Received: by 2002:a25:bc3:0:b0:6ca:6427:f00d with SMTP id
 186-20020a250bc3000000b006ca6427f00dmr34962639ybl.62.1667617575953; Fri, 04
 Nov 2022 20:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221102125936.2176748-1-ajye_huang@compal.corp-partner.google.com>
 <20221102125936.2176748-2-ajye_huang@compal.corp-partner.google.com>
 <166759787920.2873722.6503685794432759025.robh@kernel.org>
In-Reply-To: <166759787920.2873722.6503685794432759025.robh@kernel.org>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Sat, 5 Nov 2022 11:06:04 +0800
Message-ID: <CALprXBbu1EFNMG2VwHd+k6kVkQXFLjKx1ojNPyKWJA-QPpyPaw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 "chunxu . li" <chunxu.li@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Hi Rob,

On Sat, Nov 5, 2022 at 5:39 AM Rob Herring <robh@kernel.org> wrote:
>

> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>

I Got it.  Thanks.
