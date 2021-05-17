Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5A261019
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5A261019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E642916B6;
	Tue, 18 May 2021 10:02:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E642916B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621324971;
	bh=VUHpYMP116jCE7pNPwTFum59IwpmxJirVhg2R2m7eRY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kkcahudiFc9jP3ilwLYaCnN5T8Mv1Q2InTn33pHZgNPUotivmWN+OTuaTjxXu9T9P
	 B6s84hw5qK44hRpw0ZT4WctExTWXoqfxF+/pJl5ToWTqwXQTKqeIkFhoXqDIqmriHY
	 W9pgh/mF3EVOWrKeUzn8f2UvWMc7/mLfDBS+w3qg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AED46F8049C;
	Tue, 18 May 2021 10:00:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FF71F8020B; Mon, 17 May 2021 17:04:15 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC17AF80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 17:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC17AF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cRwEzDxE"
Received: by mail-pj1-x1033.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so3871811pjv.1
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oPM3XY2HTvioHScLM83R+NuErUnzIub8aG9A2jzUcaw=;
 b=cRwEzDxEYyQdlyniQ7SLQRhkMJRv0XGRSAnkEI4uJMfGLaxJd/XOzU3lpDwdPqY4eP
 XK0iu0o2UGnpBTyAtNcPXMXanc96XMgmkYor2KhB3I2V+RsjtuFB4vgqKYOwt+FY0qKt
 6j+1jUMZz9k29/ajEKvNyP3FeciTcmdnUQgmajOOMVpYPIDPPte0t1793KzUsQPxYcXh
 9A+SOUsyefHZ6IIZBqmGoOZIuqWwa8f15/CDq+raU3hV2SJu1IUJ0cn3aIpT4WWd5vkk
 CCHqkSs7S78RwNJelSuJxLih/wple+pR8D+DWO6MAhtgy9RngWki+JJnldqiQWtUtHfN
 rKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oPM3XY2HTvioHScLM83R+NuErUnzIub8aG9A2jzUcaw=;
 b=pmO/+tq287zrVGznxVIkm7Yhq0WjvjW/8rraU4B0PrUJFM7Dc4K9j8jtBVfN1cqqzc
 CDHs0JGHpm2iKVzNb2TNLrXiDEs1MykBqsUjz08/G8qmeniqmbKo+V5EciYkK+yPmQ2f
 bKks20D/PGHk7ArMaHklS/yUm7aIoG7VbIx5aScJP2T0KjN7usWYTK0vizrSkor0GXIC
 or6imFZx/LDpvYPzrt7W7EaIxzymqVKIS2v0Y8AESCz2DCjVRNIkBJLgWdbjEsRjZtls
 ru6e38rfSBh4RNGFY9y9a6A7dh0PevbiMVhJRV1elMuTk5qto8v5g2HpKriEjBNYYF32
 LcNw==
X-Gm-Message-State: AOAM531vN7VNtBGiAcf5ai5I6ZqdY/1jABCvuNRXQsg+S2J652tAW6sx
 KmiPw3i5lFq3nHhVk4o6PY8=
X-Google-Smtp-Source: ABdhPJxVm5vSooJwq7w/9m+Y/0Y0rnsJEhVpcEEIKgBlCseS+DB1OgkmRyMIGX76EvsxRLIb1Zqa4w==
X-Received: by 2002:a17:90b:1c05:: with SMTP id
 oc5mr393318pjb.38.1621263844018; 
 Mon, 17 May 2021 08:04:04 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
 by smtp.gmail.com with ESMTPSA id g202sm3366101pfb.54.2021.05.17.08.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 08:04:03 -0700 (PDT)
Date: Tue, 18 May 2021 00:03:58 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517150358.GB56459@hyeyoo>
References: <20210517132725.GA50495@hyeyoo> <s5hk0nxo4qr.wl-tiwai@suse.de>
 <20210517144811.GA54892@hyeyoo> <s5ha6oto1bb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6oto1bb.wl-tiwai@suse.de>
X-Mailman-Approved-At: Tue, 18 May 2021 10:00:15 +0200
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, linux-kernel@vger.kernel.org
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

On Mon, May 17, 2021 at 04:57:28PM +0200, Takashi Iwai wrote:
> Yes, there can be likely a few other holes in this driver, but for
> fixing them, we'd need an actual test device.  The initialization
> procedure of this device seems complex (multi-staged) and very
> sensitive.
> Takashi

Yeap, this driver is so complex,
and I agree that we need actual device to test
if we do that big scale of refactoring.

Sadly I don't have one :(

Thanks,
Hyeonggon
