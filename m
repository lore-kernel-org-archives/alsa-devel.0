Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC656C32771
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:46:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F962075A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y60VC5Sq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mdt/L/fH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F962075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5359017DC;
	Tue,  7 Jan 2020 02:45:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5359017DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578361591;
	bh=HESYo7veeZCUey2njqACUgWp/Dq5QR6YeGBh+BeOAbU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y60VC5SqNlpFM6GYNXf5QpKn96eFd1n5UmVY8fYnnF2Z+R6gIWvS3mcaYF8bjqADm
	 xqWUhFzmre1HIyp6yC096NW4xLLvjepS8vUpQ/uqxblduz8t1WH7k3zQ8fc/mMzZRt
	 pZLbuk7xgOxdx6PQFQdkcliI9P0nAKna377saU14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD842F80149;
	Tue,  7 Jan 2020 02:45:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3DFAF80159; Tue,  7 Jan 2020 02:45:38 +0100 (CET)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CF07F8010C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 02:45:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CF07F8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="mdt/L/fH"
Received: by mail-qk1-x741.google.com with SMTP id z14so40058093qkg.9
 for <alsa-devel@alsa-project.org>; Mon, 06 Jan 2020 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ft6xmRm0Xn4A+6zJu2AAPIsi5FGpNr4OiKyWPq8PF3E=;
 b=mdt/L/fHFt2uUCxneOT+wJBx1zeGq9fEF86Cyn+w5YQHYXVdG2UDKU90QAJJDbAT6E
 IZWrNX6Taxnc5BNAW8Yp3jFm3p+efXels7I1FhUsccQ4zciOFeCl6pRPzl9m7pO2PuDr
 KccNYENPlAXa8/HDVUEFXxyjyo87LkIjp98PX/W8bgzxDLiDmuBzWbE0awp041Lw231F
 +39mAOxKlUQKQGTmn1zMvdes8C2LY2Tfwuk7RCMGiBDabQHnqMP7NGNdvxL2BEaX+Sak
 z7fe9ZeK79KghIH6+sVVA3NzodbDqzqiLcC+fviJJ+agPmBXo3F4bTuXNJhJr2KcUTHw
 nV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ft6xmRm0Xn4A+6zJu2AAPIsi5FGpNr4OiKyWPq8PF3E=;
 b=pmlQ6nkq4XDsO9lVcwHrgLWNXtSoZ3AC3y0si19zMAo2ylSZfdNh4HWaICHElG29eY
 ZHnqaKy3s7Nt4nxd4pniLeUTEQPBn9kNkuYhXMyodbAhSSdYCCK/jWgS5HFyPJ5N0cim
 O8SmfVJvwH4jxJtwVYtfFtmoJZv2OitX3XGg5Y70TyK3/5teG+LGE+yrGxa28iWXp4Vo
 yApvhiD36lwsBaO23GDuTizBPnzFcP+Uq1fM5o1kWDinM5RASSVYqN76FAR4JKR9lK4+
 xeil4Qp6GtrpL/1s95KNcrOtHrZwNH3SpFxy8aBmfMu4Ywl86fnkdMOlUkzidxJpfqQp
 4+sA==
X-Gm-Message-State: APjAAAVp6hVpwXX5tDWRHKG8iWffIozoW+hK6+1qLW7OTryFda2v9cRF
 kiEtrV6MkfuQZBQavg5JdDyE9T3MXGxPwJDgrN2fOQ==
X-Google-Smtp-Source: APXvYqwhpelqz1BD3Zaxd7qhMERDtnjDXuXuK5sCqGFKA0nX5yXFO0Qqv4/D7HsevTyPJjTlnid1ORnGa9dP/VZvId4=
X-Received: by 2002:a37:ba03:: with SMTP id k3mr83504125qkf.127.1578361533830; 
 Mon, 06 Jan 2020 17:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20191210195333.648018-1-arnd@arndb.de>
 <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
In-Reply-To: <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 6 Jan 2020 17:45:22 -0800
Message-ID: <CAOReqxh9wamuKQnjPqUsZS_=4xUbsy-Y3v+=OXGaWV5EuONPmA@mail.gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Curtis Malainey <cujomalainey@chromium.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 linux-arm-kernel@lists.infradead.org,
 KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5677: add SPI_MASTER dependency
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

On Wed, Dec 11, 2019 at 3:00 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 10/12/2019 19:52, Arnd Bergmann wrote:
> > When CONFIG_SPI is disabled, the newly added code for the DSP
> > firmware loading fails to link:
> >
> > ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> > ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
>
> Would it be better if the above functions or the functions that call
> these are conditional on CONFIG_SND_SOC_RT5677_SPI?
>
> > Add a dependency to prevent this configuration.
> >
> > Note: the does not work with the DT probing, as there is no binding
>
> Are you missing 'SPI' or something here?
>
> > for the SPI half of the driver, but nothing seems to be using that
> > with the mainline kernel anyway.
>
> From a Tegra perspective, given that we don't use SPI in conjunction
> with the rt5677 codec, only I2C so far, I am not sure we should make the
> tegra_rt5677 driver dependent upon it. We should be able to operate
> without the SPI bits enabled.
>
There should be no changes needed for tegra, this should be isolated
to the bdw machine driver. The only things added to the machine driver
were some dai links.
> Cheers
> Jon
>
> --
> nvpublic
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
