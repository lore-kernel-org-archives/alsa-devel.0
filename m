Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9CC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:21:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA5B22281
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JVICsFUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA5B22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D851316DB;
	Mon, 26 Oct 2020 14:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D851316DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603718460;
	bh=wIDAsIrTKl4vd3oSv/HCo8G9yUWe8SQbeQE44we5+fo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVICsFUrE69g4qjeGVNP9jCwnVAEKbCLWclAn+aAld72pNzMt4Z93EY/5l1QZbicG
	 smybecjBngbgu7oIY2SFtnkps+pQ/55rCw9xa60IZ2Iqp4lv48oALvRrQ86ZB4s6rC
	 NUANmD1o2F9jh/uPh6ZmEMMRJhLbtz93f8gWLvXE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 614E1F801D8;
	Mon, 26 Oct 2020 14:20:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E198BF80212; Mon, 26 Oct 2020 14:20:07 +0100 (CET)
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com
 [209.85.161.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D937AF801D5
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 14:20:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D937AF801D5
Received: by mail-oo1-f65.google.com with SMTP id n2so2290067ooo.8
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 06:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b5V74H5JuHP7LZrTQlerYiUXU3pYxv+LpdxUgjv8arc=;
 b=GChQiYHyuf0FDXKnstv1Bxt/K57DHZP1qud/WCKLJClZPR7kt8Uoh6rq5n0YOImO5d
 Qd/G3ad4pU1hBloROgTFzrr3X0HwbnhBo40/a6hH0IleUMNrfdKsXrG5yqp14u+n0mXw
 +WAjxUMSS7tQNJj+D5H3hzkWkpwXs//WFNu0OiJTi2TCdf9yVnH+tx6SKk207iUyByaW
 rxHColHa7xiDuUnh7O8DCbywNB4FeW1AmqUE0B/wqegOrLXjtGwZ6fTx3h0pMtRx/L1B
 +P6lNUkg5DJoYpo2KLmv6moDep9B5Zzu9LMfu4J7FQvp3WdjaLMxADlT+HFRI9tOPe8L
 +cDQ==
X-Gm-Message-State: AOAM531UUKqmlzh4dGYbS4V0FQtFQZh64WUx5saFOT2j2o8/tILoHIKk
 W8TtuiaqvqHw96uQYk5BWQ==
X-Google-Smtp-Source: ABdhPJxlxZGzNp5Qy7jehOdA9r8xkKsLvjdTXkUpwwVK9y+I569/IzmokE39lu12/73EPOV+AphQQQ==
X-Received: by 2002:a4a:d083:: with SMTP id i3mr13483342oor.74.1603718399379; 
 Mon, 26 Oct 2020 06:19:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f18sm3514302otp.10.2020.10.26.06.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 06:19:58 -0700 (PDT)
Received: (nullmailer pid 19048 invoked by uid 1000);
 Mon, 26 Oct 2020 13:19:57 -0000
Date: Mon, 26 Oct 2020 08:19:57 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/7] of: base: Add of_count_phandle_with_fixed_args()
Message-ID: <20201026131957.GA19011@bogus>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
 <20201016173541.21180-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016173541.21180-2-rf@opensource.cirrus.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, nsaenzjulienne@suse.de
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

On Fri, 16 Oct 2020 18:35:35 +0100, Richard Fitzgerald wrote:
> Add an equivalent of of_count_phandle_with_args() for fixed argument
> sets, to pair with of_parse_phandle_with_fixed_args().
> 
> The existing of_count_phandle_with_args() is modified to be a
> private function that handles both cases and the public functions
> are trivial wrappers round that.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/of/base.c  | 73 +++++++++++++++++++++++++++++++---------------
>  include/linux/of.h |  9 ++++++
>  2 files changed, 59 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
