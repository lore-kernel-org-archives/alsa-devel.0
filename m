Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CDC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 23:14:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952F320734
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 23:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CyMsouDK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxfbcYL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952F320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25E9D1616;
	Tue, 11 Aug 2020 01:13:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25E9D1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597101260;
	bh=iyVeKJ2q5xQh919RCoiLU+/tfOIiYUOyXbeHlRpVfj0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyMsouDKuvuQCKaB8hJDsebJrYcWewYDTJCtBcPldbsZ7S4gnIuxBHJK1Q6U1FBBe
	 PdEFEl1pAWf0ZKlIpBb5oQ9W4LzpQ5sd/ilECeGkVIWl9UPSfvKpPHepROJKmIqFy6
	 GLVuEVlVLBiwKRovF6xpL5BJyJwXI7d7RT7Agqes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C884AF8022D;
	Tue, 11 Aug 2020 01:13:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 012C1F80245; Tue, 11 Aug 2020 01:13:27 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2731CF800BC
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 01:13:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2731CF800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DxfbcYL8"
Received: by mail-pg1-x541.google.com with SMTP id p37so1615356pgl.3
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
 b=DxfbcYL83VI2tavwmTPi4J7eMSAsVh5SiXRXgr7w6VpnDWom8eqTPeZM8kNx8aL71a
 YNZoipg4ai47uUfLCO0TnZ91g/QuIs8WREnZk/H0YzF7U0oi4AVYSpa0/AhTDktapZMm
 +cqkDu7gKDDEZg/oD43W+K3+eGJVqa6jxoEdOXuiHP6AMTsB/rnpkSev/8TXRtRBlLNJ
 w+SE3h9I5KCD64mEmOANa/VzYKCKJc9fdAP5BwCZnjSMApRtpocutZiNjy9jEeV/kyDK
 uwQQaxAS9KK+svH70uw9w6/i3VlM0a7nFuMa42dpeHI4vYLfebLjf9P60kMHU7i6p/hq
 rl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
 b=sXiqN64d+8AEKb+A6VBmtfvYkBapawRktRftstxm/3j9jYb+Uvdl8hkRjYWricxaUD
 mIjmSi20ewpYt0TyTiFY1O2cuyBBvA/IYtaDKy5nEPiiSb2JMDwS1QaF+/s9mDnOKiYs
 iOnYK5O7kyltEJFMDO8ltLJ6SYLoVbZySuVy8Rl+uMVHWwgT0dILHHa7mtctgYfpxxjw
 r+6jXxkgqOa4R8fHeXUu/FbYZ/G5lsEDZ/FBiUs0ls+TTMGyvUIaZjK361vJ4LKpxeFC
 YafPnH6ZlJYYC0hOh23M33vJGd3sjPjqvEtP2EjUE3IsUt6JWGbLKzvaAIrOEO5/VBTf
 3Ijg==
X-Gm-Message-State: AOAM532e00W42fd+E/BwpzgYSbaMg4tdxKnPvaWppVxWeN4vyB+Zi3Fg
 ZDB5Dhv04GsP6igGV5+4zlQ=
X-Google-Smtp-Source: ABdhPJxv/TJg5AlqUpTIn9TvhqOmpz9wa9cBMbF4+XxBG2Uvfkj7gl65QPxHpEMaYIt+NDJjbmpUrQ==
X-Received: by 2002:a63:3850:: with SMTP id h16mr23683492pgn.218.1597101198635; 
 Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 193sm22875595pfu.169.2020.08.10.16.13.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Date: Mon, 10 Aug 2020 16:13:15 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810231314.GB16645@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
