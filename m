Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD83C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:33:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01F61974
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01F61974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 356041666;
	Tue, 23 Mar 2021 14:32:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 356041666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616506418;
	bh=1I3CTnFOi+1NCeZNfK4tm5u4GLSmtqbmC7Ad69R/OWU=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cibOQ01vxsv05R8n0TyIOy1QTRc4T0DRARmLPlNrv0Gcy1ZYUErw0ZRYYD6wtwoiz
	 9RKgZGYbzC/auX9IHQeOGYZJ0FNb3zEN5UXUbMVLXD2HSqltebYliAn8NMqTjGfQ+V
	 tNtf9p1qnBuRUios42hcJOMNrfa0U/9sMIu2NQ4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FB63F80155;
	Tue, 23 Mar 2021 14:32:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97322F801D5; Mon, 22 Mar 2021 22:53:06 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ACDDF80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 22:53:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ACDDF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NVoqDZgk"
Received: by mail-pg1-x534.google.com with SMTP id v3so9675417pgq.2
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=0TtDxo1BRni+rJ4DxAgWjUJVk3rUTo1CmmSA6j4h/3U=;
 b=NVoqDZgkAzlzIJewApQXY0iv1DPrX9QuzzS1sinhYq7oEJKS8o4YabXo1NfilJ5iNH
 CRkhVF5+Jc+fu9ARoBXKGGPsKDWPNnPEH3JU30zgThNCiyIrPF6vc8aDWbi74UwUweT8
 UM/D6Sew414UQ0bGNLnXQaB4JaPc6XHXHG09QV0VFMnboGS6iQL4ADY0EQN2k7RowJAc
 pjMCrJDC9ndKtER00NYK7zMLZjcYHt94SnAC5dVLvvmDlVxlKsmkVgJegxChOAmqDDRr
 ex7oyaW95VAyXnSr+kj6217tX4cVVEjh9U2ppzO7war4NI/D70VbYrnf1M41mAWehg2x
 WPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0TtDxo1BRni+rJ4DxAgWjUJVk3rUTo1CmmSA6j4h/3U=;
 b=DuDP70qFIxlTRZIy/DmhgYNh2QOtbKKsJ6N4dKUHYi4/OZBUwsBE2eok6u+P0aGyq6
 XuuHSjdGTLU7rKAm7WJGMS+96GjsZP8+TuzKrOxADYtNgPlvmkm20zsjMYR05OLvQleK
 GoeRNKwYe3VCYQKp0wNnqL4bmHEZfMVgAuhOZIXbpQwhdOP9KcXTNOWoGzXWf+IIPbPi
 HTvScE7B8is81Z4Znzm/G64uvdTHAVQJTnMA7DPl/Q4d3V7JHHMSmmGqFDaVvi6MqdEc
 uH2VqbdhOxqgUULBFiTholxIVK6JRVmWIhC39KANk5yKRrxzIq+2PNEGHJszCWFvU74O
 C18A==
X-Gm-Message-State: AOAM530AQSVbqjyZYlRjiRCjqZi3SodKWY+ezNvLfG/5tjWb2wlN7TyN
 mphz4N5CQEdxPIEtJMtbfLRWJu8zg41UkMwQOkR9bcpNUts=
X-Google-Smtp-Source: ABdhPJxbS//+hnajOdI7E+ZvrzuHyn0U0K1e469fXCNR/NXjpEVplh0JIZDDAe6YCgQZ5cSFbq2C/TYqQ8kiKR0FG/k=
X-Received: by 2002:a17:902:59ce:b029:e6:bc94:3668 with SMTP id
 d14-20020a17090259ceb02900e6bc943668mr1572118plj.0.1616449979988; Mon, 22 Mar
 2021 14:52:59 -0700 (PDT)
MIME-Version: 1.0
From: Maciej Matuszczyk <maccraft123mc@gmail.com>
Date: Mon, 22 Mar 2021 22:52:24 +0100
Message-ID: <CAO_MupLikHWAAEU6Q+kbGXcfDoks5MxrRrD0cxWKaY_FdcvhPQ@mail.gmail.com>
Subject: Re: Re: [PATCH v5 2/4] ASoC: Add Rockchip rk817 audio CODEC support
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Tue, 23 Mar 2021 14:32:46 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

Thanks!
It works fine on my Odroid GO-Super and Odroid GO-Advance

Tested-By: Maciej Matuszczyk <maccraft123mc@gmail.com>
