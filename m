Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0116BC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 12:29:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C58E1685;
	Tue, 23 Nov 2021 13:29:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C58E1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637670590;
	bh=QICJW6+048FxPtBkVddLUQhm90TXHBXwQ8tbqxhkpjs=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=joRMUt06FNgSfOtmxSlZ2g3hX2gOtQH46ZgXrxw3fzGihsw9lHm5b+DMCMh5G3TOc
	 eRPwWSn8MUxwy0YEO3JsNGrKxxvxOT2R2V9J1lNnyMvx5v+CJhYwqRZUuodxvKxgOI
	 XsLdkuV3kWF3EEjD2YnUbd6vRNNLKjq5Oojfh1aI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3B12F804E4;
	Tue, 23 Nov 2021 13:28:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7AB8F804E6; Tue, 23 Nov 2021 13:28:25 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3089DF804BC
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 13:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3089DF804BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="hAgpuZ3Z"
Received: by mail-wm1-x32d.google.com with SMTP id o29so18580098wms.2
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=SXnHndjn1TOt11Ey5a67F+PAyOVaDD8SBwIn9/hXTOM=;
 b=hAgpuZ3ZelFNHDs14F8O7CNddFyVIvYYLC1f5ruDP/PKnI9kflh+utx2/asmqUK1AJ
 lPaqaxDTY3ddf1sUNNhR67szBqPHix0sPG6UIx6kLte7pf+9gQimeBoBJ6P15uJ0FSV2
 Iw1YUpB3mmwicwd8pEdxkCXYDIgYDhCZRS8YFd20kx/1et6aCDdKGegyzjNvAnxIdPoZ
 51OtpXreyBi80oayfgBrs1HdyynqKFtWowUwz/E+PQaj6JGjeEkSqJak6DfaY0JCq0/R
 XKDqZVbx6sGN8Sfy1geBahySSHiOFb8C9mYaNMgBWSCdG1dxEh43UTwRGhzwPM/UwYjd
 0A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SXnHndjn1TOt11Ey5a67F+PAyOVaDD8SBwIn9/hXTOM=;
 b=JOiLT9IgA7z68/DVL+Nq66b5eUZz/FAeT0CpxTgzURhjhV3Q1KSigk7R3mlRibhamh
 g3KHROSA1nyrVegnDvorV4VivotRj4z6R+2eG5BZpbjR9PF/dYBHp6tRGXThdhSdHE0j
 Xiiee2LXOBacKG7qA6RYeX4MGjNHtYhuC8Qhkr2vcNZl8CMckgxkj5pSmXuaZLRwLwJg
 jheAprcb1S+eoGX7XPttK3xgT9kxCbrKUeirFUv26QQFD+Nqg2T/hMaTH3TarglBhIBO
 dr9a3Mss2HlwJAufCqEIn7KXPDXrKqZetBbxjkMWHA7eEoGbGjN1BHBOIbUPMrST1/5x
 wQ6g==
X-Gm-Message-State: AOAM531XBzzOuogVizqKR5+5x5VCRl34970fvL9mY0MUKUmFyOIB8vu1
 GfElLqktAb0WMaaiCkGSlCNG1A==
X-Google-Smtp-Source: ABdhPJz1cNKjWzjauR6ApzjhPMHe+RsJS+qFP85xeN5g7/aYwUtSn7orNwnE24JsXrdNFJ8YPG7k/w==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr2567233wmi.151.1637670495657; 
 Tue, 23 Nov 2021 04:28:15 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id z7sm964800wmi.33.2021.11.23.04.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 04:28:15 -0800 (PST)
Subject: Re: [PATCH v5 00/10] Add support for audio on SC7280 based targets
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <1637239714-11211-1-git-send-email-srivasam@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5f750cfc-dace-59a7-2eb4-4831a313064c@linaro.org>
Date: Tue, 23 Nov 2021 12:28:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637239714-11211-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 18/11/2021 12:48, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for Audio over wcd codec,
> digital mics, through digital codecs and without ADSP.
> This patch set depends on:

> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=570161

> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=572615

Except this one, rest of the patches are already in sound-next.
and the only dependency I see here is the final patch which adds 
Kconfigs to the soundcard SND_SOC_SC7280.
Why not just move those two lines in the patchset that adds the soundcard?



--srini


> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=559677

> 
> Changes Since V4:
>      -- Remove unused variable in lpass-sc7280 platform driver.
> Changes Since V3:
>      -- Remove redundant power domain controls. As power domains can be configured from dtsi.
> Changes Since V2:
>      -- Split lpass sc7280 cpu driver patch and create regmap config patch.
>      -- Create patches based on latest kernel tip.
>      -- Add helper function to get dma control and lpaif handle.
>      -- Remove unused variables.
> Changes Since V1:
>      -- Typo errors fix
>      -- CPU driver readable/writable apis optimization.
>      -- Add Missing config patch
>      -- Add Common api for repeated dmactl initialization.
> 
> Srinivasa Rao Mandadapu (10):
>    ASoC: qcom: Move lpass_pcm_data structure to lpass header
>    ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
>    ASoC: qcom: Add register definition for codec rddma and wrdma
>    ASoC: qcom: Add lpass CPU driver for codec dma control
>    ASoC: qcom: Add helper function to get dma control and lpaif handle
>    ASoC: qcom: Add support for codec dma driver
>    ASoC: qcom: Add regmap config support for codec dma driver
>    ASoC: dt-bindings: Add SC7280 sound card bindings
>    ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
>    ASoC: qcom: SC7280: Update config for building codec dma drivers
> 
>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  69 ++-
>   sound/soc/qcom/Kconfig                             |  13 +
>   sound/soc/qcom/Makefile                            |   4 +
>   sound/soc/qcom/common.c                            |  39 ++
>   sound/soc/qcom/common.h                            |   1 +
>   sound/soc/qcom/lpass-cdc-dma.c                     | 195 ++++++++
>   sound/soc/qcom/lpass-cpu.c                         | 245 +++++++++-
>   sound/soc/qcom/lpass-lpaif-reg.h                   | 103 ++++-
>   sound/soc/qcom/lpass-platform.c                    | 513 ++++++++++++++++++---
>   sound/soc/qcom/lpass-sc7280.c                      | 416 +++++++++++++++++
>   sound/soc/qcom/lpass.h                             | 150 ++++++
>   11 files changed, 1669 insertions(+), 79 deletions(-)
>   create mode 100644 sound/soc/qcom/lpass-cdc-dma.c
>   create mode 100644 sound/soc/qcom/lpass-sc7280.c
> 
