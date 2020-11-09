Return-Path: <SRS0=odsy=EP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F603C5517A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:42:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5762074F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DjZhcpQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5762074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69E711699;
	Mon,  9 Nov 2020 21:41:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69E711699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604954530;
	bh=xNpGi4JV877JHCf2S/yGV/O6IYIg8loknO4gTr2b/LU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DjZhcpQsKYJl/zKjsVCseQ3kecnfB0RzYD57bgGUSPNJ4uzEQilALawvnqqY+IK6G
	 YHRzWvc+EClc+kv9k7VP/m3VG284HAEUTfywytLb1tWTWdiAtkQ2FYWUuGYx5p5S1k
	 hMHgFy8XmkHBKMgn85/GfMmLvQmog9bVDq15hHOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E94B5F800EA;
	Mon,  9 Nov 2020 21:41:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C893F8020C; Mon,  9 Nov 2020 21:41:18 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22B07F800EA
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2020 21:41:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22B07F800EA
Received: by mail-ot1-f65.google.com with SMTP id y22so10299300oti.10
 for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2020 12:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y6HZO7jP6c7BF7SUht1RlV0MFshBv51INskr3Wu1OLo=;
 b=NtptTq1yqrPQNHEdrI3av71+rziDWbO73aIhDrwdUy7itd54um6SaJuonqPnSYdIgf
 wH0/8+AtTIxNzHtyF3g8t3/pM+WFdwIJaHk9i6wgr10x6H1fTae6n1zQhpnWs/4Hcm88
 eTP1Lcw/eYOs5I0WSa+OI5C7q/w9/R1jHczJp5MwK3pTRKH7Uemx5fC1Xz26ChX5Wtc0
 fTZtsQlTBrwNZM/Vpu4YgvXL92smRH9T2RSWszbH06s+3+Qm14HI05INO+yGEJFX5H91
 azGYtgvTbEWvoOF3XiMJ7dkELBldw93bVe6SBcbCW+L1iNM0iUduK2MuLGzpWwNwzh2C
 yhwA==
X-Gm-Message-State: AOAM533xtoX8v07Ll5QXrkDm4tw3NkrE9r2t80UeAMXUBEEE1TNVN6Od
 4PosTSFEVCQ/RY+2JRRDhA==
X-Google-Smtp-Source: ABdhPJz2+VjudVKMD58sQr7OAQeP43oiVi9jf++q43tMEXvFXPHXzsh1M+C1qAmkP1SrUDfMRz231A==
X-Received: by 2002:a05:6830:22ef:: with SMTP id
 t15mr10861443otc.146.1604954473902; 
 Mon, 09 Nov 2020 12:41:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o29sm2792939ote.7.2020.11.09.12.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 12:41:13 -0800 (PST)
Received: (nullmailer pid 1724608 invoked by uid 1000);
 Mon, 09 Nov 2020 20:41:11 -0000
Date: Mon, 9 Nov 2020 14:41:11 -0600
From: Rob Herring <robh@kernel.org>
To: Ajye Huang <ajye.huang@gmail.com>
Subject: Re: [PATCH v6 1/2] ASoC: google: dt-bindings: modify machine
 bindings for two MICs case
Message-ID: <20201109204111.GA1724579@bogus>
References: <20201106061433.1483129-1-ajye_huang@compal.corp-partner.google.com>
 <20201106061433.1483129-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106061433.1483129-2-ajye_huang@compal.corp-partner.google.com>
Cc: dianders@chromium.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 srinivas.kandagatla@linaro.org, Mark Brown <broonie@kernel.org>,
 tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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

On Fri, 06 Nov 2020 14:14:32 +0800, Ajye Huang wrote:
> Add a property "dmic-gpios" for switching between two MICs.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  .../devicetree/bindings/sound/google,sc7180-trogdor.yaml  | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
