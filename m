Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7793C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 19:09:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C8421D7F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 19:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uL9DE1Ed";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9GVLTZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C8421D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF833167E;
	Mon, 12 Oct 2020 21:08:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF833167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602529762;
	bh=ma6NjbNJ5aaYAZwWnt+/fd9ZUPdDM9ALB2EOFjB1py8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uL9DE1EdDaSpcmMo3pOi8r6WAS0XpQjKi8IQlhi/jiZsbeLwKNrd4KJmx1E4kgeHi
	 SLTQcfpdY5nzZstolipLeyCX0DdlytrS0ujFtG8MSkIOqJtPZqsFWoL9HtupMYMftG
	 XKxHVdYBTTREBHCB0KvBEyqu6CyaV+Matp/mcw5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 635D6F8020D;
	Mon, 12 Oct 2020 21:08:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7F25F80217; Mon, 12 Oct 2020 21:08:30 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91DD4F800F6
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 21:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91DD4F800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="b9GVLTZc"
Received: by mail-pl1-x641.google.com with SMTP id d6so9131379plo.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
 b=b9GVLTZcD8hI5Pa0lYQpQysftTjixmM5ALJCTVZvP5J6ZHy41IBA9DS+ExAop9sM59
 /LI3g52m0l+5VzqiQoyp/GweRshZlzeOPSbmksxJs4frRcBz563P7Hec6N+xDpK8wq+d
 8xnCF3fbAxMWBnCbEkJvn0BBQoFar7dwIhn8ikDQXXO6Vm48qVc2p2zBMDfvrYB1pBvd
 8PHewJl4Z3+FanYnqYBnnSJSz8LkIn2FLP6yvyON8BXeiu/kOnbn/7M7p8zzIz3APhND
 KQDqJ4CgOxP2NtEakj4BLHA+jT1Fo6XhGwquEEKFbUb19sahC8pEf5jRxYeEzDJSBFqt
 SoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
 b=LvUwpg2Rek57pV4pgVG4f+rfGd/2yaHW7gEprgl7v1AOhWLUQ1Rov4o9khp07JYqZp
 qWBU+8+NYkMof2Q9SwPU0PBhURp6y/PCTxAJIoENal1PsvlcckjXU/MIxJAHv37tWPEl
 RVo+JjB8iUiKffL0hLus9eEXc92npFH4cFCTx6jj89p45bZfnoFqf31XK2hMfIJC+Sky
 HegmFD2i2JS45QxMhAT/qmQwKnXtIknMoozcA9pwCWqpVPwU8/AuMid+mIzGzLS4ipJx
 paIqMr4m3V/8xwQRsZtDimWS89RWcqm1MfK0o7AyxS6nWMIb4TuQ5ctvMduFCUZbffxy
 S/2w==
X-Gm-Message-State: AOAM532U/UnqPIc1z1/cQfVRdsoNVBsEpCjz+z5CV/g0EYSfyR1QSCDM
 YDi+lKSZ4bx8Za5rd3X6ycs=
X-Google-Smtp-Source: ABdhPJz+f2A+tX5w9xGTOqmWei3lNZIF6S21G/3LO8dmNxWD06QmSquO6fSjKsvwO4qBcjZBFkHdiw==
X-Received: by 2002:a17:902:6845:b029:d4:d1d5:2139 with SMTP id
 f5-20020a1709026845b02900d4d1d52139mr9524779pln.53.1602529701706; 
 Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r6sm16945719pfg.85.2020.10.12.12.08.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Date: Mon, 12 Oct 2020 12:00:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
Message-ID: <20201012190037.GB17643@Asurada-Nvidia>
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

Hi Shengjiu,

On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> Add 88200Hz and 176400Hz sample rates support for TX.
> Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Probably should put your own Signed-off at the bottom?

Anyway:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
