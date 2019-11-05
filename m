Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA8C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:09:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEB521929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cQrvLadu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4Pyc+ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7CA816D2;
	Tue,  5 Nov 2019 20:09:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7CA816D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572980990;
	bh=xxUfELp+IgufQU/DqzYWm90X9pyqtc5SqT2wIT8NCVk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQrvLaduGcwNZKywhC3b72lNV4xxgS3GWkRrrNlcSLFFuVTK15rvo7vQ1zo4t7UlY
	 DbJ7tjMzgVak7n8y+9qkMMKeZlNShqVpGyOqosuSiZkvbcwygylGxAvYAPMuiRlzTq
	 qWacRj+OHS7p04c95uW7/A6gGj1LN4my54hvb6I4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21368F80446;
	Tue,  5 Nov 2019 20:09:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19E9BF8049B; Tue,  5 Nov 2019 20:08:58 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48800F800F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 20:08:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48800F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A4Pyc+ti"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D64B621925
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572980933;
 bh=OXmBdFlRHFjSKG93l0PdhfI6GDLFZkT6/eylL4O2BLY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=A4Pyc+titsh2MV21obxyJRFvEjTVhzZVdWlofZbm9ErJqczl1aSdsxzH2xh1K5BrT
 RQi8cmmYa3bBydJXKkGV83IkSwxjUqGwYyAs11LfD/Y4+MXMyC2wo0/rIObZ9L+ZMd
 64yEhJSyMdmn41WGoUwlTmPIbBRE864pCWHECsig=
Received: by mail-qv1-f46.google.com with SMTP id q19so366819qvs.5
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 11:08:52 -0800 (PST)
X-Gm-Message-State: APjAAAXS1lKnRT/ONo8RfYMsUC7RK6AmPAv+TJaa88/1EFL7cpytMb+l
 Z7emnskvbiEx3dO8dRQR6839+QhTdODgDcF9DQ==
X-Google-Smtp-Source: APXvYqxZiO3lZWJ0HQfv3215/wlPFfLAmRacWVsijd7Otyaf6TcDjfY8XMoGW2mVkceqmWdXru0Tw3AymFwc3LoYKik=
X-Received: by 2002:a0c:ca06:: with SMTP id c6mr10688316qvk.136.1572980931880; 
 Tue, 05 Nov 2019 11:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-2-srinivas.kandagatla@linaro.org>
 <20191025204338.GA25892@bogus>
 <90b2d83b-f2b2-3a5d-4deb-589f4b48b208@linaro.org>
 <371955d9-ad2d-5ddc-31b4-710729feae42@linaro.org>
 <CAL_JsqJmRReW2n0R_Sh4f7AFGYA+ZLxuFDokLTSBKoFTg6uRSg@mail.gmail.com>
 <7811be04-dfda-5953-110c-bca685fdcaa4@linaro.org>
In-Reply-To: <7811be04-dfda-5953-110c-bca685fdcaa4@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Nov 2019 13:08:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNcXe7YSUjHWyFO_czncnR3y7w3NP8ofXfCiXpMrqzRw@mail.gmail.com>
Message-ID: <CAL_JsqJNcXe7YSUjHWyFO_czncnR3y7w3NP8ofXfCiXpMrqzRw@mail.gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Vinod Koul <vinod.koul@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 01/11] ASoC: dt-bindings: add dt
 bindings for WCD9340/WCD9341 audio codec
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

On Wed, Oct 30, 2019 at 4:55 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 29/10/2019 20:47, Rob Herring wrote:
> > On Mon, Oct 28, 2019 at 7:45 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >>
> >>
> >> On 28/10/2019 12:40, Srinivas Kandagatla wrote:
> >>> Its Phandle.
> >>>
> >>> something like this is okay?
> >>>
> >>> slim-ifc-dev:
> >>>     $ref: '/schemas/types.yaml#/definitions/phandle-array'
> >>
> >> Sorry this should not be an array, so something like this:
> >>
> >>     slim-ifc-dev:
> >>       description: SLIMBus Interface device phandle
> >
> > You're just spelling out the abbreviated name. I can do that much.
> > What is 'SLIMBus Interface device'?
>
> Each SLIMBus Component contains one Interface Device. Which is
> responsible for Monitoring and reporting the status of component, Data
> line to Data pin connection setup for SLIMBus streaming. Interface
> device is enumerated just like any other slim device.

So a standard set of registers every slimbus device has? In hindsight,
I would have made reg have 2 entries with both addresses. I guess that
ship has sailed.

It seems strange you would need both "devices" described as separate
nodes in DT.

>
> We already have exactly same bindings for WCD9335 in upstream at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt?h=v5.4-rc5#n42
>
> >
> > Is it a standard SLIMBus property? If so, document it in the right
> > place. If not, then needs a vendor prefix.
>
> "SLIMBus Interface Device" itself is documented in SLIMBus Specification.
>
> If I remember it correctly You suggested me to move to "slim-ifc-dev"
> as this is part of SLIMBus Specification.

Probably so. If it is common, then document it in bindings/slimbus/bus.txt.

Then here, 'slim-ifc-dev: true' is sufficient. You can just assume we
convert bus.txt to schema (or feel free to do that :) ).

Rob
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
