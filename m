Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 07:09:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4086125F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 07:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B4086125F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F09F71670;
	Thu,  7 Oct 2021 09:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F09F71670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633590582;
	bh=7j8Fdby2niiSkmDuAMad3tMZxuMYzJstbuqoPKWbVRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kphFGKvcubt5Qpzo9zCtKM2w9A1oiVH+5WGw54syZ/2FBV1oCv82ISQ1gF97rOJpA
	 K0Je/qMeNurx2VGcIJF7r+0qDvnnhiQzx+wDJOgwvZMdlBzUqlJg+M8mjz/GrNtQLw
	 wR8JqquHAfwKXvqZ7SBQuUxXk8gvuqBFYY+vIb8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A720F80259;
	Thu,  7 Oct 2021 09:08:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B2A3F8028B; Thu,  7 Oct 2021 09:08:50 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2163F800FE
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 09:08:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2163F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SYAnm6NV"
Received: by mail-ed1-x535.google.com with SMTP id a25so3570699edx.8
 for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2021 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wwbZXV5jSczOvQnQmFQUZmvpQjyi3EVC6JkF6fMhuZs=;
 b=SYAnm6NVK2kthlNvw12cu1PYbcGwU9d1U8T3+c9wzowdzbIrpkuifPU9pDE/ceV6hL
 KmvOCEbmwK/yijpfC/gIt2iZ7b7ss+JfH5PD4N0cJlQo54zT1sXO7KR0UREjuigQJsSB
 kO0N78n/OyHqRJHadvEhN77QjYrfTTl6cS7dyV6TqXllNrjw8DAzAkqJ1ip8Ew1qf5cM
 w4vgcD4Mxw1WQNawBX5L56DICBrCYKW/5OzsYvy717YKxSyG5G1BzLQcFJmArwPlBxQ4
 lfHOf5zJG3BZ/T1Mieqa06RCIqsr+V3clYyFspeeg/A/8Jn4RfRsFrrf05iCUfIL+XQC
 IEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wwbZXV5jSczOvQnQmFQUZmvpQjyi3EVC6JkF6fMhuZs=;
 b=emtETfl1EJmdKdyyX5xWSwAsUlFsr9fIZ0wF9ZXMqfIDecvPYfFoCcO+PZ2lvr8WVj
 9jA2wrEVulqX3Q1Bl+x8Y6KMCrp0nJAVueoHmC3HJVcEMj5ndOiUB8OsbUfIMf3ZhKpl
 6eh09ybfnutD/vjZ+I1GEn3ksCcAF1lclTTsZtpMb3vaMY0pSE+c27Krr4MsgiOUeDcV
 TnwuNqktSKdGZGeewzOI5pWJwql3zWqavY9o+sUzKT86iA8aVbdtE1JjK2/dWTxIRHjy
 KO74QqPGzPi8hBmMDREnbW0wqypSVUGivfyOziWN0HlHiktU8aVBPVY/zYY41NGaCwJR
 aKnA==
X-Gm-Message-State: AOAM5305nxjfHkW5jtl8NkNrMmZ5xsCCc0jChejecG6iGfalOICtmjW7
 sHSot4xh8YN0zXqr/TzCc5TeiIV4qBABHzwYOTYScrOfDnc=
X-Google-Smtp-Source: ABdhPJwIEK/odaRxepSdt44uG5K4KnkH/6nJf5DILqlmOwKchGMXsjI9PiPE/5Ai1mwhLC8uAxAWOOYE5A9HImzm3sg=
X-Received: by 2002:a17:906:1707:: with SMTP id
 c7mr3353614eje.377.1633590522083; 
 Thu, 07 Oct 2021 00:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
 <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
In-Reply-To: <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Oct 2021 10:08:06 +0300
Message-ID: <CAHp75VdiY98mO2Sj_Urv6m3GgpoUrSyDiPttGxTQeCv_z_1DzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
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

On Wed, Oct 6, 2021 at 7:14 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> > Access to platform data via dev_get_platdata() getter to make code cleaner.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> For the series
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

Are you sure you gave the correct email here?

-- 
With Best Regards,
Andy Shevchenko
