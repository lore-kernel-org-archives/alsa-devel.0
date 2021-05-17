Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90523C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EED61019
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EED61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53D6C16AF;
	Tue, 18 May 2021 10:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53D6C16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621324958;
	bh=BX/Io4tTMdO3qzC5T80gF/aBXzbDUFf4X9s+rziw0bQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpXUk4hnFHIS6hAUSjrZ+sevSFydRpKYNkrrpZhQkMRsbc10LvADexO8jWqDMd7Xf
	 v26z6cfyIbSGUwiAdzC2IK1dDRlQR6e7uHB+tL4aLk8SqrP84nT1XfgSRB3kBlvt2V
	 6FCsxPfQtVpqf8oDMAQnK9zoOXquUAL29cAtsxF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6278F80425;
	Tue, 18 May 2021 10:00:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57931F8020B; Mon, 17 May 2021 16:57:09 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE851F80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 16:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE851F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="c8niAl7E"
Received: by mail-pg1-x52b.google.com with SMTP id m190so4836165pga.2
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BX/Io4tTMdO3qzC5T80gF/aBXzbDUFf4X9s+rziw0bQ=;
 b=c8niAl7ESDpAN17CH581ks28MAIDSaNjtsSo4xreYKUbMBHvJAnZ+auCCG4P3zn2b7
 +OmZVqSIcQvgtjppY1gqRAn/5fR5xIjjwruT2AZdaH9PBhdvTrSf1uGDf2mS+mwr1gri
 ZsPYUSuvmAP5N6qlwwJ+5LvrX9N4n/mhMVhhHI7QRasRtl/RXiY75yF8lFMJBO7H5Cno
 WMcz/6z7uxz1oHQDyruaNpO7ddhoRJ4MeYH+z99tlCE30wFVgC+CjaPZPrxO70X2wzWn
 W0Mons+Dz71DTk2M7va++0ejFjHwOLR6/nfqqdKKnHoJiUIS3ZnSxjp2ydeJHb4sitiI
 KxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BX/Io4tTMdO3qzC5T80gF/aBXzbDUFf4X9s+rziw0bQ=;
 b=myiRsDUBwKJFVR4TcgrFVSuYiZfVHww+2ET//fgJUv/eunkmisYpq+ATjocmd37MWb
 4DVALkKX9kViJVncyvs9DqUu5lk2wao7pfd0IfbBCmzDvbAHZeEj/Rwz+/vugNNCkQxO
 kor1UFNkUHse7NeIzB/8D9sDCf25UTHgfiSV7uAk+nQozPUGS6ANiIrOlTTthzKwHcgm
 cLuhRFRvyuh7ExvY7syl+6CEtvnHAsTEwKAGPl8sjn4+pbIz8YuxlLALrvEx4bgD+8EA
 GyqFLtx4MOGT8+IxzIIbocCAAqC6A3S7Oy4tQqix1qk6u/moCr7imhdlXGoflzBqPodL
 Te3w==
X-Gm-Message-State: AOAM5324qC5q73cWYU6GE/yfTuppSmRFpMjaG24/S7BxgInQC6UGDThz
 MwnE/O3DeKPC5JkPqfA2NGI=
X-Google-Smtp-Source: ABdhPJy2+qaj3ctQl2aAncmPDi17/hhtyAc9OskWXvlB/UOcGoL8GAGOid6G3FffLbkTjde1bpQmnA==
X-Received: by 2002:aa7:946b:0:b029:28e:d912:6be7 with SMTP id
 t11-20020aa7946b0000b029028ed9126be7mr115832pfq.26.1621263423822; 
 Mon, 17 May 2021 07:57:03 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
 by smtp.gmail.com with ESMTPSA id l62sm10099265pfl.88.2021.05.17.07.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 07:57:03 -0700 (PDT)
Date: Mon, 17 May 2021 23:56:58 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517145658.GA56459@hyeyoo>
References: <20210517132725.GA50495@hyeyoo>
 <s5hk0nxo4qr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0nxo4qr.wl-tiwai@suse.de>
X-Mailman-Approved-At: Tue, 18 May 2021 10:00:15 +0200
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, 42.hyeyoo@gmail.com,
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

I'm kinda new to linux,
but tell me any time if there's something I can help!

thanks,

Hyeonggon
