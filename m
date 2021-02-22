Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E88C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 17:30:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5776564E31
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 17:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5776564E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0EAB1667;
	Mon, 22 Feb 2021 18:29:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0EAB1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614015029;
	bh=3ytqlPFvWs6z3qhgDpdptz85/7CVdnJk2clLA3JOcMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imHLQp0Jk+iO9Klvkee6HPqcHjFZb7joQrP73VJG/F38esx7E4x9cPSqdDan4dLaw
	 pPAr0DlswTHTaFWo45N700My4U+GexkOfT3mIkx4m7f+yx1bvxnCnY4qeA+oYBWItJ
	 n2NW6RfkVhvcWL6IbWISlJhy+kwMc4AyNUsGcTI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD2B1F80154;
	Mon, 22 Feb 2021 18:29:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6D13F8016C; Mon, 22 Feb 2021 18:29:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFD67F800CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 18:28:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFD67F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aH25lNOS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D42C664F02
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614014927;
 bh=3ytqlPFvWs6z3qhgDpdptz85/7CVdnJk2clLA3JOcMQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aH25lNOSrwiTCAbCrRsVbpo8AB0HpOBJ12qQ6U3hANaUWcio+6se1KGmfo8o7YdyC
 g31b0iPQUcU373p7TVugQj1JXN1lYG8Oi1IIgv+JFErf1CuD/yauBQek+Jgg8dsJQK
 HmQeKHinqg6a0gmkHby0xRE+xakdQZgqsvCsJQkZXrFLDBjLqa0UW1OG0pPpqhHSKY
 +eagJ5+LD9Ejz0qzfQEX6DKZ2KdH7qSfEuH5HgSVnRAAJXEdnEFSCta+WVKaz3y/Fl
 h+mIg/c6Nb7E/TkAxSDwOM7fH6fwWlTb3UtKOOVg3nRjMokIfSFjJvT0k658Z0jKGT
 DMI2zu2ndG+/A==
Received: by mail-ej1-f46.google.com with SMTP id g5so30746240ejt.2
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 09:28:46 -0800 (PST)
X-Gm-Message-State: AOAM532DKbudTk8E6o1GInARevN0rTeIajIELgWcoYaWlymoHq74ZmU4
 EDIk07QmZiIWNLHigxwmF9pr8T0Rk60aeqAyKjw=
X-Google-Smtp-Source: ABdhPJxo8GiYnOCs3OI4TIWP+XwBATYEHYu1N7z2IKldRW6GtQqUspgjHzDAhlRBiKTSfRO0dx4XFahCdEnelZE7RzE=
X-Received: by 2002:a17:906:1c4f:: with SMTP id
 l15mr11003409ejg.148.1614014925437; 
 Mon, 22 Feb 2021 09:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
 <20210219230918.5058-6-pierre-louis.bossart@linux.intel.com>
 <20210221111055.nfzr5nzvskdc3jyq@kozik-lap>
 <ac9fd25e-d5dd-6c47-07fc-ba05e33f60dd@linux.intel.com>
In-Reply-To: <ac9fd25e-d5dd-6c47-07fc-ba05e33f60dd@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 22 Feb 2021 18:28:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfDEkFPe+kAoH-dYveSTy8OPEzXJDnFN4AMqZgeW88PRQ@mail.gmail.com>
Message-ID: <CAJKOXPfDEkFPe+kAoH-dYveSTy8OPEzXJDnFN4AMqZgeW88PRQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] ASoC: samsung: tm2_wm5110: check of_parse return value
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Mon, 22 Feb 2021 at 17:45, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
> >> index 9300fef9bf26..da6204248f82 100644
> >> --- a/sound/soc/samsung/tm2_wm5110.c
> >> +++ b/sound/soc/samsung/tm2_wm5110.c
> >> @@ -553,7 +553,7 @@ static int tm2_probe(struct platform_device *pdev)
> >>
> >>              ret = of_parse_phandle_with_args(dev->of_node, "i2s-controller",
> >>                                               cells_name, i, &args);
> >> -            if (!args.np) {
> >> +            if (ret || !args.np) {
> >
> > Only "if (ret)" because args.np won't be initialized on errors.
>
> Thanks Krzysztof for the review, I will make that change in a v2.
> But just to be clear, there's no need to test args.np then?

Correct, no need to test args.np.

Best regards,
Krzysztof
