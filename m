Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CCC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EE820756
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WhNaks2T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nO3gYAQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EE820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB9141660;
	Tue, 11 Aug 2020 23:33:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB9141660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597181657;
	bh=B/H2jElaCsUkjXz1c13xD/uBxizSRyrZkJ/CGw0fVRM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhNaks2TYCyi3M+g+VkQv4c9CflQSgxjsVp1zahPEuKYlgffTsBnoFQhCnpbKAXlo
	 7A80y+pQhTeiXe09n0gyeknENw3qzfJ+dYswfB6YdLccc6+HxN/h6pgZq7b8opXP9a
	 Y3s9GOtku7eEJVmFtrX5zTUy0hY1ml0mr3DzC9+w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B544F800D3;
	Tue, 11 Aug 2020 23:33:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCC29F8015B; Tue, 11 Aug 2020 23:33:24 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A11EF800D3
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 23:33:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A11EF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="nO3gYAQ3"
Received: by mail-pl1-x642.google.com with SMTP id y6so151159plt.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1XmU1UxtFoX+JxWRWBVQUmWx0SHpCQU0BLn06Acf+NU=;
 b=nO3gYAQ3UHUw7olEjw932d3zFLqOCCUdnacl9cVKrUgmFx2PGjAFNp8CQwEB7V4Hmy
 FGOy733ZHh3A1xH6oKC3op8DvO/HEaTRYWhxchiQa9h8rnO5vamgJzN81P21hsQ5n8I3
 t7TvIriH92cU2JNs0mnOTN8SDZ89gDDMfKKUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1XmU1UxtFoX+JxWRWBVQUmWx0SHpCQU0BLn06Acf+NU=;
 b=WcHRFXO4LB1wO24+0WQXMCyQrqudhBaQ/iBHCjVNN0HJY6YvjunbIzWjA8g0f+HLOR
 ktM4N8Luppzb9Dexn4WFC/EFs9/wjpQOSK/zcOZtjuytrLf/GVE+nBUCBQI9yAARbV1s
 ixL5pNgCgbIWd+0j7YOxbXSkhKopWZyQT2cgK3C5gk2V+2IW7fnwO2qjhcXpFtDkf9tH
 LIGQgy9HGBIXoIq9LWzo6CxJtdffECZbiSrX+6hqbn47nQAetjALJF6IP58lzF8r19pt
 x9a2yPmKFC5ARza4zGYVv8wWzHhlmXAnxx//l3vkEnoa1Jq0SZWB6HH4rk8tHCjHFSi6
 6LAA==
X-Gm-Message-State: AOAM532GDa8+2hBliM5hrPf+IZklPvTrT8lJaQxiai1dk8Bqrbx9raRy
 /ECDVDVhUnmgu1ous231WCONpVTQAUQ=
X-Google-Smtp-Source: ABdhPJzVUgwczR2LI6waXoChEBBAZmQiyV+rznpXD/j383hrrCcUrIvWs+lVRQIEgQVz81ia6sNYwg==
X-Received: by 2002:a17:90a:ccd:: with SMTP id
 13mr2785480pjt.123.1597181595355; 
 Tue, 11 Aug 2020 14:33:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id k12sm3694242pjp.38.2020.08.11.14.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:33:14 -0700 (PDT)
Date: Tue, 11 Aug 2020 14:33:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen <allen.lkml@gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Message-ID: <202008111427.D00FCCF@keescook>
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de>
 <202007301113.45D24C9D@keescook>
 <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 alsa-devel@alsa-project.org, Oscar Carter <oscar.carter@gmx.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-input@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>, Romain Perier <romain.perier@gmail.com>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 03, 2020 at 02:16:15PM +0530, Allen wrote:
> Here's the series re-based on top of 5.8
> https://github.com/allenpais/tasklets/tree/V3

Great!

> Let me know how you would want these to be reviewed.

Was a Coccinelle script used for any of these conversions? I wonder if
it'd be easier to do a single treewide patch for the more mechanical
changes.

And, actually, I still think the "prepare" patches should just be
collapsed into the actual "covert" patches -- there are only a few.

After those, yeah, I think getting these sent to their respective
maintainers is the next step.

> Also, I was thinking if removing tasklets completely could be a task
> on KSPP wiki. If yes, I did like to take ownership of that task. I have a
> couple of ideas in mind, which could be discussed in a separate email.

Sure! I will add it to the tracker. Here's for the refactoring:
https://github.com/KSPP/linux/issues/30

and here's for the removal:
https://github.com/KSPP/linux/issues/94

if you can added details/examples of how they should be removed, that'd
help other folks too, if they wanted to jump in. :)

-Kees

-- 
Kees Cook
