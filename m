Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD45C54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:04:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F0120706
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UzBz7Qhk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRkr5OSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F0120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A86E9169E;
	Fri, 24 Apr 2020 17:03:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A86E9169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587740645;
	bh=khHJ/qfDXwO0SxRqa2dmn0jtYs80C5IPsO2M64YJzr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UzBz7Qhk1CzbZfNNZdNopL1EADYC8p6tW8+7VxRAEeiHVaIoq7RrDxk2v3vi+Ifhm
	 3rVoT6R0hW1Tv2FQFgMKhvnFFzG6j9Wiwlaj6YDQxAJIZ1IgWXalf8ukkNupsnS1Wf
	 UqB2kpkiM+NOMD9aLyNnlwWbQrDnbYznH1sHFEyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46B09F80121;
	Fri, 24 Apr 2020 17:03:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9D78F80142; Fri, 24 Apr 2020 17:03:13 +0200 (CEST)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C153F800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 17:03:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C153F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RRkr5OSN"
Received: by mail-lf1-x141.google.com with SMTP id l11so7946087lfc.5
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=khHJ/qfDXwO0SxRqa2dmn0jtYs80C5IPsO2M64YJzr8=;
 b=RRkr5OSNjAFff21BUpkXHHkPxSIyAuTioZOFSEw1dXZMBMDMV8ESgZx1sN+bieMOEi
 rNrHYqIAzUUWL20zbs4UlOmWJnNHhWxsncuCo1UfpG/7qrTVBWGXNH+6N6+Mg0jIo1dU
 +ayHl25uddEqcORLrWtTMMXtIDmvENxt3Zj+B22kCYudS66/6OWog7BB7LI8se0k4tyN
 VWgY0aZNoYb64h6z5vN0rdvQUH+FqFHrPH5JUPEkM13VFEBDzVe6J13m6Dm19dgo4nX2
 7Gcpsa7av/lDZlHMWzGacFnYkfFxlONDGGfd2uxZ4hiD3qqjD0wDkaeOJBSsVSt8KDkJ
 splg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=khHJ/qfDXwO0SxRqa2dmn0jtYs80C5IPsO2M64YJzr8=;
 b=nNAO/V7ZtZ0J69EfGjqmzuuQpCGVjTO3qqRRg7fjrpcVo7lixxCe98NDiwBBuN50uy
 kBRuZb1Wopj6hpox0uMKI2sn894BlSzMWOtbbmYf4L3S1H1FgJLfNOTxfKQaGUaFdnTl
 3Mn2G7ORxWIUbOV5F85Fw7IR4ZGKGdk8PfIKYcCayTfuOYpoe17wh9D85xrI9zTsPx7c
 5K0EXulMPIAeNqJlc/TkfM4aOdr10gGAKsO51rehFG0ZQi8V2G+DCdIpLcOCQDoaRfM2
 v1MGcSCromyImi4K/oEzSnu4RF7+Lq74SRsfCms7TFtBA47RM+TbhAsxE9Pgng9ttTfn
 ADnw==
X-Gm-Message-State: AGi0PuZHCojhIRE2ge7r1bfAhDeH5jAsyyAKkkaD4xX+nD8vW5730l52
 0r0OdZDobwa09ITqQXQyDWlSj/RMaU5CRR8yT+Q=
X-Google-Smtp-Source: APiQypKfN8x/KiL8cm20USDhG1bDKgL3Mm1Z96Nh43Ey6t7cQFrqUvE0hqL+TKzoCoSEBsWgGg/hnzbYCytgTuv3VME=
X-Received: by 2002:ac2:5932:: with SMTP id v18mr6723669lfi.175.1587740585655; 
 Fri, 24 Apr 2020 08:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424022449.14972-1-alexander@tsoy.me>
In-Reply-To: <20200424022449.14972-1-alexander@tsoy.me>
From: Gregor Pintar <grpintar@gmail.com>
Date: Fri, 24 Apr 2020 17:02:54 +0200
Message-ID: <CAOPXC2kF-k9xH8KhP_s+RmebgTdZW7avn9uedMRAooOB5WhzCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Improve frames size computation
To: Alexander Tsoy <alexander@tsoy.me>
Content-Type: text/plain; charset="UTF-8"
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Roope Salmi <rpsalmi@gmail.com>
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

On Fri, Apr 24, 2020 at 4:24 AM Alexander Tsoy <alexander@tsoy.me> wrote:
>
> This patch fixes this issue by implementing a different algorithm for
> frame size computation. It is based on accumulating of the remainders
> from division fs/fps and it doesn't accumulate errors over time. This
> new method is enabled for synchronous and adaptive playback endpoints.
>

Hm, I still sometimes get click usually in about first 2 seconds,
but it is hard to reproduce.

This will provide better out-of-box experience. Thanks.
