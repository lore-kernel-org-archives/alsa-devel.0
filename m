Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315E6CD5BC9
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 09:07:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B761601E2;
	Mon, 25 May 2026 11:07:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B761601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779700064;
	bh=J++FtPY4eIlPHScS+iuo04i9QahISmodTrX9YmBF3kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZuZX0BKZd1mpXE82UgkpHaQBO+QVFmsgT18+x4H5GpDhDI6LJncsE5gkKyxNvRFks
	 4jecuWYnasfPb+6t4d/poctsNpYxzaDuO7bY2naI4d2vMqLFJqRVJjpoOvJm0dewTj
	 x6z3aS/c1keX9P3TEZeh72/9gwEN+dmN2gAyGPEY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3C35F805EF; Mon, 25 May 2026 11:07:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22911F805F3;
	Mon, 25 May 2026 11:07:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB9F3F80557; Mon, 25 May 2026 11:07:02 +0200 (CEST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0DA78F8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 11:07:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DA78F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bUhnpkwf
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7de7c57b52cso8280626a34.3
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779700019; x=1780304819;
 darn=alsa-project.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QnsxPNfa/QU/x2TfZYW3mTlWPPyQH2Ds56kZ7L8H+k=;
        b=bUhnpkwfUfhdi4syJ9twjcXJ9RpLmG3nWztxNqSABfk9+/fS7KcgqsbNC2hG/ECFcd
         hGWvBdHb/Nx8MIfbxLXyYdV4S+HyPopEqVNeNUtN0Ci4LuSSHXW1eGCJwvjoCmcG+26E
         EvnB18SSz8rDxZklgZVeFvLbxdGj/8suACBwZ0Q1WxTSHTkiUn70Lq21KMlPigNeYekI
         yQHJPKacR4rVVMq2DK1Yx+V4+XxY7wlpWBmOl/v/u8sw/S1dmA7nXObXqBqaVvErL1wc
         rr4K0PR5YlIcO6mS5SxvcT5FWb8Bk44p2JGDdcf6f3LWQ3JFfquY0/xXYcJlRRmWuZoR
         R56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700019; x=1780304819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QnsxPNfa/QU/x2TfZYW3mTlWPPyQH2Ds56kZ7L8H+k=;
        b=ESllb594uooxTCmVKnShIL4At1cwX4MuL0km139b6Id708uBtr62oURPDJAv/hcdPZ
         /dx4gZg0LQgn9jf169FYlBhJmOnMz+pKq0T/mI1DH1sjXgBgYXOBq663TZnCRAfhu+sF
         wsRs8xrBBM2u6nF+JliFuH8RpFAnG/f4PHgCBc8G1gNpbfFq4X3ftzm2cQE+6G6/qabF
         brfietbBEJ95PakRy4YvBl5J983lOSp+RmA8Rfjykbrua27TV+VTIRgCDJMkkKBlqRzZ
         xeyCZFL5hjJFizuMsklz0lxAe3g+RRJGPJIOf9zYwrK+W2VA4qoGpN2Lr8ZodVsbvDaM
         5aqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E7wN11RkzoxrGBU9khA0vU9RPRG9Q4w1YZMQE7y/qetHPDjv9+jgd8g76ki/Vdltq6a4ETdiEHYQi@alsa-project.org
X-Gm-Message-State: AOJu0YxBpDYJNeMc0FkrAixfTJMJN/CUFEshblVO676jiM8in8rnCVFa
	YGM/8QmtkSMqID1Mi/Mj2E7XmQYSp8ZIzHkWu1RUHkQ6mfCnCPmuMDhl7VnZPA==
X-Gm-Gg: Acq92OGHu37weIEObqB0bu6zQ2PpBPxsIRyHxBGD8gjk5jGGT1fgio/U9euWmVkp6eW
	U+0SakjOMbWF0kfTYCIAPJbCquQBPgEWUqTbygvBi1LRsQI/xgo9dTbkbAGY5E9jKB/6vpbSPuN
	xMVnN1Qg6I0a4eUl4+fNWNz3wnQwfDp3lbwL0RQIQHDJ7AMtm2yNLbNXLShC/Ucz6FkZDNlkMJC
	mko9edL9d2D4NHfXN16GbU6qEGc9N4xbEUpZv0au1tPzur6XCo61ktr8XfwSlpcEvSvDAn0YP1s
	9nVmsUb1P3LWFCmciL+2RFc8rzjG05GkwbDbWgqYh/K/290o6MI7ODoaH53PvF5asY8MwoClZzc
	p2rwHp2SshjIr8x4/O1AVY3K4SM7E3cwbAOPtOFLenE9mhWhWkFcztFTBKRTgjVjYI/z5uIthhu
	99fqqJXPaUPQ==
X-Received: by 2002:a05:6122:1796:b0:577:48e1:8aff with SMTP id
 71dfb90a1353d-5866347ff35mr5236375e0c.11.1779569916305;
        Sat, 23 May 2026 13:58:36 -0700 (PDT)
Received: from geday ([2804:7f2:800b:15c7::dead:c001])
        by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f2f791d1sm6807030e0c.5.2026.05.23.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 13:58:35 -0700 (PDT)
Date: Sat, 23 May 2026 17:58:29 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: =?utf-8?B?Sm/Do28=?= Miguel <jmiguel.ghp@gmail.com>
Cc: Vijendar.Mukunda@amd.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	=?utf-8?B?Sm/Do28=?= Miguel <joaomiguel.sapientia@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF
Message-ID: <ahIU9X2DizdyQVR8@geday>
References: <20260523163652.18499-1-jmiguel.ghp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523163652.18499-1-jmiguel.ghp@gmail.com>
Message-ID-Hash: 4XX5SUAC7BX74RWS375V6AND3H4EZS6N
X-Message-ID-Hash: 4XX5SUAC7BX74RWS375V6AND3H4EZS6N
X-MailFrom: geraldogabriel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4XX5SUAC7BX74RWS375V6AND3H4EZS6N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi João Miguel,

On Sat, May 23, 2026 at 05:36:52PM +0100, João Miguel wrote:
> From: João Miguel <joaomiguel.sapientia@gmail.com>
> 
> the board's internal DMIC is on the ACP6x and isn't detected without a DMI quirk entry; this adds it.
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

While the patch itself looks OK, you're missing the required
Signed-off-by tag, which should contain your legal name with surname
(I'm assuming Miguel is not your surname, correct me if I'm wrong).

Also, please wrap the commit message at 72 characters. The way it is
now makes a very long line hard to read in standard terminals.

Thank you,
Geraldo Nascimento

> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 7a637d6b5..a93a7fd48 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -794,6 +794,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "M7601RM"),
>  		}
>  	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_BOARD_NAME, "MS-17LN"),
> +		}
> +	},
>  	{}
>  };
>  
> -- 
> 2.54.0
> 
> 
