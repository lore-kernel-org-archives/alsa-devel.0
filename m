Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3485C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:51:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48032206FB
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f3v9lcKc";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT48sNzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48032206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B75051676;
	Mon, 12 Oct 2020 08:50:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B75051676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602485480;
	bh=OxmErVjrWc+XPOCIcYrMMlJrP10mC3j8Dfk8y7Z6yYM=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f3v9lcKcQamLd6NLw0CTHih1pkDoQhcdxvbHTmFKzngxsc2oRSNSuQQli73CscQMf
	 iY0YEcJ9SEcZIDz2hYVKe2DfwHw8y1MrprtDnhR2CrU7QXvIS+kjwNyxSFwisoigyy
	 QP/k1FqRj6q3WkZ1wBHGnLGdlPnT6hm0H5pNnUkE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C0EBF8021D;
	Mon, 12 Oct 2020 08:49:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD21AF8013C; Sun, 11 Oct 2020 07:06:53 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85D44F8013C
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 07:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85D44F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iT48sNzn"
Received: by mail-il1-x135.google.com with SMTP id t18so12896281ilo.12
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2020 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=OxmErVjrWc+XPOCIcYrMMlJrP10mC3j8Dfk8y7Z6yYM=;
 b=iT48sNznvbfZdn0FKIrRfxk9PGilR5vId/Nmjm4ogQJ/vBFGQA23W7mXdlk77V+FGS
 xJMqSttfly6WL+GDlZrgISQqnuU7PU0Lk7x1b4bTvtN5jmrrdwyhTR6wqkd5tuBcXHrC
 TUX1ICXiz7O01xaTNsxJgjX64YhgiRMNu/7W3c/CDgMTJ1BRopqHzVo0thHsdHKMQ48n
 Ga40CgaA7B6laUilVw6XwZFvrtRAGd5z3KCusNVzIs6whS3ksKUnHzR2rGqVFIhnOOMz
 DJfIKs26SOJQYjKAcS0luMeWXlWYMWoPwjM+fNVXorndzWGXmGAAquKethxw73Unq/s+
 sMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=OxmErVjrWc+XPOCIcYrMMlJrP10mC3j8Dfk8y7Z6yYM=;
 b=FfhLK4M7+L/8aP1R4xiqJtFQ6zz9d0JwDLufddAfVWMkCz4+Lpg0MRg1sBjH08qwGv
 tWITZlIg34vf+xJzzqftKAKkVBA7hk8U/RUApq3pXzMxDE+6Iw3jrwVTNNoAQlwtKQEW
 g+KlK/YYVqhunH1uE5u7KVOlvP2TAzdaeDmf/vdB6+hQtsxElE7pujkwXDyLSidmW3+s
 m6qzTb3ZJEH/ksOJ1ZNlQD4yk+tSMebmWjUu0J+ClMWzHyk+XezbDnvbB/8r2WWOCVNq
 +jr1q9v0VxT9Z/GNuRy67dzOFcREy8F4Y+fqFDWHgnzVYkzV2LP3BHk4AARNWsgovwk6
 5eSA==
X-Gm-Message-State: AOAM531IagHvFWmr5ekdoptZYy+8tjFvdlO+8i1kRV8xPeoXTGqPI9lY
 OQCExAl+7IiqEaVzljgaaWRe/CFnT7VHvEfm8H/3RlOlSKE=
X-Google-Smtp-Source: ABdhPJwaR6e4BSPtQ+YTLdwHEC0n31Hy21U4L1J4Zz9CV7G6ASaIvkMSqGKHDerIbhPPtUukuBrPElfqJh+ukQhoXAs=
X-Received: by 2002:a92:99cb:: with SMTP id t72mr14785745ilk.172.1602392806516; 
 Sat, 10 Oct 2020 22:06:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:2ba:0:0:0:0 with HTTP; Sat, 10 Oct 2020 22:06:45
 -0700 (PDT)
From: Kevin Maciel <moresuperthansuperman@gmail.com>
Date: Sun, 11 Oct 2020 01:06:45 -0400
Message-ID: <CAC_W3FKYtfKx5A_sh7bGFVa6JUCoN-GNMZc3J5G6j7ubcfyHOQ@mail.gmail.com>
Subject: Buggy hardware mixing
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 12 Oct 2020 08:49:37 +0200
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
I was referred here from the #alsa irc channel on freenode. I've been
having issues with hardware mixing in ALSA since I started using Linux
at least 10 years ago. Sometimes when I am trying to play multiple
audio sources at once, one source will stop producing sound or all
sound will all of a sudden turn into a mash of loud, jumbled noise.
This has occurred across every combination of hardware and
distribution of Linux I have used for my personal computers. I was
trying to set up a custom dmix configuration to work around the
problem, but I could not get multiple audio sources to play with my
custom dmix definition. It seems to work if I use dmix:CARD=xxx, but I
would like to set my own period_size and other such settings. I was
told it is a better idea to try to figure out what the problem is with
hardware mixing than to try to work around it with dmix. So here we
are. I always thought this was a known problem and that hardware
mixing by default was considered "new" or experimental.

Thanks
