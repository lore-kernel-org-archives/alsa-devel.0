Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14854C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:58:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FD1610E5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95FD1610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 608D11674;
	Thu, 19 Aug 2021 21:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 608D11674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629403076;
	bh=FR3BXOj4vhtjM6L5tneHSA4S3Ta65wB1g+vD5BrgVA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpZJLrI62GjCoAkG/68T2HjTQjh/glGKHC6SNYgRknJIBzfS5bKIjLik51jZf8p+4
	 Bbjl+qrIwRmY5WxcVu0Fm8XTRuoD4Chb63esQknpRItBrh/I45DdR7AecdE1w8j/lS
	 gpx9gJ+gL796UozsvKXHeRrMyUVlpUhntl+lox68=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D58BEF801EC;
	Thu, 19 Aug 2021 21:57:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 540F2F8026D; Thu, 19 Aug 2021 21:57:02 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53CD8F800F8
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 21:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53CD8F800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="MIVsKPsX"
Received: by mail-qt1-x832.google.com with SMTP id e15so5604093qtx.1
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bANW2RCtdy9VBEeiI3j/+3mwESh5TfgXMzY62Tyl/KY=;
 b=MIVsKPsX0m5oGzVZZ9BQazgNSDiHWSb1CCTfuTS8pwpQQx83c8kpTvaGcD194qOFKj
 8vrs6YFwpiNxPZcTD7+7EsCpPXlyABlxuo1ZsAnwHwfMz8SRAfw6SM6n4Gj7ncQLxlYg
 JOIl7OXEXudLAN9TjYPcF/AlO/CNcnedGTGdghxtxVggxtm6Fs5LksyYJqUlPjyIh3T2
 51Gz4VetvAV30nUmBVfOTZsfRwnxYp5K0jV5b4oNZZSZGf746vESMs395+mJ4oYtvNpE
 5OemqCCEh3KUH/xdocg9rR8atH3292fgfkF/ZnJP7GtH1sW6Gvtt86Po2FRD2VxWTFCV
 3I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bANW2RCtdy9VBEeiI3j/+3mwESh5TfgXMzY62Tyl/KY=;
 b=NPF6WUX1E3+zbvvnvDZgCjCSRikLF9FlBMv5UMB/Dv1t7F6ZRcGvT2WhshNS5zMz/7
 0W0hphYp7Ew6tDzFIANgkuCLnhVb3dDUXKjQJYGOU9k0N72g7CzDtx+VVn/U9h0hBql6
 IjkA56NA2jJGrSKpSRSWnPqrozYOG5D5pdvJGAgqNL+h61WshbkJDOme2mU1+VEbyyA9
 8izgIOR3yTA3Qk8z5RB/wzt52R0VLUvfdJOXl7wVTeItu+e8YjbRhxH7JvGNUwpUnNSr
 4baUrByyl//5KydMI8Syba/+nkszkXWF3YkhNRXK2V0qdyaTEcaMWvw3lmwcXh8js3yS
 cTOA==
X-Gm-Message-State: AOAM5336pQwmBvVsDZk6X4CHKO6Mxzr7emtBw/Ftw8m3aUwJgNRggslG
 HTcw1sxsmK/Fo+NMBzopZKvt3Ns8KvuBjTBKZVDmfg==
X-Google-Smtp-Source: ABdhPJwkuAoHR2v85paRVB6WkwhSPnm/ZbeEDoNIM89M/n93VBm5j94D1WVJvgGLl+kXHKm1BP20/nEUykvxwyNYHwU=
X-Received: by 2002:a05:622a:509:: with SMTP id
 l9mr14447454qtx.355.1629403010889; 
 Thu, 19 Aug 2021 12:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210819082414.39497-1-lma@semihalf.com>
 <87736cce-a96f-064e-6d60-71645ba46f13@linux.intel.com>
 <aeb40985-140f-b013-f368-778ad33fc7d0@intel.com>
 <50eb6c88-5f1a-7a42-adaf-da16f711e5c5@linux.intel.com>
In-Reply-To: <50eb6c88-5f1a-7a42-adaf-da16f711e5c5@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 19 Aug 2021 12:56:40 -0700
Message-ID: <CAOReqxiYYPgmAcN1RnVnOKziV+cnwD8nRCT_x3k7H3FeUW1SYA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: Fix platform ID matching for
 kbl_da7219_max98373
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 ALSA development <alsa-devel@alsa-project.org>, stable@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Curtis Malainey <cujomalainey@chromium.org>, Lukasz Majczak <lma@semihalf.com>
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

On Thu, Aug 19, 2021 at 8:18 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >
> > Apart from that, Maxim codecs go by the name of 'max' in
> > sound/soc/codecs/. It's more intuitive to have equivalent shortcut used
> > in board's name.
>
> the ACPI HID start with MX and there's not much consistency in naming,
> is there?
>
>                 .drv_name = "kbl_r5514_5663_max",
>                 .drv_name = "kbl_rt5663_m98927",
>                 .drv_name = "kbl_da7219_mx98357a",
>                 .drv_name = "kbl_da7219_max98927",
>                 .drv_name = "kbl_max98373",
>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Agreed, it is definitely better to revisit and get it all in one go so
we don't end up with a cherry-picking nightmare

Acked-by: Curtis Malainey <cujomalainey@chromium.org>
