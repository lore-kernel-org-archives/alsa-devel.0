Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9156FC43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BB5224F8
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n3yPzKxX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f854U0lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BB5224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BEEE165F;
	Thu,  5 Dec 2019 16:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BEEE165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575559188;
	bh=WBy7qEQfysYYjWYGSu7scNsdexSzACSyDlTIz8cMvAo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n3yPzKxXr0jLP8Yu0lDA9Meq+jcqOQbwAUA1yJDDkelR9X4ll9mgQg8VPy0HBCAsG
	 GLrGfM1hXstHQoB5kW47/3sn0tomqpx581cwI99CZ16j40wmLLbgqkvcU++1gWIvsj
	 l9dJYrMY9nEb0ZVPJbYVt1ao9U9yqebjd9iFVf6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0834F8015A;
	Thu,  5 Dec 2019 16:18:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D664CF801F8; Thu,  5 Dec 2019 16:18:55 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3A23F800F6
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 16:18:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3A23F800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="f854U0lV"
Received: by mail-qk1-x743.google.com with SMTP id m188so3637575qkc.4
 for <alsa-devel@alsa-project.org>; Thu, 05 Dec 2019 07:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0BwMXk5hRSuy0y3tQKWIkHY7VFBB5t5nal8UAu26pV0=;
 b=f854U0lVj3z10xepU+tsgSv+XPc3PysmZasUzylKGudRKwAVwTvknlhar/MZjyZLAA
 hXyX3y0zmlaDwGjBJNYLeXf+Akjvc4b3l/LkV3WojwsfHThD2h63ndSqnXFoNZ9Z1iSa
 9nFomVGVTo6NVh3pxoEeRVy97m+63rna1puvQ6gWLwtNG9kP0HzaI6n8g5SeuI3eUKq/
 Q9a3WQPEy9c/uZQ2HHGP/+mMr4L0sIC4fmBy/m5u0Mz2hZHN1jw3dWXwRPUAp8KR11ia
 Zz1jG7Lh9rRknMQwh3Ce9qvZ+Z2e4dqlnEO25X5Mc+Wx7aU+vHEP97OXWYP1YRu8UJFo
 9QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0BwMXk5hRSuy0y3tQKWIkHY7VFBB5t5nal8UAu26pV0=;
 b=KLXeZ74KUxNhVisH6FBA40FyFipPjqpGDQEOBh+XrKluKTkRazBLX7GkY/ZuGwfX/y
 vcjhJKwPl1CKvR9S1DBm4oSdn5O/xL2jVlh8QTdfoaT317HJJb4obG6t5LTWNOCjAVCm
 cACOb+5H5sQlRPLGMOgkH/xMC6d7tkYsWl7DbmKq2s3zFxNy1TFqMdOOVXi21KsRLg7E
 /5XebnEV7Vl2gNO8YM5BWVZdMl2alkM57NuD7g+k8p0eXacLLk6q+d/In2zegwUoYNpn
 ULaE6wn1FXa7EIeXw8JrJvuH2H9kh0A9/pJij1lyeddB5M5z++0Wc9EGVAsjEqTAheoV
 zmYQ==
X-Gm-Message-State: APjAAAXUs0BDtsGGmefk2hDlItZDwCltNtVwwzDJJl2ThJEeWkNi5+yR
 +SNKk7jQ9QN7q4m8V9OsGX5rPtFlZUu65OnDB00=
X-Google-Smtp-Source: APXvYqy/iLj8KLN1UDZwFsyVLYHCf+O/K18C0Y0ubhJH6yUTiraMha83tv5a67mR5A4t6y7+deDo8OmYy7FlgLp0ri8=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr8632184qkg.402.1575559130520; 
 Thu, 05 Dec 2019 07:18:50 -0800 (PST)
MIME-Version: 1.0
References: <87r226x8aq.wl-kuninori.morimoto.gx@renesas.com>
 <87o8xax88g.wl-kuninori.morimoto.gx@renesas.com>
 <CAFqH_536+0uuAzjXFPrS8OVeoqStSNZjz_rrSeqyh3dNuWBcbQ@mail.gmail.com>
 <7ed222a2289c8d6544098a2937ed4a7f6960bac2.camel@nxp.com>
In-Reply-To: <7ed222a2289c8d6544098a2937ed4a7f6960bac2.camel@nxp.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 5 Dec 2019 16:18:36 +0100
Message-ID: <CAFqH_51OCsk+mVT+GedDf+wmGS3HgoKg_k84qq5zv7YbxJm+EA@mail.gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: soc-pcm: remove
	soc_pcm_private_free()
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

Hi Daniel,

Missatge de Daniel Baluta <daniel.baluta@nxp.com> del dia dj., 5 de
des. 2019 a les 13:54:
>
>
> > I didn't look into detail yet, but after applying this patch my
> > Samsung Chromebook Plus started to show different warnings like this,
> > probably caused because in my case the driver is deferring?
> >
> > I'll try to take a look, but if anyone already knows the cause,
> > please
> > let me know.
> >
>
> Hi Enric,
>
> Can you try:
>
> https://patchwork.kernel.org/patch/11265061/
>

Actually I picked

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.5&id=4bf2e385aa59c2fae5f880aa25cfd2b470109093

which is supposed to land in this release cycle, so all fine.

Thanks,
  Enric

> It should be already in Mark's tree.
>
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
