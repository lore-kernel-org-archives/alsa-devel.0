Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F535C2BA17
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:10:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF874206B8
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kp6Mshuh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wO66w7Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF874206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA460825;
	Mon,  6 Apr 2020 20:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA460825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586196608;
	bh=wyc9fHmBuBpUeOJDt6Fi986lNkFAWYBK25zi7EZ6Bmc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kp6MshuhoQZt6D1kewvvqVl0DnNL2fQBdfOlX5Uw9pMcW8aV7kbXJFfBl9pxvCa6d
	 AMMePW0Mwbqu+48j2wFptnAgZwXD8aJnKCMB0SQI/6ucZEtdDgqLC3A/7ndSCEWRZa
	 K9pSAF2pCsslDMiyfAAFNcPIVcD5kTsCDwvl/+gw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B3BDF80142;
	Mon,  6 Apr 2020 20:09:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DDACF80143; Mon,  6 Apr 2020 20:09:15 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A320BF800CC
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 20:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A320BF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="wO66w7Ry"
Received: by mail-il1-x143.google.com with SMTP id r5so392505ilq.6
 for <alsa-devel@alsa-project.org>; Mon, 06 Apr 2020 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yBMpefkFr1boXNr9NGfUCytWABQV5PpSdvJ9e1eZ9Es=;
 b=wO66w7RyXF4K79Hct6soT9mBO2A8VgpslZPCNtSOASF4tgb5aSbemRnFSHrPBNtZH0
 X7kiY3BF+T8eEQg3G1owaaFUS89tcAVWsufnUv704A2GnEcoxbPBUXVxHt3AIAwk5FW7
 KA6YlhRkOY/O7suBv7qyX3A3aJOOxFJJKowRGPOgszktlhuOro4lqCMRXsEjE7kZbzjk
 UZskTmfltFZSiiVEFR+pwxPWnQZkWtkJRWMNlugPcc6txm6wT4iWU0LV7PlV303bvnVS
 Fc59hfayfoTsoriHy9MxY7sKkWIfP0Q85re+gl9mwl1/L/Pj/waCdYv1qaonpjXqnjmt
 NPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yBMpefkFr1boXNr9NGfUCytWABQV5PpSdvJ9e1eZ9Es=;
 b=ibMjJ/apz31He+eG8Xd6C/9CquRdFqQpG9HxbezdKs7d6AaGe2hBJXPPbpQVmp+5RT
 aQ+3VDBRqNKgAKj3/sYdsC0tSXK+LaV/GgNC1wMgU3lrZuoOiKXjGXPO0V5Yk0QOQj9D
 CGHxXnyDLTWpwQsyy04qDOHV/E9+m4nCnKFPm5lKAm043TR5V/krObX7OwAwip+S54cz
 1uEQsuEwe3yKwt2ti5mVFQuW8d9HdPBee2Luwr4s10YYFA65iXOkFDY8sK7CSjSJwBt2
 /Zs3ymFMaLRa2cKgRD6tM+rGuG9/99jAC5P4UzpBL/yoTG93Kclbyq/VOnAKqSo5dfX6
 qlRg==
X-Gm-Message-State: AGi0PubdiRLRDmD33Gsk/ycmmXJL2GH52Zu60QYp9otW1QdHqX44bUaz
 R/P43zk2TTelf3nCVnaV7veWTw==
X-Google-Smtp-Source: APiQypJEfqE9YynsnHLF5iY81bQ0/H/YvnAi1Gb5Nx3OD9l/PmtqHoG2OXq3p49sFP7rni3/OH53mA==
X-Received: by 2002:a92:5b51:: with SMTP id p78mr592016ilb.250.1586196546082; 
 Mon, 06 Apr 2020 11:09:06 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270::8798])
 by smtp.gmail.com with ESMTPSA id v24sm5206313iob.0.2020.04.06.11.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 11:09:05 -0700 (PDT)
Date: Mon, 6 Apr 2020 12:09:03 -0600
From: Ross Zwisler <zwisler@google.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: haswell: Power transition refactor
Message-ID: <20200406180903.GA109941@google.com>
References: <20200330194520.13253-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330194520.13253-1-cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
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

On Mon, Mar 30, 2020 at 09:45:20PM +0200, Cezary Rojewski wrote:
> Update D0 <-> D3 sequence to correctly transition hardware and DSP core
> from and to D3. On top of that, set SHIM registers to their recommended
> defaults during D0 and D3 proceduces as HW does not reset registers for
> us.
> 
> Connected to:
> [alsa-devel][BUG] bdw-rt5650 DSP boot timeout
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/153098.html
> 
> Github issue ticket reference:
> https://github.com/thesofproject/linux/pull/1842
> 
> Tested on:
> - BDW-Y RVP with rt286
> - SAMUS with rt5677
> 
> Proposed solution (both in July 2019 and on github):
> 'Revert "ASoC: Intel: Work around to fix HW d3 potential crash issue"'
> is NAKed as it only covers the problem up and actually brings back the
> undefined behavior: some registers (e.g.: APLLSE) are describing LPT
> offsets rather than WPT ones. In consequence, during power-transitions
> driver issues incorrect writes and leaves the regs of interest alone.
> 
> Existing patch - the non-revert - does not resolve the HW D3 issue at
> all as it ignores the recommended sequence and does not initialize
> hardware registers as expected. And thus, leaving things as are is also
> unacceptable.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Tested-by: Ross Zwisler <zwisler@google.com>
