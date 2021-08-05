Return-Path: <SRS0=ibvm=M4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC56FC4338F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 18:52:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C05A60F01
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 18:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C05A60F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13754172D;
	Thu,  5 Aug 2021 20:51:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13754172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628189531;
	bh=S4uvklBWpWSw1uINJ3MgwtjKZVhhe7gXqWRSCnLmQ9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rC1QXTzxOfFmTPyJGJowaTtP6Om4yJlXMer2scVg2JhzuARMk0mfmwd1P19doborO
	 fXhoRBBXjTUZeo1UkgVc5JW+syidmFwj8a3PCKczDNNTzbYmOyRI/w2uFij5scc36r
	 uCjk0VYxT75Mkao5hAGH4CkRmY1XS9Uc/d+umIj4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A075AF8016D;
	Thu,  5 Aug 2021 20:51:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56524F8027C; Thu,  5 Aug 2021 20:51:19 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 022D6F8010A
 for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2021 20:51:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 022D6F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="jwbsiwne"
Received: by mail-qt1-x833.google.com with SMTP id h27so4600201qtu.9
 for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2021 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EZEunsTnaA1XzE54VnUD0YcTvntYvxdVoZOW+fPpXuY=;
 b=jwbsiwneBJFd2Ig6fWCLzTscXOQBAlvphpkOrnXo5ln4b/cl4H84JzNrDvAcVuVS04
 +Uix/Q7yD7sCFQhfpMWtshsEx2thnVuroO11Ye12H7cLNnOIvo/FiPnsWG+SFQk1lwcV
 3sEv24pAJMkGwqt9wGxdiFoeyMzMpupOtbBb0Qwy6pBrMiRdEymB2b2knQOYqGjPFgNr
 E8DdbgAlkZrQqmqjZM0uoeQipY4C5YPDXm6UBtDqPrSHvBMJ83dSMElz7Fa3vWk6st0c
 JwAJt9hDzH1Nn7gPakCOcQ/bsvw0Ub6O85EkbtxZ6rBTYCkWjaX1/1KiXp56WxWZO1bM
 bq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EZEunsTnaA1XzE54VnUD0YcTvntYvxdVoZOW+fPpXuY=;
 b=HMmuKc0/B3PBD257xrZqxB8dxb8RvInbEulRv4P3QONxBlrHEIE1gVdpCzE2VN0pz2
 MQzswI6a9mUvchkY/RXNvqGghmnrbIIjVkwDT7G+yNSN3FPbL9hbidXOAqvwJkI0AI0T
 G5hw7qdc2sgbjqKq6hnGbT+J7EMDqJwaB+InKQrhKAn6Xl61qrP5YoREf7MAiVKvxY3Y
 slcpnF7LJbi3TGz+4sgZlr2Sz8+gWsK6kBt3TzSUq62mtwL7AyjIbT6WB/8mzPBX0qkJ
 AnRCYgjCSt+hZXnu7bMffm33Hep24y80jt8qyblp4EzZu/etqZfbnk8DLoxeWA40ujnk
 jGfQ==
X-Gm-Message-State: AOAM533HxfhnJV6DSRxsJzpnOfpbaV4WhgM3K2A63Nj/39QWrQwEUUCQ
 0dsVtni4qvPkLjvf6jd5sitC5YrFjlqHxKqVQs4=
X-Google-Smtp-Source: ABdhPJw01R3FsLE2EQNT7CIn9yocm0qu86fk/7OLpG7DKbhG2q6MJn/s0acJtp4DeG5ZfTa6LLUEBQbe0kohY2aFTRY=
X-Received: by 2002:ac8:5b83:: with SMTP id a3mr5789733qta.210.1628189467046; 
 Thu, 05 Aug 2021 11:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
 <20210805075401.21170-1-chihhao.chen@mediatek.com>
In-Reply-To: <20210805075401.21170-1-chihhao.chen@mediatek.com>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Thu, 5 Aug 2021 15:50:58 +0000
Message-ID: <CAEsQvcsvbJdgvAOxkv_kbLohGi676Zrgz4XSFW2o3CWU3Q68Dg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To: chihhao chen <chihhao.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com,
 Takashi Iwai <tiwai@suse.de>, damien@zamaudio.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Aug 5, 2021 at 7:54 AM <chihhao.chen@mediatek.com> wrote:
>
> From: chihhao chen <chihhao.chen@mediatek.com>
>
> Hi Geraldo Nascimento,

Hi Chihhao Chen!

>
> For echo test, it means we use this earphone to receive and play sounds at the same time.
> We found in this case serious noise problem happens.
>

That's what I understood initially, and only a little later I became
afraid echo test was the name of the debugging technique you used :)

Thanks for the clarification.

> Log as follows with your patch
> <6>[  175.960387][T401365] __uac_clock_find_source: Clock Selector 0xc has pin 2 selected
> <6>[  175.966980][T401365] __uac_clock_find_source: Clock Selector 0xb has pin 2 selected
> <6>[  176.026251][T400354] __uac_clock_find_source: Clock Selector 0xc has pin 1 selected
> <6>[  176.032406][T400354] __uac_clock_find_source: Clock Selector 0xb has pin 1 selected
>
> There is no noise and I think this should be a firmware bug.

From the log I'm afraid my worst assumptions were right.

Regardless of which Clock Selector we want to set, the firmware will
always set them both.

We should contact Samsung now that we have at least a sketch of a bug report...

Thanks,
Geraldo Nascimento

>
> Thanks
> Chihhao
>
