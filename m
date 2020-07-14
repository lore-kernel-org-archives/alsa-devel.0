Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCEC433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:52:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9517320658
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cYy/z8VN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brx1k54T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9517320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 083F684D;
	Tue, 14 Jul 2020 22:51:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 083F684D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594759936;
	bh=ICxxZrWe37TU/q7mq2CuJl/QlW57LePZ0QpOmD/MG5w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYy/z8VNfhcxSEcvWO08p+ZEd9ID8oBLFV3DbGn7V+/StTjz96+OKxVxOH2yhTcWA
	 PWYX80dmE/PC5q2h09sLiyW+qo9JgbQp9soFx5xDuZzDWHvipYLBZSD74JgntNnNIQ
	 zrHCNCM6VrYu/rZj1/Y3bVsGX0KagfSgtJEu4oVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ED80F8016F;
	Tue, 14 Jul 2020 22:51:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0A5FF8019B; Tue, 14 Jul 2020 22:51:24 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B35A1F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 22:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B35A1F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Brx1k54T"
Received: by mail-pj1-x1042.google.com with SMTP id gc9so2355321pjb.2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xc9LWzDOKXS+ptBDNm2XPIAMDBTbm1M4WRBHaQH5FR8=;
 b=Brx1k54T6yHFWb/2X8L1OQE3az9QDKKYU1Duv8KOMrAQ+M4SJgaGsXLrp8XtrwgjYu
 hmtLTd5usxFXaQe5+XTthKKgvt5nSR+0yjhUhxY9KI+R+kUJlP7Z8yFvXyBGkknER5H3
 +HQpE4iymvg5dJ5zjEb3C2G/dg0GzjxVu2NjuUdgpEU1WT0gJ35f1a+++DdhP89Dd4V4
 2aJ5CHplHYPon1hvuXDNWcPyzINcBh0NxXfGMklD/7Vp4KzjykYtQ2RIF6EKiFDpNlQq
 2VD/Ey26RItC6eTx+Kp0z/EHwRD5/AyjwCV0dBY6VhEYkFL4vQE2pqqMt0j42m4tk7Fq
 yKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xc9LWzDOKXS+ptBDNm2XPIAMDBTbm1M4WRBHaQH5FR8=;
 b=A7CkZgKQqKQcSy4Aa5Qgw6d6r3btQhewKLugnr51Dg4G4qRvrktfPUWXoPvB0QXbF3
 7etB3bku5siMgqwhmywpvph3NNPj9OhJmbQb7akbIZ2s9KfDKnzl0kWmPg+HixY/f/b+
 HYEpTjM03823J2PtJUN/T2EDTeM8bsW4WcB0/BdHj/DoMloVem6YiE1aLE1eaiPryEna
 r+l5ZyPR9w2d517XJ+gGgo517gBvL/AI6xaM9vrqWGATgotTUbnWz5+lvxiSxAwY3li4
 //zQNsHmMKz+y2yxcMUYZ6Dy6U/i8ALuyv0n06rSXA66MpZC3dsOqIjhylnyQXQlxbQC
 OPcA==
X-Gm-Message-State: AOAM533SHxsp1ETw0O+5ZB2Ub92PQLEZ8cvutWMilGwEB7yPnHOY9cVi
 ZjzrjUNhiVy0062l1NwUwoI=
X-Google-Smtp-Source: ABdhPJxrDpJYpxIlmMfrnFwHOkB5UdB1bS6nF30tG0+uGvzhexgooTEBRVrrV+Vd9KDRkT6vEYQqOw==
X-Received: by 2002:a17:90b:94f:: with SMTP id
 dw15mr6644250pjb.199.1594759871930; 
 Tue, 14 Jul 2020 13:51:11 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id m31sm3608860pjb.52.2020.07.14.13.51.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 14 Jul 2020 13:51:11 -0700 (PDT)
Date: Tue, 14 Jul 2020 13:50:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200714205050.GB10501@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714202753.GM4900@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Timur Tabi <timur@kernel.org>, alsa-devel@alsa-project.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
 Fabio Estevam <festevam@gmail.com>
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

Hi Mark,

On Tue, Jul 14, 2020 at 09:27:53PM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2020 at 01:15:45PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 14, 2020 at 06:20:32PM +0200, Arnaud Ferraris wrote:
> 
> > > Here's some background about my use case: the i.MX6 board acts as a
> > > Bluetooth proxy between a phone and a headset. It has 2 Bluetooth
> > > modules (one for each connected device), with audio connected to SSI1 &
> > > SSI2. Audio sample rate can be either 8 or 16kHz, and bclk can be either
> > > 512 or 1024kHz, all depending of the capabilities of the headset and phone.
> > > In our case we want SSI2 to be the input clock to the ASRC and SSI1 the
> > > output clock, but there is no way to force that with auto-selection:
> > > both clocks are multiples of both 8k and 16k, so the algorithm will
> > > always select the SSI1 clock.
> 
> > Anything wrong with ASRC selecting SSI1 clock for both cases? The
> > driver calculates the divisors based on the given clock rate, so
> > the final internal rate should be the same. If there's a problem,
> > I feel that's a separate bug.
> 
> The nominal rate might be the same but if they're in different clock
> domains then the actual rates might be different (hence the desire for
> an ASRC I guess).  I can see the system wanting to choose one clock or
> the other on the basis of some system specific property (quality of the
> clock sources, tolerances of the devices involved or something) though
> it's a rather fun edge case configuration :/ .

Thanks for the input. Fox i.MX6, I don't feel it would be that
drastically different though. And both SSI1 and SSI2 can simply
select the same root clock source to avoid that happen.

Yet, in case that we need to support such an edge case, what's
a relatively common practice to allow system select the clock
source now?
