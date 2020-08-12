Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96922C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 04:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2CC20768
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 04:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rn33R5Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2CC20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A4A01665;
	Wed, 12 Aug 2020 06:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A4A01665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597204892;
	bh=yXNs8VNA9uBE3jj70UrlcVw6fiX/dSyYxmk0s3FYysA=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rn33R5DpWYZTB1m28wbqjhXppArn7DlXoYTp0A8XEKK66o7f06fn6NkTLuMzOlhfi
	 NLx3ycX0SPblziBsnBGJxrYX52XczAupxeReumshzDZ2oKpg+YTt4fgIB1znlnG/AH
	 AZp+XrqfW1cDJAnlnGQLvDt+1khtrcA2tNBBUy1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47DE3F8022D;
	Wed, 12 Aug 2020 06:00:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1248DF80245; Wed, 12 Aug 2020 06:00:41 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02FD7F801DB
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 06:00:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02FD7F801DB
Received: from mail-pf1-f197.google.com ([209.85.210.197])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1k5hwB-0006yO-Dl
 for alsa-devel@alsa-project.org; Wed, 12 Aug 2020 04:00:27 +0000
Received: by mail-pf1-f197.google.com with SMTP id e30so856318pfj.0
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 21:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KpQMClX0m0IvhtHYcrsDtlKBf40K7zJ3etomTW9/OoQ=;
 b=eXOHsnPllmkoJUb3oghV5w8x13CG1zIwcsrVQFD5q/8yP7MYquTHUP9w8K7eDNOvny
 /wRnrJgwPyfQ0hK3P9Jq3MredOIR4r6WEo7AiaY1vgYeo4bTbdFbtG3imRAm7fjM7TyC
 2OZBTkuwtYK+fB2n22MJBgLf0bHf23q7FKRy1lMhAYJQXGElvIgbvSI9r1Sg8eAsiXLe
 tLeC0Q0X7xQuf/CtsVYCcPffjbGswoI+26K66BHngT7hwnPMgkHlO3QTTWE3G/syUoP/
 LcG4zhfomyQG53ZHVMABpSNoS1x/t1UxnbJIpsswSKGy5mzPTPNBGxVU6ugz6dj08LMu
 mVpg==
X-Gm-Message-State: AOAM530ZEobYTarSS3HwHWpovE9cNSsAgplcVf2mfUsBifIVsaSCizgA
 9d9hZ8bEV3wZLQllxXVzmEgvwP5YReqUfpjjgexqKzn+ElyP+DBggM9numNxFP8gPj6w1+GqIUZ
 uS8btPUqGqyJKS5m3NWbK35MhFu4pNs3/pH3RVqL8
X-Received: by 2002:a17:90b:138a:: with SMTP id
 hr10mr4092349pjb.161.1597204825994; 
 Tue, 11 Aug 2020 21:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykse1r526gUQQqLbNz5OMhbZPtsbLpwy4J+UPa0mlnYR8aByJSoCtZul478Oo5SL0TQZ2tew==
X-Received: by 2002:a17:90b:138a:: with SMTP id
 hr10mr4092319pjb.161.1597204825544; 
 Tue, 11 Aug 2020 21:00:25 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id y19sm609691pfn.77.2020.08.11.21.00.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 21:00:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] conf: USB-Audio: Disable IEC958 on Lenovo ThinkStation
 P620
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5h5z9p2zz2.wl-tiwai@suse.de>
Date: Wed, 12 Aug 2020 12:00:22 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C17B75FA-61F1-4646-8C24-249170FF3829@canonical.com>
References: <20200803155745.18082-1-kai.heng.feng@canonical.com>
 <7626CA68-F198-4654-BEDE-59E4DB0D9B48@canonical.com>
 <s5h5z9p2zz2.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>
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

Hi,

> On Aug 11, 2020, at 19:17, Takashi Iwai <tiwai@suse.de> wrote:
>=20
> On Tue, 11 Aug 2020 12:00:54 +0200,
> Kai-Heng Feng wrote:
>>=20
>> Hi,
>>=20
>>> On Aug 3, 2020, at 23:57, Kai-Heng Feng =
<kai.heng.feng@canonical.com> wrote:
>>>=20
>>> Both USB audio cards on Lenovo ThinkStation P620 don't support =
IEC958,
>>> so disable IEC958 accordingly.
>>>=20
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>=20
>> Should I use GitHub instead of mailing list for any future alia-lib =
patch?
>=20
> Sorry, I overlooked this since I wasn't on Cc.
> Applied now.  Thanks.

Thanks.

Is mailing list or GitHub preferred way?

Kai-Heng

>=20
>=20
> Takashi

