Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484ADC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 10:00:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9E60FDA
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 10:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3F9E60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8416786E;
	Mon,  9 Aug 2021 11:59:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8416786E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628503228;
	bh=pYcP9IyXdsw0hL6UoqPYsh3SRjuQaDIJ69cEUQIGfS8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC6iUUzUFOUBX+c91ADAI+00i/1Hr5HCeRDq+TH1Nmfx29Y8XMCLRYyboL6BDNxgp
	 WGdfZUTTMOfMPCe0vaABqypKB1d+rVW1hom6zU8iZEHSeMc/svHPU+RhkMQUB7PpQX
	 ugs260Uohrbk4PR1kefoosMVu9wBGHIkJuu47lT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EB64F80105;
	Mon,  9 Aug 2021 11:59:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2ABC7F802D2; Mon,  9 Aug 2021 11:59:37 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACE1FF800CB
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 11:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACE1FF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="BajKFyDE"
Received: by mail-pl1-x631.google.com with SMTP id j3so15786627plx.4
 for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2021 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UEthI4y8SzpPPT/QDt/FNHB8N2/oOfVY8tYPP7sejoA=;
 b=BajKFyDEs4rOg4VCjp3A4HM0FYWd/xbV6TGuhpHpJkH1VXmiTX5pVz0Gj8tVgOoMja
 bQ/O/D2K4IT5i4m6MqwTREKyvr2oAKrckJXc3mprE3cibBoZEG4/O9xhKgfD2dphKnrn
 y6MGQRws/jop68ZPdQCbU5lgQ6QaFjhhflyB4BVLyhI/1PhhUGnNRioWtdJ3uIw42vtE
 yDzW12M1b6ojP1pwrEAB/EPuW+WQ+3kGo7hykhYDmZmS5m+AsyHjY0q1lU7iQaM9HzmY
 VqxWQOMWtLImMVeLosbjErZCTuTtqNSt6flBex958mxF/7bXfZ6//ewIyKdWKgPC4WPE
 Tv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UEthI4y8SzpPPT/QDt/FNHB8N2/oOfVY8tYPP7sejoA=;
 b=Dau5dihY5IVq8NpOnYim0Clwsfd91fDz1ZEwx8TntwelSsNlJrqS11XRil3816qYvG
 tHbPC7o76hI+9pfwdSbPt5/dYpMI5JcmV9MqrMmNHSUxjDKKGOMenNPa6V8bI3F27cQ3
 +z0xRpMY02eUyVmyZT1qOSli1Sim8dgSvyjPgEPE/iAg8WpJhQ7x2FMaNVmSdvQH3c+K
 apCl7YmL6sTqcjuO7zZx1IUP5flcx/4uY5/qDeOU20GyujYuUzLY+sZf6ScrSJhb8YBE
 HCKP8DMF3tdv4+uPr0k1r144o2Nz4YDPaz9NxGuGW/esKPV3x4FlLuy/Llw4bZjtkN+7
 74TA==
X-Gm-Message-State: AOAM533+NzGyqlDewzszodT1ljhP3BZlPVt9GJUuA2BWr1sDs+K/hGHx
 WUICnhyfdwu/TfchtB6hBz9zFw==
X-Google-Smtp-Source: ABdhPJxjBlD/4q+g/MQvPpjDMP0vICOuXb7X0JQvhqetunLKyo9/l2tqPo6oUPeVXj2NDu41YmG+mA==
X-Received: by 2002:a17:90a:6e41:: with SMTP id
 s1mr35374393pjm.109.1628503166073; 
 Mon, 09 Aug 2021 02:59:26 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:c3c8:12ee:bb2:8b9d])
 by smtp.gmail.com with ESMTPSA id v63sm20907646pgv.59.2021.08.09.02.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:59:25 -0700 (PDT)
Date: Mon, 9 Aug 2021 17:59:22 +0800
From: Tzung-Bi Shih <tzungbi@google.com>
To: Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015p: add new acpi id and comapatible id
Message-ID: <YRD8evJHz0ZVDifo@google.com>
References: <20210317062309.14051-1-jack.yu@realtek.com>
 <423b6c6b835e431da2f196036ac2ab4f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423b6c6b835e431da2f196036ac2ab4f@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, =?utf-8?B?6Zmz5pi25b+X?= <kenny_chen@realtek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

On Mon, Aug 09, 2021 at 08:52:49AM +0000, Jack Yu wrote:
> Could you help to review below patch? 
> https://patchwork.kernel.org/project/alsa-devel/patch/20210317062309.14051-1-jack.yu@realtek.com/
The patch has been few months ago.  You should just resend the patch.
