Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFCC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:22:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C07B20773
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cfePbFBJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Vf/dw0OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C07B20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D9871615;
	Fri, 19 Jun 2020 03:21:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D9871615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592529768;
	bh=diO2ek/NCOrsvuXu08rDhM8ptMAAIxpIgXY+FTo9a2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cfePbFBJIaQ5OldA2JTB5s1JC2tNyfwdHVtMmj+yft+5qLxRBPdjOdE66j3kAu1gF
	 Hky9MfwmuauhSZx0EaqyLDW67Xup5duj7ILDUL8XiUyqm+onCKjZUfU6A6lEfKc2sS
	 wjT12Ciu9paHVrhbQdOMcUew8WoZODGDlV+xXKik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB0F2F80116;
	Fri, 19 Jun 2020 03:21:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5D83F80162; Fri, 19 Jun 2020 03:21:55 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F18B4F800EF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 03:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F18B4F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Vf/dw0OS"
Received: by mail-qt1-x843.google.com with SMTP id e16so6095818qtg.0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w/OYbNF2xZDGwoK9gvfukfbZuyRttvDoa5UQyJNBr/4=;
 b=Vf/dw0OSMgK+DQ0hEuMoZoWeRO4DCVrx8nEgs2IWrkV4bMf9MeLHHre585tJwAfUiY
 h07JFPb/02EdOXVmn5Tp56VdAMVHJvQ631N7QV/iHJrdQXukzyqneUqCYnvNYdeXNnFo
 aHRraT0I/CsllEyrl6o3tcL/OcpVuxSrYg4zauvpEr2pRmZnywfvyXTyjMgNdd77zb58
 XJSy3Gk1sKJLt4tLOnaYulXNE83mi6JANQ8y1OE9Dh+bixZWyztXcHniHTGpXY5buly5
 xZ73yV/l+os0+wCEvxOHftPdh1nh8O+4OYcM1p62wA1kPsofIJEphbjEgRGODiC+GR4T
 Ur6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w/OYbNF2xZDGwoK9gvfukfbZuyRttvDoa5UQyJNBr/4=;
 b=FcJA/TarZUULmPoCtdCi0aqRpisiPRmRpq448jAQbeydnktELwyzicpgyAojmlfwyY
 ZG3wogo0qgxmHZ7Dg1XJfiA55Sb7sX5FJQxMH3F+dbrB6KWYSUiYjp6sX+Sy051aMVYs
 SArzmCqQ7pdiczQtYiuWQzotdd0Poisa/mFVjp2GVOGFXyJMogWAxhMEzVwe0P00CVxD
 cstZBvtyS0A1wbX+JQbBlTB/VvdFnZhhxWKtpzkv8s6+zNU98kuiZZpAnYZ0ipbnTMmU
 GeRExU3i+4R4AfrAZnMxLO6PxJqfo031WSGaSZlI/MV40O3MApEowWKAji/OW/IFpuWR
 Tbog==
X-Gm-Message-State: AOAM531N0Td8t5GBqyCnw49NcGUmIPMenLEtRyzZRj27OZLPQSSnW3TE
 bi1/nEUpeAujG9JuQQKSEDxXCMG5O2v1DeySELYlmA==
X-Google-Smtp-Source: ABdhPJxUkkm1s+RPpzK5vBKV5OIlR70/NnoZ3y8vethzXI2hPVVDcrBDJV9DPq6ERGcTbiq6qUj/CzjKAzU/Us3GX9M=
X-Received: by 2002:ac8:7089:: with SMTP id y9mr1105708qto.355.1592529704407; 
 Thu, 18 Jun 2020 18:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200330194520.13253-1-cezary.rojewski@intel.com>
 <293372ae-5270-a1d4-2577-04991c08e33f@intel.com>
 <ee6c0545-a325-8df4-9c26-d823582735af@linux.intel.com>
 <49a16c64-5951-f327-c12a-d3264353b74b@intel.com>
 <685b8be3-4ff8-5012-c900-8521c2772121@linux.intel.com>
In-Reply-To: <685b8be3-4ff8-5012-c900-8521c2772121@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 18 Jun 2020 18:21:34 -0700
Message-ID: <CAOReqxiTDafvSiUQFZuqhp1DYT_buaCp5oq01QDSgRm-YK57ng@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: haswell: Power transition refactor
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Ross Zwisler <zwisler@google.com>, Takashi Iwai <tiwai@suse.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Liam Girdwood <lgirdwood@gmail.com>, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>
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

On Thu, Jun 18, 2020 at 6:19 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >>> Pierre, your thoughts on this? This has already been confirmed working.
> >>
> >> I don't have any specific knowledge on Broadwell to comment. I also
> >> haven't had time to test this patch, I was expecting Ross to provide
> >> his Tested-by tag?
> >
> > Hello,
> >
> > Ross has provided his Tested-by tag already. Patch has been tested by
> > Intel & Google side both. Given problem's impact, this fix is considered
> > a critical one. I think we are good-to-go for quite a while now?
> >
> > Czarek
>
> I just tested speaker playback on Dell XPS13 and Samus Chromebook to
> double-check my UCM2 changes for SOF were indeed backwards compatible
> with the SST driver case. Well, my changes are fine but the kernel not
> so much.
>
> With a 5.8-rc1 kernel w/ the SST driver, sounds played through
> pulseaudio are rendered too slowly with clicky artefacts. Using the alsa
> hw device works fine. In some cases, the sound rendered by PulseAudio
> become clear again after a while. Restarting the UI and testing degrades
> the audio again.
>
> Reverting this patch - identified with git bisect - solves the issue on
> both devices, pulseaudio works fine again without any transient
> behavior. I spent 15mn monkey-testing and the audio quality was always
> good when this patch is reverted.
>
> I have no idea what the fixes were, but going from a somewhat random D3
> exit problem to a 100% reproducible issue is problematic. I trust both
> Cezary and Ross did test this patch, but could it be that pulseaudio
> tests were skipped?
>
We reverted this patch locally due to regressions and raised the issue
with Cezary on Github, we got no response.

Curtis
> 8ec7d6043263ecf250b9b7c0dd8ade899487538a is the first bad commit
> commit 8ec7d6043263ecf250b9b7c0dd8ade899487538a
> Author: Cezary Rojewski <cezary.rojewski@intel.com>
> Date:   Mon Mar 30 21:45:20 2020 +0200
>
>      ASoC: Intel: haswell: Power transition refactor
>
