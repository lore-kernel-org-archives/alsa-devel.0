Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E6C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 16:46:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D992100A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nd28YKp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D992100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E884486F;
	Mon, 23 Nov 2020 17:45:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E884486F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606150007;
	bh=/7beND6nRs1/EKOeU7rUncVc63CUdnUjsOT01Ozn9y0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nd28YKp0xHl++qGe3gY12lbplYguDOMyCt67b2uyXSQoD02m5oGnbgoaWYhDJdgPY
	 GlVOHQ0FKRgWjc2DS9AcikVdld7/5zZyk+l/X/IgVD7ZrVN4llyxOKPZW5xIz+GkNB
	 XXONxhk9lHPFs/MNZ9/vl1IObviucNNvTDWW3zDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CE22F80128;
	Mon, 23 Nov 2020 17:45:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89C4AF80255; Mon, 23 Nov 2020 17:45:55 +0100 (CET)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4580BF80128
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 17:45:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4580BF80128
Received: by mail-wr1-f65.google.com with SMTP id e7so1725809wrv.6
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 08:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tTIXw5rLyAv33bToM20XD0dcKwsOzV94mj/iEGVXRWs=;
 b=gHLSf4vulJhDIQUTvuPb26+6Fnlgi96vV16QwerL/vOD4ZHQ9t5bFxfUYOgTw5KzbA
 Qqcf+JPO00Ayn8k2XzfPdrJtGN75LaExo/4zjD5pfyrkTS8A0ddyS6PCmyPSju8psFFV
 r6KDM+wJXATfxRiAT6vGrmDuBbza0buGvpfxRaosg7J4udWWyF+SB/GeUraKkrLWneEw
 Md5LK/4V/icpQ5gQxxrjr3Aam9G6fBzClfWJPxuSsawzG2S6c3AzRv4l1TA1BdZoZZiN
 TcBnigZNl7sdzyG4uSp/Bj09wImpiEaeUDGExWLTm1yliIz0Dy87C+y1cjlZlXIad0vD
 WE9w==
X-Gm-Message-State: AOAM532QglIYycNiXssmkyMVzLS4/psm7M2IpqZcL9TM4l461QnWr8rk
 YmfbH+34j/5x95Gyn1wg7vQ=
X-Google-Smtp-Source: ABdhPJwjyRPsg/ZgyyqA5febFYxtxg+7Hu3QymLN9YFEKOn7qG9Jk/Avn4KesTL8D6o4vJvRQHgSRg==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr538070wrr.85.1606149951691;
 Mon, 23 Nov 2020 08:45:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id d13sm22466554wrb.39.2020.11.23.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 08:45:49 -0800 (PST)
Date: Mon, 23 Nov 2020 17:45:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123164548.GA211086@kozik-lap>
References: <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123135006.GE6322@sirena.org.uk>
 <20201123145831.GA202597@kozik-lap>
 <20201123164330.GG6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123164330.GG6322@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 23, 2020 at 04:43:30PM +0000, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 03:58:31PM +0100, Krzysztof Kozlowski wrote:
> 
> > Having these of_match_ptr() for OF-only drivers is not the correct way
> > but rather something which is copied from existing drivers into new
> > ones. This is another reason for removing them - people will stop
> > copying this code all over again.
> 
> Well, it seems that the issue the PRP0001 people are having is that
> they'd rather that there were fewer OF only drivers!  More generally
> it is good practice to write things as though there might be non-DT
> support even if it's not there at the present time, it's easier to not
> have to think if it's strictly needed and it helps anyone coming along
> later who does want to use things elsewhere.

I understand. I will send therefore a v2 adding __maybe_unused to the OF
table.

Best regards,
Krzysztof

