Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB1C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:57:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B743C20838
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GDH5QAbN";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzSgtdxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B743C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B091657;
	Fri, 14 Aug 2020 04:56:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B091657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597373857;
	bh=TBbIGrNBQ358cj5kGNLSfjMeFd6mET26IzpK9mGNlVg=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GDH5QAbNWY7JjuYZWMdx9V5Th64UnLUE9uLJ3Xtbk6t1ysi6CV+j220cQxqMpqH4/
	 YBSrwYWDJ8j+s4d7/3HC9eOH98hff7RjZHhyhzUVI0OoHb6lQrhIPSXopdZKsDxBJr
	 zHsGJDrnelfw3S3tHePtih8Mn0nKo0QO5B4Zxwtw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3E8DF801DB;
	Fri, 14 Aug 2020 04:56:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB097F8022B; Fri, 14 Aug 2020 04:55:12 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17AD3F800D3
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 04:55:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17AD3F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BzSgtdxH"
Received: by mail-qt1-x82d.google.com with SMTP id h21so6018556qtp.11
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=eFaJV3Z+9MpYykIQZrmBJukImxnaNxEgk1WsiK8R8xI=;
 b=BzSgtdxHyFu99MdtY+0gy2GAtQAhU8ZYR1l7Yb8xqp/doOOtnFn5T0XWW25q6JMOd5
 k23VcmuXCXhFHtIXbWONg4y0zltAIVtdEcxVjapr/jD7mND7ULMHmzruo3orCTfZuSJf
 JZFDNkj57R7eLIiPv1SNv/F6StwlrUDv3+kH6T207fSYOZuNHvX1Kh02DM1UtNknW8dw
 1p+3kq4vmQIxaer45yfCJKthn8MayoWOVraJwrNwJIPD01qCbXfNcsIeYPpLh9c9T41u
 znazQdOiqYU/gS7C7tfa5f2bizRfO0gcKRQMD81QxlGxD8xomiagmOikY4hSOilFyp2A
 ATfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=eFaJV3Z+9MpYykIQZrmBJukImxnaNxEgk1WsiK8R8xI=;
 b=eegpCUmHSluQDh9rxLd5+p8bcNsAqj2rq1br9FfT0bh11KNL9cfI19soVw3G+eFC8v
 ApWcqyhevVcd7DitoarycvbTrJX44YUOBw/btP7hpmudDNzGtbJtrBLCSq9NctohNiJy
 wdUqw7ifOGYhNEMU5ShSK+YOmW4/aWdqA7XXuXbTVB4l6Wiof2r5rvrWSef/6KIR0S9C
 i2MOMrHaOWmeoywP2Dnmkm75QKvRaSSChITaLVWNCDjijxZ9P+6nDsIST7rbEPUCYDqf
 JETa1dpXZHhqzYp3svIZ37/enXK5HNUI/XoZA8AN9GzficpFssE9Pqk953DcFsblfW46
 W+sA==
X-Gm-Message-State: AOAM533PHMzR/gUSFuIe4pmH8urW7vM6i053bm5PQQRIojiFAdO0W5T4
 +Lq3S6XDxWsq6Kv/+49A8KyW/zaH40ls4xla6Ds4Coxn
X-Google-Smtp-Source: ABdhPJz6sz2LfcVT8kXaSFl4aIM9Dbe1lCsmnk8HVEONMAs2k1Qg+r5f6azPzo5JQXw1STLS5ho7Evy0RF+qNXGbDaE=
X-Received: by 2002:aed:2946:: with SMTP id s64mr318102qtd.204.1597373705138; 
 Thu, 13 Aug 2020 19:55:05 -0700 (PDT)
MIME-Version: 1.0
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 14 Aug 2020 10:54:54 +0800
Message-ID: <CAA+D8APKP9Ci7frPsNjCeF3s+kPm-FU-3-DoU36e4aqBBecKPQ@mail.gmail.com>
Subject: Question about DPCM
To: Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi ALSA-experts

     Can DPCM support such a pipeline?
     FE ->  (FE/BE) ->BE
     which means I want to connect several cpu-dai together:
     CPU-DAI1  -> CPU-DAI2 -> CPU-DAI3 -> CPU-DAI4 -> Codec

     Could you please recommend what I can do?  Thanks for you help!

Best regards
Wang Shengjiu
