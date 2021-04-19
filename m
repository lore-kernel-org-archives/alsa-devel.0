Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40279C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 14:13:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1968F611CE
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 14:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968F611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=superlative.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D16CC166B;
	Mon, 19 Apr 2021 16:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D16CC166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618841587;
	bh=f4neuOz53K4Y3pdruLOFNeioNHbd3K7qT6VV3YS9zEk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ISrUPvpmE2jLrnufYcLFLSjF6nNINQRh297Bt4HmywfSBA+18PJYe3ZdGZewp1wFh
	 o08ZhdF4yL036orNf4tQw6yQe5f28iuOtF0W7q7WUysDKc8snTpGvEh5Qy33A5+ALu
	 1hKLO1lJvTSMMVrRo+PtjkUy920YADoviUbuKMsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AEA6F8019B;
	Mon, 19 Apr 2021 16:12:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41B88F80227; Mon, 19 Apr 2021 16:12:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF28CF80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 16:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF28CF80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=superlative.org header.i=@superlative.org
 header.b="b63Wt2cr"
Received: by mail-wm1-x335.google.com with SMTP id
 u5-20020a7bcb050000b029010e9316b9d5so18143942wmj.2
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=superlative.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kVGSHbe4nY4Z9LxuSSyxHo1MV93fozXunfV/SF1iLR4=;
 b=b63Wt2crlLYYlf3CNPMToR6Rit9KRh9KyBnod7oboENcVT9ojMCNWfk5aBUjQ/lgT6
 BMmPfNRChEtIpG9nA8sbgGzxm1upEgZGruq6Mfu+tMzq5LB4dwY2HNQHPeTj4hleWzow
 NZsA/TICwYyKaVA+8IhZ1vhaykA4ykKPLhIcH0ueZtqHEtQHGby4fS0PEIZi3g7H7GmQ
 54Q4xGK3iQScPT22H/6FTSxPNt54WlM21T1zqkc/aeU8GykTYkSaQaElm1l7wkbEy3s0
 7m1bczqS40P+rGSc/TC3bXDhu6OCnHUODWtWT8idIaZ0kvDPRqrfeNkp0olel5DezTvh
 0HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kVGSHbe4nY4Z9LxuSSyxHo1MV93fozXunfV/SF1iLR4=;
 b=gBRCK4qtkPHmvJ3FKb0YmClyrS6DjAhMk5cOR6NC3F4Z3g5C5brueVvLmbZcjlXWaS
 qAESdCjb25sFbbdNPZtb2DCuRysCEn/vRuyRKn0cNcFffhyvAr48cOFRHQYO4WYEKSZp
 CPsZ+E/9XHx478WPY+ITyQiDPTlomD1KB6iEKQWJVG7JwCBPNh4/xOnVihFZOdVZrcjT
 dcQEmPxwVMfoZxRpkWxAz8I6rNNd8CrmbXxzTD/wfAnZRVoCc80lVnEnRdTo4kYTTINa
 W6mDLD59U+I2uWwH0wV7IUpQRuaEwb3hAkch0iWlpHwxKw/M2PEzELDsqdv7lIHvlphy
 eeEQ==
X-Gm-Message-State: AOAM5305fFRy39fUJdddx7rpKU1YcV+qzUGxn4ENZkDlWx6yBGBMbd3u
 Dy5s1A6AnD2pXRyig/0mxNZ26wiN3C5LqPBL
X-Google-Smtp-Source: ABdhPJw73Dbys2Z/vGr+CPoWtzvqxsrX+oJKFQ6CbZwN+3EIyjj7RUED8D4jQBXF8fTmExp7Hg6h/w==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr21385886wmq.128.1618841523115; 
 Mon, 19 Apr 2021 07:12:03 -0700 (PDT)
Received: from kam-desktop.localnet (grenville1.superlative.org.
 [81.187.25.35])
 by smtp.gmail.com with ESMTPSA id x25sm20371435wmj.34.2021.04.19.07.12.02
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Apr 2021 07:12:02 -0700 (PDT)
From: "Keith A. Milner" <maillist@superlative.org>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: Apply implicit feedback mode for BOSS
 devices
Date: Mon, 19 Apr 2021 14:45:51 +0100
Message-ID: <5949663.lOV4Wx5bFT@kam-desktop>
In-Reply-To: <CAHXb3beNczUn-KWfO9P1Pa5+3piR8fDYHvoH5G08GmcvgR4Lxw@mail.gmail.com>
References: <20210414083255.9527-1-tiwai@suse.de>
 <CAHXb3beNczUn-KWfO9P1Pa5+3piR8fDYHvoH5G08GmcvgR4Lxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Wednesday, 14 April 2021 16:08:54 BST Mike Oliphant wrote:
> Thanks for your help with this, Takashi.
> 
> I have tested this patch on BOSS GT-1 and BOSS Katana, so we have a fairly
> high degree of confidence that it will work on the other BOSS devices.
> 
> It may well help with other similar Roland devices. If your device has
> playback working, but with occasional pops/clicks in the audio stream, it
> is worth trying to add the IMPLICIT_FB_BOTH_DEV quirk for the device.
> 

I have confirmed that it works with the GT-1 and Boss Katana as well.

I have also tested with the Boss BR-80 and GT-001 and this still seems to work 
well for me, so no obvious issues have arisen from making this change.

I did also try the Boss JS-8. This works in Ardour, but capture from command 
line using arecord results in a file of silence. I'll do some more digging into 
this one.

Regards,

Keith




