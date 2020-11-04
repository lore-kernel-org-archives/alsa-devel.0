Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417CC4741F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:07:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800ED21556
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="njAh6haV";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="on94m12o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800ED21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCD6816A8;
	Wed,  4 Nov 2020 12:06:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCD6816A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604488057;
	bh=XLrhjDQ9NrOE1vvizxHfIAu/lPIuSEstCP2tmag1wmQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njAh6haVx7jX+hQzfZiZEddqBrYpSD8nSsjc9tx+iebgnY69i/i7OXLc3N94yTkvg
	 nJlESI/AWpW1f1WJUETtDLhUA27Tgv42p9EVSDqt2VqrOVOZMushVqE2AetKlLSKlc
	 CUhNpbVjBp5iPVBrt6B14DwOB3ctzHyW8Ephd3Rs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B5E6F80232;
	Wed,  4 Nov 2020 12:06:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B148F80234; Wed,  4 Nov 2020 12:06:45 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10476F8015A
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 12:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10476F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="on94m12o"
Received: by mail-wr1-x444.google.com with SMTP id p1so2421320wrf.12
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2020 03:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Jlg1mCcxzWyJ2SSHL4wcY3QBOJAIfKFSTaTOV76kAxU=;
 b=on94m12o7fyMspT/InUuHoXm/sj7NYhP2F1Sikm3KYkBVEHfCkok9SpRWyZpCAiCs5
 ETfmuPoq+RhPctDoa/oeJin9WohJ2KfZEeBs7sGl0CQ1CpB7AQq5LqijFazEOkB11FWJ
 wF5IiswbfOk1iaMbAKEKKuD+3m81LkN31O9pjrUADAxoPu5nAx4dbu4n0xj/38bD+IqA
 L8QVJEcORH+J7+d6nMXbj6Cv5AI3AnOyrFugtzoMytl//+VuvaWelB/ywJ5PJM2QMxyp
 e481hPC3ie+alWsyL8/PSxDY46a3ZMcYnNcixlyvJpc9eNC6hx0F98qvcLmgiguGv/jj
 EdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Jlg1mCcxzWyJ2SSHL4wcY3QBOJAIfKFSTaTOV76kAxU=;
 b=hI3kckDpFAog3+w6tJ8NCg+8hrwktARGc3h9PyoNUxXmWE6P0AN4Zmvu9P1FMuVEV/
 dsJjag4uqRai0oFBIUwWlphBlM27CoPmWl/UYditM2mhJNlrXYAgLEa8nw7HwSzLkN6i
 wNNio/y52LWUIFqC0iG7DfBXedrIDQYyvkiX22/jas53uVeyZKtH4Wyc+43Ig6uBhARG
 5W917S/Fr9cvfYDo4z+mbbHGAPAp1uNCSCPvTYm0SmKHTm5obmUmgGTAJKEp469TbQm6
 yjRXC8KnuA9jTEALHgtlerwzKGYIzrT5fpjiMXVvkhv/NqpArsJzfkbxbgByQEQvhmip
 gbqQ==
X-Gm-Message-State: AOAM532hBGrv4ErYpjXw3kWett63y6Gs0zB88CMPf2qCp4eyskWDs4fQ
 SsDFL0/XwnR66amrEySVHVWGI3+HycwvP0GC
X-Google-Smtp-Source: ABdhPJwgUB9eFlFCuBC95J2Q8kDKQ1YvvO/j5at2FNEcYWob9hTg91otuv74+Qmty97HqneRoqaBtQ==
X-Received: by 2002:a5d:5344:: with SMTP id t4mr30847472wrv.267.1604487996889; 
 Wed, 04 Nov 2020 03:06:36 -0800 (PST)
Received: from dell ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id n8sm1670683wmc.11.2020.11.04.03.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 03:06:36 -0800 (PST)
Date: Wed, 4 Nov 2020 11:06:34 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] mfd: madera: Delete register field xxx_WIDTH defines
Message-ID: <20201104110634.GA4488@dell>
References: <20200925091446.7530-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925091446.7530-1-rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 25 Sep 2020, Richard Fitzgerald wrote:

> The register field xxx_WIDTH defined are not used in current code.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/registers.h | 635 ---------------------------
>  1 file changed, 635 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
