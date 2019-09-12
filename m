Return-Path: <SRS0=b7Q8=XK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B69C4CEC7
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 07:02:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9534B20873
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 07:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X7rAXWbx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="HvgulFvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9534B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E302215F2;
	Sun, 15 Sep 2019 09:01:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E302215F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568530962;
	bh=9Ma8k+5voxn2WN5gfeEHGME1lXSCqN+5FadRKuYNZbw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7rAXWbxesdQEZyO4zXQlAyDdxCERVtQQUNXwnRKO+6RdQR7loUobEKykHEblE9sd
	 LpKB1PtUYB1RiSdYBAOlf89kr2wLjeC8PzaAR5sxrN4T3E/Vti40Gh/JsRjzMnzOM0
	 KAYBjjvsKDGZI8BTWVWS7y4jViY2SrlsnrBelu4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72CC1F80307;
	Sun, 15 Sep 2019 09:01:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3631BF80368; Thu, 12 Sep 2019 17:42:55 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36B78F801ED
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 17:42:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36B78F801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org
 header.b="HvgulFvA"
Received: by mail-ot1-x330.google.com with SMTP id s28so26516655otd.4
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieee.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aYyYN06j3rXubkCSEGXS4HSqULnEV3AcWX1yvL4znAI=;
 b=HvgulFvA5+Wq9RmTyT+JHY6ZYTb3L4ZkFmBpg6p0lfUZ/YJzsqqaFLb5G1wm/IZtJQ
 TSrAAK4AjU/I6wzHjUky03eXtCNh218hyfsox5S3kGsPE8m/WiaTNoPy3xAvTZHf0zeN
 RcDySe1072nsm+JU2iXykU0koRMr6yNKfVW7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aYyYN06j3rXubkCSEGXS4HSqULnEV3AcWX1yvL4znAI=;
 b=dFKNchpilQL7S2AxqQSDq+mpOIg2Yk7M6oJZlD1N4y1LmtiRSpYwA2wcSY25SGQhl9
 z1YDQYQeKKYkrO6dmmycI0BOg3TLJio88EhitlOYi/BwBBX2ZYKzRpteC7FasHKQjm+M
 axe1ZXFsyQaeRdW9Qq3bmg3z1f5oXF3J0lq9CYlqIDvrZPxy8fkl3BiKV/8y52lOeEj8
 YcxfOnNt/7LOyRNeGO1hWFwoczdwDd7OQyjl96CUSSnaoikDLUuozMNdkQCfxDpv+ac8
 pUFK7u1ftwaWaPFmFw9T/6+19Gc7o9isyF8Eya4y08gjy5acCtQKujv0hvs2CaCeZky8
 WSrg==
X-Gm-Message-State: APjAAAUSL1pblA8kSfcBWZXhWTtIDMB248a4+eJ5urwp+F21/520XyCs
 rtLbJE56cwDIIGNyFtcyo3Hcb6CVccI=
X-Google-Smtp-Source: APXvYqwOGd4AyoQ65OC4bzdJDdgattU+zpVH34Cde7CFXhyS3kLok3BTkTnpRTOuTcnQkET/GntBWQ==
X-Received: by 2002:a9d:6218:: with SMTP id g24mr34744026otj.326.1568302969744; 
 Thu, 12 Sep 2019 08:42:49 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com.
 [209.85.167.172])
 by smtp.gmail.com with ESMTPSA id b21sm8772721otl.12.2019.09.12.08.42.48
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 08:42:49 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 7so17507404oip.5
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 08:42:48 -0700 (PDT)
X-Received: by 2002:aca:4e97:: with SMTP id c145mr633958oib.145.1568302968315; 
 Thu, 12 Sep 2019 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164706.gwjbcywbj7emnwvr@localhost>
In-Reply-To: <20190904164706.gwjbcywbj7emnwvr@localhost>
From: xinhui zhou <zxinhui@ieee.org>
Date: Thu, 12 Sep 2019 08:42:37 -0700
X-Gmail-Original-Message-ID: <CABsjGHJFZD6r7tUKDd17NrAs56O0hypW6MFzJq6m6bWH7ykkPg@mail.gmail.com>
Message-ID: <CABsjGHJFZD6r7tUKDd17NrAs56O0hypW6MFzJq6m6bWH7ykkPg@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Sun, 15 Sep 2019 09:01:49 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-user@lists.sourceforge.net
Subject: [alsa-devel] How to check ALSA version in Linux kernel
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

>
> Dear all,
>

      I am involved in a project which will use different kernel versions
along the way, first 4.14, 4.19, 5.3 etc.

    How can I know the differences in ALSA, besides comparing files ?
How to get the ALSA version in Linux kernel ?

  Thanks a lot,

Xinhui,
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
