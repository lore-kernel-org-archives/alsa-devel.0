Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA9DC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39CB223DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39CB223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E511217D5;
	Mon, 18 Jan 2021 12:56:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E511217D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610971048;
	bh=9gtL3I/oVx9SB/EELuyq2epyZrwxXttUnwIT842Rt50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ld0AOi04Giq5yldxmlCYTDJkCNtCCInUgd/9ADHbT0WmN8wPIo/buSML6K2bVG69V
	 Yq7q2i1mIeZ6LFhEYg959RF3Wb8JOBQl7tX1RAXt4P2OwW62xaQUP9Q6TSugmIUKfZ
	 X4/25Cbm/rwiijwaXIyWGJeSboDARtZhsenx2eAY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AB73F80166;
	Mon, 18 Jan 2021 12:56:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36DD5F8016E; Mon, 18 Jan 2021 12:56:36 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3B97F800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 12:56:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3B97F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oliayb58"
Received: by mail-pj1-x1035.google.com with SMTP id cq1so9363249pjb.4
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O+Pp5eL8puRaYSNA/8vnlhxeGQpEnUC4T2Q0i2MvjpM=;
 b=oliayb58Yv5enMZCYENb6Y9eiVTLMOXKygs6mPRopMiZbE/slznkHSI5KbhcUjBtBX
 oR05CQmbKv7/t754Y1Uh4x7DdT7KkPLpavx3jV/TtgSk3kQHdFaYl6qvfzUWayg5a6eG
 MzGh1AYsK5AXV9yUVz6vC6yOZhThV4eECNWtz639DuNZCgq12PUkkr+axOOoEvDPsmnG
 onGCmoagqUkidxq74Jd0O079iFjGqfKnHXOnp1nL3xEJw1ZDl/hNstwej+fyBcowmeLs
 2pnq2kpGRHfIgLjDIQ3LQmVWnbUc+/LK6PkdLqwuypfvgZ6dY0km+pQcKi2lOEVV5WHA
 76cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O+Pp5eL8puRaYSNA/8vnlhxeGQpEnUC4T2Q0i2MvjpM=;
 b=l5OwFuhs4nMQ8tgILN1J9/MCdleD4DaWdemE0J7NFa3cJv8LvB78kHoevP2WiSXnI6
 GaRlsYdesZKZlrMRLIeMbkQjUg5lgXRo0bpUxLRrfqyji5z7EhEcFvcTxRIh7FxuSA2N
 dKC2jNrSFzxOiGrsXt04wJOmH/BVJGz3TPgX3cUJG4TUOarWf0CWA7fD8+B0xcnaPbeM
 KEi4brwRSCc3cV+W4Q74ncKoE3CyadHAmA4owk/eVqCna1l/eprZzxB/R5n5ulz6Q8NQ
 03jaCylL9ByqqjfbXLQ8ijSbwB5mVWo5Sph4wdvehQwyrXXqTPbnvYwfUhxTEXj5avWR
 lWOg==
X-Gm-Message-State: AOAM532yskMYnjy/mS/I7XjBZD+NPHQV7Oi2onrqDPAR8fNqgnFoCUk5
 An8ON+dw5bFrhPl2ju/B3pXC0H7xgKEci3lySQY=
X-Google-Smtp-Source: ABdhPJyokVKFXyUFIND8V4pfsCfAbi5v5uuzbNGREZh4UGsK1+n22ndvgRqGOFKqvMiROPgNAE+3GYGkF3BK1ZffG/Y=
X-Received: by 2002:a17:90a:6c90:: with SMTP id
 y16mr26665016pjj.129.1610970990165; 
 Mon, 18 Jan 2021 03:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-3-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-3-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Jan 2021 13:57:19 +0200
Message-ID: <CAHp75VePZ1Nj3x_xzbpBU_-h4tmOGtfcOnfqeFBsbWOYEMB7mQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] ASoC: arizona-jack: Add arizona-jack.c
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
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

On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add an unmodified copy of drivers/extcon/extcon-arizona.c as
> sound/soc/codecs/arizona-jack.c .

Usually adding -M -C to `git format-patch` helps a lot of rename detections.
I think in the next version we easily see the evidence of the above
which makes review by snapping our fingers.

> This is a preparation patch for converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.

-- 
With Best Regards,
Andy Shevchenko
