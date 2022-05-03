Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A0C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  3 May 2022 19:30:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF94D1E9;
	Tue,  3 May 2022 21:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF94D1E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651606236;
	bh=/sMPx0Q7vuhT+hZhEY7JNXOqCnkElBva45U2hfvPR28=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ag31B/MoG/uh1ACaDzu+9UqAmHnk8xB2qReOQPzugZ2vc3krx1jZKO2862H+9Z2O2
	 M8cHKnS5qvF5LAHxcVU700YLCkbY15qiE9+bSVMXNYrMVdkGr93Ryyk2F4BszjD59w
	 +o6ywfOhNNIGZjTZL6GouvA3FAsvKzzo7H8JBKc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B173F80158;
	Tue,  3 May 2022 21:29:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F0BBF80236; Tue,  3 May 2022 21:29:43 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F4ADF800E5
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2022 21:29:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F4ADF800E5
Received: by mail-oi1-f169.google.com with SMTP id r8so19226025oib.5
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2022 12:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N6FBWOVMzK5yNDB3jrOFO2jTg3V4GRtMSkZ1a8GNUMQ=;
 b=tFkQyXUekXz8tlyhPbyEZM3j86nrdz3mTB/NTUA98HDrQo0Pgn6QlpQMHJTOPw3k6D
 UYgxCuNiAwYCZaIZdOhykQlkrr78gvpX5Lu0gkzooSqjAXUAGZIDcDS+CLMB0krSPVQg
 u4Qi7RAxcgpjtZTOavu5/Z4O6jqo72bOBu1+tMiewR9akFJTF5DfNQoXyFecLerbYovR
 kqN0teA8z3emo9XySfxLs8cR/NNRNuuTN8w194UHnduzG4oZHPAwkHZEO3FpmrLzYnK8
 YU4kOQzmY9QHrbMsZa2WoMgzsV8elFroluU7teDz1NOSAxx35ndS7bXCAzMmm3sMCWw8
 bfOg==
X-Gm-Message-State: AOAM531w4rapvBwNVj4Doddd175949kDUPS1EU5OebXGzbIhR/jtt6x+
 F2e90cRRK5TcUOG223usgA==
X-Google-Smtp-Source: ABdhPJwHStHNylKAW5q1CVdmc/nFF0J7q1+CmHjl7uJiGrks+Q8zBnDcOHfO7bLb+qwWjN1Rxd07PQ==
X-Received: by 2002:a05:6808:1a1d:b0:325:c812:496b with SMTP id
 bk29-20020a0568081a1d00b00325c812496bmr2515687oib.106.1651606172384; 
 Tue, 03 May 2022 12:29:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 p203-20020acaf1d4000000b00325cda1ffacsm3617063oih.43.2022.05.03.12.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 12:29:32 -0700 (PDT)
Received: (nullmailer pid 4088847 invoked by uid 1000);
 Tue, 03 May 2022 19:29:31 -0000
Date: Tue, 3 May 2022 14:29:31 -0500
From: Rob Herring <robh@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v4 14/18] dt-bindings: mediatek: mt8186: add audio afe document
Message-ID: <YnGCmwNRZst+W5nb@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-15-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-15-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 broonie@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Thu, 28 Apr 2022 17:33:51 +0800, Jiaxin Yu wrote:
> Add mt8186 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
