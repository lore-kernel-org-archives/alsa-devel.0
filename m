Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D846C433E7
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:19:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EB320C56
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P2wR/ca4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/51J3vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EB320C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AD1617AF;
	Tue,  1 Sep 2020 12:18:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AD1617AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598955556;
	bh=vTgWVCfmD2ZFmUsGbcmjOpx9gO63OLfuS/6GjWgQa9A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2wR/ca4wSopi3mMl142/cNADJlem5IxaLIq3Cut5leOEN5aQQza4FbVpPHMleyA9
	 ER8QfqMIk+s+SxBUvbIioIlTuVLFPyV886GzXgbdZTgDuG0Q6Yf9PFFby40S4oEwGy
	 QLOqPyo97T4gsoyMcyadAc6NI6VcthlIpGx2DgEk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3F3BF802E0;
	Tue,  1 Sep 2020 12:15:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4439F80096; Mon, 31 Aug 2020 20:20:44 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D79B4F80096
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 20:20:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D79B4F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Z/51J3vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598898037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTgWVCfmD2ZFmUsGbcmjOpx9gO63OLfuS/6GjWgQa9A=;
 b=Z/51J3vl7Xk42MplChspxcGBOUNVgLuTcadec6nuomihB7sKmLjAQHRLXMUdNdA2gLe1c5
 UybS+h0WosrAiUztFjUsPcbEYXIB1Fj9GIhcG46ol+U3nOYnZggGr3SMb0OVPVlNX3mr3B
 eFCsIB46KG7B4gpSH22HzaWEgu4GqW8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-IMC8-_ADOd-k26wbj57-ew-1; Mon, 31 Aug 2020 14:20:34 -0400
X-MC-Unique: IMC8-_ADOd-k26wbj57-ew-1
Received: by mail-io1-f70.google.com with SMTP id v10so4681444iot.6
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 11:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vTgWVCfmD2ZFmUsGbcmjOpx9gO63OLfuS/6GjWgQa9A=;
 b=EEF0q6cyz4qW+8gopZvpvdjBCw3K7TuXszpq9ON+LJagE0OA24Xt7TuUa/QIIsONhO
 lTTV68wU+RJo7883xMuCAfdgUiep8fdmbfoHl0J0KS61WdiaPecDmOJY2/XfXo71S5rt
 nq7+K+V5AuwC1VGSDBbSzj4FpSLJmZv4544sP7oC8aAvd/i7PCRH5YiUdf3RCRRGkzw8
 gu+rDC1Y6yELbER4YGK7d8klUJ4oWvk6JTcUY2eSLbpwux68YZxoFfFtPehPHhacGf6e
 NObMf1R15Zl1WuEYwhfpZG+YWbTMf76wu81et9PRV2ZBvnWIlKGLH4h5siCx2Y1Dyvmy
 eoWA==
X-Gm-Message-State: AOAM532pp/AtuIVgRF0GtpT333BbQb692ZNSDj98k9cXh9KwcL8SVXcS
 8C7Z4kDHiA338v2Zz0ta76lbjCRlKxntZ07MrdBu/4U6O3OuQqlGZvuc0rdffjqv0MSJRrjbmKe
 NFxWMtc2tge5573KZsUrdLHE=
X-Received: by 2002:a5e:c305:: with SMTP id a5mr2368712iok.142.1598898034211; 
 Mon, 31 Aug 2020 11:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLriSxML/IerKOXIK8xnZB+A7cvbKwq6xgY3i4W7WSOXvQE3qytcTFpIpivB6aS71HlTgt6Q==
X-Received: by 2002:a5e:c305:: with SMTP id a5mr2368679iok.142.1598898033818; 
 Mon, 31 Aug 2020 11:20:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id i14sm4939106ilb.28.2020.08.31.11.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:20:33 -0700 (PDT)
Subject: Re: [PATCH] soundwire: fix error handling
To: Nick Desaulniers <ndesaulniers@google.com>
References: <20200829153515.3840-1-trix@redhat.com>
 <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
 <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
Date: Mon, 31 Aug 2020 11:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Tue, 01 Sep 2020 12:15:51 +0200
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Vinod Koul <vkoul@kernel.org>, shreyas.nc@intel.com,
 Nathan Chancellor <natechancellor@gmail.com>, yung-chuan.liao@linux.intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>
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


On 8/31/20 10:48 AM, Nick Desaulniers wrote:
> On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> clang static analysis flags this problem
> Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
> CC our mailing list; clang-built-linux@googlegroups.com.

gcc is still doing the building, so it this appropriate ?

Asking because i have been sed-ing clang-build-linux out.

Tom

