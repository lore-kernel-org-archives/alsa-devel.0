Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2429C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Nov 2021 14:25:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7963282E;
	Mon, 22 Nov 2021 15:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7963282E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637591155;
	bh=wUEXbAP+JPnyts5Wl+ClqQflOltUboCHmwkBHCgPkiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bPJ+jkPF2lCKnsZCGCSGd1HQi7CS3/HV8NMZoHixWdVq9N2Zm5a/7HAhy4j91dY8i
	 t34Fqofdsvl+gJOswot8BCaiYc58IALF5eIsI0rBBGhLG9ATE398Mw9aXHiauwSDji
	 JlRFFF7d8Llt0grovvD0aCNDr2cKqF8CX6AQtRtI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EBF4F801F7;
	Mon, 22 Nov 2021 15:25:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E345F80212; Mon, 22 Nov 2021 15:25:04 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1249F80141
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 15:24:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1249F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.b="ZV4YU+sU"
Received: by mail-pg1-x532.google.com with SMTP id f65so5798135pgc.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YnxeGymcCEbfmTiuZXDKf3tgkMXvkQvRUy5uTOBjZyQ=;
 b=ZV4YU+sUroW88Mme81TaD5ulHL5j6+arntSxDBIGSMkagUNi+Z+vYqeQeJPjZeTfRJ
 epUxzyLTLrOCNL026yHaMOUxDY5f8JuZEsfsV163LokQokZXnDskBqZMT1qRY0TNPDNj
 Pe8/YWGeDgZOK5SK+Dm96Ygve5v8P2/Kowrhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YnxeGymcCEbfmTiuZXDKf3tgkMXvkQvRUy5uTOBjZyQ=;
 b=lNcaMnT3i88/IzeYuXGCX/IuQUTFdKpDEoT0+Ews4zJQbTan4Rir22JEOv4jR4HIld
 tGa9hnYLXO6vR2vjwFewu4+txuBKyVphqyDJlQ2b81RewbMSkgQsKCnz+s9VRKpTc+ft
 TPLgSWI9NAIB2giGTDVb1AtszAA8T07TkAZOjevxgHz1uQv9M4GaidY33OEY3BfjqBQ4
 Pjgx1LKhXNbp472RIe7VaF5xTIeLIztNb1yIAqvTox2rgtuv59yVJtAlcj2fRYOOprWp
 A7ItCB6B5PBBKoxT+rCTDaBaP4y1dSKJsnDJjX6Zk9uGGDyfUMrlrlQ7fdamD3xP7TTx
 CnSw==
X-Gm-Message-State: AOAM531AMOFnkD/sAeFKBCa4B+k5jtKRS0yswao66Obbi8mRH3yrgT0Z
 YgoZBvPruvWS4XANntyw+I36d27suFlLFLX/elhL2g==
X-Google-Smtp-Source: ABdhPJwwnqKrt1uvX/kQIgmqdkM5eb/Z+4p3ejfkShcIYuNGlTkwcMUE82oN+F/w6i8Rc08gaFoGx+bildiyDfDae+w=
X-Received: by 2002:a63:6c49:: with SMTP id h70mr34108131pgc.368.1637591094319; 
 Mon, 22 Nov 2021 06:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <20211119153248.419802-3-ariel.dalessandro@collabora.com>
 <YZunmnHqemZRJ6JK@sirena.org.uk>
In-Reply-To: <YZunmnHqemZRJ6JK@sirena.org.uk>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 22 Nov 2021 15:24:42 +0100
Message-ID: <CAOf5uwnrUdF4fOVGvp8GmuUL6SpsyjPq46WBP7hcY7bYbw7RHA@mail.gmail.com>
Subject: Re: [RFC patch 2/5] ASoC: tlv320aic31xx: Add support for pll_r
 coefficient
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: bkylerussell@gmail.com, lgirdwood@gmail.com,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 kuninori.morimoto.gx@renesas.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 linuxppc-dev@lists.ozlabs.org
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

Hi Mark

On Mon, Nov 22, 2021 at 3:22 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 19, 2021 at 12:32:45PM -0300, Ariel D'Alessandro wrote:
> > When the clock used by the codec is BCLK, the operation parameters need
> > to be calculated from input sample rate and format. Low frequency rates
> > required different r multipliers, in order to achieve a higher PLL
> > output frequency.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>
> Did Michael write this code (in which case there should be a From: from
> him) or did he work on the code with you?  The signoffs are a little
> confusing.

It's fine. We are working together

Michael
