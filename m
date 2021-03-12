Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683DC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:52:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5127064F33
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5127064F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A82A179A;
	Mon, 15 Mar 2021 17:51:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A82A179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615827161;
	bh=qeyw3/7nwxUcXOj2n7GM9vDDZgmq2o+bigL2dqUnDso=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CIwiSx9rd993uDrmg8GNZXT4EyPqv0T22XVNcqyGLN12YjdZ/ro16NfUbDrCMRHFS
	 EEZnl4/KyRvKAZLUgtmvcU47TFaU44ge4ii8UWINcROVGD/2pvOO2mvlFk4EC1Emgl
	 6ti0HZmXEq1r53KdtpArhZG3UFrD0LbJKFurWRtQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAE58F80163;
	Mon, 15 Mar 2021 17:51:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A1AEF801D8; Fri, 12 Mar 2021 20:55:36 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EF7EF800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 20:55:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EF7EF800BF
Received: from mail-wr1-f72.google.com ([209.85.221.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lKnsg-0005fB-0w
 for alsa-devel@alsa-project.org; Fri, 12 Mar 2021 19:55:30 +0000
Received: by mail-wr1-f72.google.com with SMTP id l10so11633773wry.16
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 11:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ef0/cxh++6bmrkpsWA/Gvozz9orBLts8hIN80rz0i1Q=;
 b=Bfc/05NhdYP/1q9oeGG++OOwfUNpDhGyTgOLZ8RZXNjHkLaNpGCKg2d1oib4on2sol
 Yaafi4WLSqRZ1SUK3oeTA4IZu5u62kI6jY4deGyt5hOlH8bc98iTIXUJU2d6Qgao9Moq
 eBIbw6gT7PjohE26fxs9vtaZAuZwJjwj0WaeoYtPY2LPqKf1Svlosz7KSm/MiGm+zrj7
 gqO2uU2Szm2YqhUpxm2kbRF57wanXD2ceYM+59T8v59mNQWm0Ywne/4s5wHLFcS2Om2b
 g5VYbF5OCZK8Zp1+2NCot+R7J2QTcM4uab3cz/AM1TTqf/EiETrcmnw4LamOQo+V318I
 v5RQ==
X-Gm-Message-State: AOAM531Gfyjd7BLCrERqb1ffYGTsg9lojTqnP9ue0Zdw+vEA1js4CuvE
 dX9Gb3hvy0/YbOslevZHlOvaJ3cSuvRWAvQn5fOGS6yg5VZgnY9jU+NsvwRvb6NJvU6x5Gcl7zj
 DtUk/S26WxIyuOliIaIC0i3G/jLNkAvHZ0GAN6s2T
X-Received: by 2002:a5d:4587:: with SMTP id p7mr15677624wrq.205.1615578929757; 
 Fri, 12 Mar 2021 11:55:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh14UskDRLnjzcAq+59VeHiQ9wuARQpPv+fwbL+V2IPHLAmno2N/21mgbrVOGVoCQB46dJkg==
X-Received: by 2002:a5d:4587:: with SMTP id p7mr15677616wrq.205.1615578929591; 
 Fri, 12 Mar 2021 11:55:29 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch.
 [84.226.167.205])
 by smtp.gmail.com with ESMTPSA id c18sm20951131wmk.0.2021.03.12.11.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 11:55:29 -0800 (PST)
Subject: Re: [PATCH v4 2/2] ASoC: samsung: tm2_wm5110: remove shadowed variable
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20210312180231.2741-1-pierre-louis.bossart@linux.intel.com>
 <20210312180231.2741-3-pierre-louis.bossart@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <95691fe0-6a0d-1bd4-ba51-bd41f78296c6@canonical.com>
Date: Fri, 12 Mar 2021 20:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312180231.2741-3-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Mar 2021 17:51:49 +0100
Cc: tiwai@suse.de, broonie@kernel.org
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

On 12/03/2021 19:02, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/samsung/tm2_wm5110.c:552:26: style: Local variable 'args'
> shadows outer variable [shadowVariable]
>   struct of_phandle_args args;
>                          ^
> sound/soc/samsung/tm2_wm5110.c:504:25: note: Shadowed declaration
>  struct of_phandle_args args;
>                         ^
> sound/soc/samsung/tm2_wm5110.c:552:26: note: Shadow variable
>   struct of_phandle_args args;
>                          ^
> Move the top-level variable to the lower scope where it's needed.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/samsung/tm2_wm5110.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks!
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
