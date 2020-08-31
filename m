Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB7C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:20:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BAA206FA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ef4rPHxM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz2GaGLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BAA206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BEB11793;
	Tue,  1 Sep 2020 12:19:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BEB11793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598955598;
	bh=kRQC3sjrgNiSnHg9lz0et4/L8JLjhsBKTjZ3Q1gb2TE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ef4rPHxMaPlm9wdss/ABBEObot4ow7mIWhvOPkYRccN9uCMzznNv6fIAbiezM+X4c
	 SUtPGrPZbGSlQpCA1qCQwZJRs/dqQWpZRFrc1VUKshLRaSybBF4EYTiXI4q1duJZ+R
	 RMRteyTHxjwMn0fBQbNjs794d06Bw2Mp37WjZu/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98359F802E2;
	Tue,  1 Sep 2020 12:15:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59E60F80212; Mon, 31 Aug 2020 20:57:24 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFD52F80058
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 20:57:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFD52F80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Bz2GaGLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598900235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9PG3irLIE6N/QMI1mVLnwUslXXwXq1frH2lpMwMGik=;
 b=Bz2GaGLXnfIpzEs2PwgRNBS7bushw3W7Xbd3gCIdJeQ3l9XokTzVmWjvwfsPtw+sA7zOPe
 5jfpo9xtgnzZBmjxiMgzMr6ajChH9JfQ9hSZoMjJq1suTIyf1I3Si11alwV4bunKmSBjJv
 LxnNaAatKvfYq5AYxZu0FcxF6tY4XnI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-gW8NrqOpOtyWL5-7-fuFgQ-1; Mon, 31 Aug 2020 14:57:10 -0400
X-MC-Unique: gW8NrqOpOtyWL5-7-fuFgQ-1
Received: by mail-il1-f199.google.com with SMTP id a15so4621268ilb.22
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b9PG3irLIE6N/QMI1mVLnwUslXXwXq1frH2lpMwMGik=;
 b=tDAGSMoSH8b5Hk/mKpdkdeiZ36xUpj1mmb4pCqJPY/T8mSKHQHkIrSOfGtq+7k6eci
 cEzxs1qKTZjTvQ0iLqa22bAErxKezUQExp+P5ugtg1/5I5k8kc7NMbxMhLucbSo8nSPt
 qclYElFSUkvPa+g2NYdyzSDhC0uSq5yi53DRYjVB1D2W4dbWm9Uh7Ntxhj/bY7xNdolE
 nh4w4B4/HPt6MnJooZk7wel1y/J6idhUn4CV9uukd2HXHlgtJBq7c68iFs8QT1o8xF/5
 H+Oe9UIFU+4C7Tiov36m58h3ciI//+AmKFIDWj+/L6Hc8k8EPkNrnw0SsVMcG5WpYYDH
 RXtg==
X-Gm-Message-State: AOAM533qukFprMFf+7Fiq8ZczCOdwUu3lgF0zBqDqonaLHM0hbswC+uI
 8dEvnF+0lxx4cfRZw1EDhdR9dDdrqvOMST/a98/4nSSncXTyS5VpDYQna2faf//yL+N4orHmSQW
 LqICWFMMDGabRHRW/FK8JkT4=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr2660996ilq.81.1598900229614; 
 Mon, 31 Aug 2020 11:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6363cf0Fuegrl6FGpQzQ60cX6Kv8aPKaONFfhmnNPoiSsY3mJNJNJkBiSY0Os9JB6vSP3Rw==
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr2660958ilq.81.1598900229155; 
 Mon, 31 Aug 2020 11:57:09 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id i144sm4320996ioa.55.2020.08.31.11.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:57:08 -0700 (PDT)
Subject: Re: [PATCH] soundwire: fix error handling
To: Nick Desaulniers <ndesaulniers@google.com>
References: <20200829153515.3840-1-trix@redhat.com>
 <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
 <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
 <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
 <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <5075093a-0853-8030-1cbd-42a051ca3651@redhat.com>
Date: Mon, 31 Aug 2020 11:57:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
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


On 8/31/20 11:39 AM, Nick Desaulniers wrote:
> On Mon, Aug 31, 2020 at 11:20 AM Tom Rix <trix@redhat.com> wrote:
>>
>> On 8/31/20 10:48 AM, Nick Desaulniers wrote:
>>> On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
>>> <ndesaulniers@google.com> wrote:
>>>> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> clang static analysis flags this problem
>>> Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
>>> CC our mailing list; clang-built-linux@googlegroups.com.
>> gcc is still doing the building, so it this appropriate ?
>>
>> Asking because i have been sed-ing clang-build-linux out.
> ah, right, you can use `--use-cc=clang` for analyses of builds with
> clang.  It doesn't hurt to include our mailing list, since we'd like
> to know if issues get reported with the analyzer itself.

Ok, i'll include it.

The only real issue so far has been https://reviews.llvm.org/D83984

which fixes reporting on a couple of files.

Tom

