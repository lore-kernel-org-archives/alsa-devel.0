Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJECT_DRUG_GAP_L,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E94C433E8
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:15:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32559208B3
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sa7L+Jrg";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCIfzsH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32559208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FDC61662;
	Wed, 12 Aug 2020 21:14:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FDC61662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597259735;
	bh=QGrQMPg9TlKjRJJfGjQlGHcmr8N+V5wzL+mRPOLSiJ4=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sa7L+JrgwmUrk/G1lUBO6Dd/5mnCyPtjsQqK1sVgJi+NWcP7n5kqN26+U8Py42rqk
	 jUjqY+kqLvHgjn6liicY2H5VaOwrQFcXzQHuf0kT5p3lVOaaS0STFnZZwWYHuWVSty
	 svM3wc761HLbaGYJhm++U0kldZ+dUT6NmDL+Thsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DB8FF800D3;
	Wed, 12 Aug 2020 21:14:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8024F8022B; Wed, 12 Aug 2020 21:14:43 +0200 (CEST)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7E0EF800D3
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 21:14:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7E0EF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VCIfzsH+"
Received: by mail-lj1-x243.google.com with SMTP id m22so3489226ljj.5
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=tYFf59hA9v+jMzuapZ0MlLUMVG9vOUbRt2fp4Brw40A=;
 b=VCIfzsH+uCHsKlZRNHmr1W3grdz/j0GxKXLKQF0Bj+PTue4HBBvlFy9Fa0NfoVEBMf
 mRbNnLIIuQhlUlceVmz1Hw4l5puMLGo0z6yZ9J6RaNigMk/fsFc3g+rUtx/MwBKT9MZt
 ReYEgMQ67q9KYLMHvK/3D3QNIUDDJvrkwyMUKTS/hE36MWWzbw94vdKfcdS5z1T5bGIV
 qQ+k6nvOictNYh5rWywIz5hMBKo+xZBjppID8lgAAvXhUjMLnheOp6depw9cF0eh7TXr
 26j9DcNdNvFV8jWSmS3Mt0DmnYRKq+pVpSX7VrWtBSDxIMymcbOc+2I0DiKqCrrXwFSC
 4xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=tYFf59hA9v+jMzuapZ0MlLUMVG9vOUbRt2fp4Brw40A=;
 b=OKPaoMqJmzn7t38XmRhDS9kvvsBro/Le8vwfbhjlrM85oyLdS/wIXSH4Owdrqb/GCA
 SzCLqYwVa09d9tWRbaMw4ekcnbQyy3PYVlvdfljNv+mv82xkxIpbpFlAGVoVB32JGzCF
 blg2basQfWp1JtSZR2U4mD33EAJx1hjbtf5uoXBbWAC3Jud5kGW4aCR/L5sDxsVdB7Br
 TD1Lx56Mj6uEfcBMIl7PLb6vdss8vk073kaXGEwaM2IN7V99uKQRqiPEzV8Re2OHnQDT
 nyDttIqcYmWyefdZ0W7vH0yjdfB9T7w/h419pLo8EPxmXyQyFkmttMevhenhifGe5tuY
 ryhQ==
X-Gm-Message-State: AOAM530VatsiDmV+neodW3Wu6JbmKPb0mqbe/Gp9mINElkxOUJyAFfbh
 AzcDW2qqib0Bd0JZIkaLyEePdmAg
X-Google-Smtp-Source: ABdhPJypq/7BRfReIxcwzBms77PIV8Tf9CfaRzMDGjw4q5DavOE4FVKVMp2HzV0HjGdchXmV+q7jTg==
X-Received: by 2002:a2e:b619:: with SMTP id r25mr353668ljn.220.1597259676032; 
 Wed, 12 Aug 2020 12:14:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id j17sm668713lfr.32.2020.08.12.12.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 12:14:35 -0700 (PDT)
To: Stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Sowjanya Komatineni
 <skomatineni@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Erik Faye-Lund <kusmabite@gmail.com>,
 Mark Brown <broonie@kernel.org>
From: Dmitry Osipenko <digetx@gmail.com>
Subject: Request to pick up couple NVIDIA Tegra ASoC patches into 5.7 kernel
Message-ID: <2db6e1ef-5cea-d479-8a7a-8f336313cb1d@gmail.com>
Date: Wed, 12 Aug 2020 22:14:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 alsa-devel@alsa-project.org
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

Hello, stable-kernel maintainers!

Could you please cherry-pick these commits into the v5.7.x kernel?

commit 0de6db30ef79b391cedd749801a49c485d2daf4b
Author: Sowjanya Komatineni <skomatineni@nvidia.com>
Date:   Mon Jan 13 23:24:17 2020 -0800

    ASoC: tegra: Use device managed resource APIs to get the clock

commit 1e4e0bf136aa4b4aa59c1e6af19844bd6d807794
Author: Sowjanya Komatineni <skomatineni@nvidia.com>
Date:   Mon Jan 13 23:24:23 2020 -0800

    ASoC: tegra: Add audio mclk parent configuration

commit ff5d18cb04f4ecccbcf05b7f83ab6df2a0d95c16
Author: Sowjanya Komatineni <skomatineni@nvidia.com>
Date:   Mon Jan 13 23:24:24 2020 -0800

    ASoC: tegra: Enable audio mclk during tegra_asoc_utils_init()

It will fix a huge warnings splat during of kernel boot on NVIDIA Tegra
SoCs. For some reason these patches haven't made into 5.7 when it was
released and several people complained about the warnings. Thanks in
advance!
