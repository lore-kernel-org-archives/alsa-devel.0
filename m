Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF0EC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 03:20:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D25C6128C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 03:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D25C6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44382168D;
	Tue, 28 Sep 2021 05:19:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44382168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632799230;
	bh=2GQYD0Se81crx/6pf3v8GB06gIzCuqscmP/pjPDkTrg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=napbRlfhs6JkWB6dsQ60yzgd0lPz/C8tk9n1wdWPqtGHEqOn5/th6EKdDebFu2b7X
	 NoeJ7hPm2ED36r9G8sZEdozNBZ7jXCPeVjidyu/QCKRlhfdTIhRijoE5cWiOAT//qy
	 SGHwCrX97gqRHps9HBFRzIFJrjA5mVa7hyLwsdrE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9939F8032C;
	Tue, 28 Sep 2021 05:19:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B5DBF804AD; Tue, 28 Sep 2021 05:19:37 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3844EF800DE
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 05:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3844EF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="BoV7/r/5"
Received: by mail-oi1-x22d.google.com with SMTP id a3so28321682oid.6
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=onA5gitzbhND4lKJZ/81nF5bPiG9NjZqAmNBCuE2l2A=;
 b=BoV7/r/5pjnRACCDFHqcmeD3ZZJsdegN3esgBhOrbaFfVQ4ElfWsoo9Y8MJyhFdbwK
 iAEcmA2L7trGtGiaKwapfSE7qMU9toSYwaGsE1fAZcrYEQXRCRsNONqGBlry2ZrHoi2N
 kUlxMlgb6XJ4LwGB65lOKico9CyDaPxWAv+8h/chyfbK3hLCK2wxhzxVhtpEuQA0AMkE
 /ZT6VRovv1LQW/uaKaa5feIp4CPg9kQVOjn0tpMkWrp8AwoHwQP1BWsxGrllGeeuruWZ
 tGZelOVcEuGWBOiI8Ovp580Chl/8ryHva3gyIo6oItmj+xY5T7q2rHe14g1pLLgf16l4
 mHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=onA5gitzbhND4lKJZ/81nF5bPiG9NjZqAmNBCuE2l2A=;
 b=Hkpujp/BJfUaItT4ePCpgxyrmMMeppIHLHIW/AiBfbXD4Ul2X64eNM6ocyA7pNsWlQ
 4pCfJBxkwzqj+4SN+LU3uMPjVWGLXS6L5JLFfqHVUYO+Uw4FR+aP4xDNQzZJyD0bZlV8
 BdQ9KzsPySpFhSuczOdWKsw3qtjMqIuADx7Lzb2y9F/fttAq/W+Kj8sBsUYaptO54PEV
 /hXhWZ60OjlSCo1BK5+TjxpSUmKcWVcZPGtipBugCmwCVKD6FmO/3/wo9PS0Wqul4G2F
 Voee8JccxwW+sEYvI3Frn7/LWKiNgJXB3DoIoa1TSsf6HbK8ac85c9MepXhzvQpiecd9
 6jvg==
X-Gm-Message-State: AOAM533fokwajTb8CndS9VksoA+mhXjqWsewE8pHETr8eCHQf7Cb1Kte
 dE2T7OrY7qskZJOyX5etXAn9Tg==
X-Google-Smtp-Source: ABdhPJzD2pIquIHT4rCoKN3ZqPDhiYOCZ9J1OQLWBtRH2r+M0Hl4qv3X8fbbURpYDjfh7T1wshZicA==
X-Received: by 2002:a05:6808:1912:: with SMTP id
 bf18mr1910365oib.118.1632799167177; 
 Mon, 27 Sep 2021 20:19:27 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id h17sm555962oog.17.2021.09.27.20.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 20:19:26 -0700 (PDT)
Date: Mon, 27 Sep 2021 22:19:25 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v8 00/22] ASoC: qcom: Add AudioReach support
Message-ID: <YVKJvUMW5RWVzTT2@builder.lan>
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, lgirdwood@gmail.com,
 plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, broonie@kernel.org
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

On Mon 27 Sep 08:55 CDT 2021, Srinivas Kandagatla wrote:
[..]
> Srinivas Kandagatla (22):
>   soc: dt-bindings: qcom: apr: convert to yaml
>   soc: dt-bindings: qcom: apr: deprecate qcom,apr-domain property
>   soc: qcom: apr: make code more reuseable
>   soc: dt-bindings: qcom: add gpr bindings
>   soc: qcom: apr: Add GPR support

These patches has been merged into the Qualcomm drivers-for-5.16 tree
and an immutable tag is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git tags/20210927135559.738-6-srinivas.kandagatla@linaro.org

Regards,
Bjorn
