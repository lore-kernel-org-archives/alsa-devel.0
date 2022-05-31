Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D758C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 31 May 2022 14:38:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE8111FE4;
	Tue, 31 May 2022 16:37:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE8111FE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654007896;
	bh=Ef58uwirqvIT0ENOPdp32sUgNmFBpNX/Hh2p9Kv0ny8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DqgT4sKCyT/EeDeL/gIsxUxJODRl5BqOBUUz6PRNyAKlsQxuO7VfY8RBjecj/e9t6
	 DGeL92teJt0Z8ahCo/OHL5NSkQfiR1jrIET9Heu5hys0Ig+3VSyFHfJaY92s1SGdIB
	 ghED4gCxrKJrVR92rvaLDroDHXuE63tz9whUIV5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 222DAF8012C;
	Tue, 31 May 2022 16:37:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8577FF80161; Tue, 31 May 2022 16:37:23 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92301F8012C
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2022 16:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92301F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iuO3WZay"
Received: by mail-lj1-x229.google.com with SMTP id g12so14815933lja.3
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2022 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=QXYlGIOgKGbFK7tXngN3mPfjcRChmvmkrNZG9U058+w=;
 b=iuO3WZayg+X3qeKsxu0QkN0YTakGB+50KV1wNIuElEa8JEwRn5lZDTrF5kdoiLVucT
 a9NYvbB42xgkz1bdgyQ8ABKxmXAFrF0YA7LzItr8NDS1B38tXumRfy4AUTK1xJs3ygTX
 B7JBTSnSrgTj/zrC7yAuNvXDBmsxhBN8B5hCIsUBoNjcpZ7qGDfh1C7dn/697mtDsy3p
 qMhzuvO2DPrQV+LCbiyurYuAieLezj7Qj0FCpIV5zFcRtDgJpU36G3Ktz7Din6XbP5AF
 QerT2SU+tKid5k2XIL3HIuQqBONIHuApKC9OEOJZNYWuBI8nCcyELSiV03YMvVAKvmFl
 gfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=QXYlGIOgKGbFK7tXngN3mPfjcRChmvmkrNZG9U058+w=;
 b=1SW0wskNtv6QjBH7CE//oKtpEXvj4PfOx0WsxMvyVjUVMQT+n4vHA7uBTsyd0G9Eq5
 H5ZYm0vOnfvUPpHAGgGLBU7qdCdBswaQWVDlC7vw0aO6WTcVAA7wwczywj/M+AqkYP0a
 cvawC4UBInghD0DVLg4AOsVVbaljJsE2M9FEpUSOEUB2Q+Er1V6JR9mQ9aJH0uPl6qlC
 QfKQf3dSKbn901s70C2FtgRpIsjIGEyKJ+ZzmL9qRNI0BrC5nIbcoA26WawRecM+b94d
 89nFgLwTeg9L0N12vAvdryH1ZFVkljF1GWOuzhKGUJN7vh26zSPDkfe8GgoNqlJ99QUR
 sdzg==
X-Gm-Message-State: AOAM531SVqFIGD2+tQONRkVQGleiwjmfwW6K2tMbMIf2DtcEn6USUJaa
 /Mee+r0u5YP4idirdJSF+XHrdtIeFoXmLoM/jbQ=
X-Google-Smtp-Source: ABdhPJx/u1XdrzxOQrAtrRvRSzCd78GASzUH4nfTxLG8kIrLUt3LASlUQ+SIN2VTs+eo0WA3i+n4iOlgrLaGI53i3sg=
X-Received: by 2002:a05:651c:1793:b0:254:1e6a:4ff2 with SMTP id
 bn19-20020a05651c179300b002541e6a4ff2mr16021561ljb.151.1654007838093; Tue, 31
 May 2022 07:37:18 -0700 (PDT)
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 31 May 2022 20:07:06 +0530
Message-ID: <CAHhAz+iuAYpxkpVGWp1g6u_j+wyB+vsFR8FGz1i_8G5TQhOVZw@mail.gmail.com>
Subject: soundwire: user space test utilities
To: vkoul@kernel.org, sanyog.r.kale@intel.com, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel <alsa-devel@alsa-project.org>
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

Hi all,

I am looking for any existing user space test utilities to test
SOUNDWIRE SUBSYSTEM in Linux kernel. Can someone please point me to
this.

-- 
Thanks,
Sekhar
