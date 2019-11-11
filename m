Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E580DC17441
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5516222CE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L0kAjL2Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rpG+G70X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5516222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D10321669;
	Mon, 11 Nov 2019 19:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D10321669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573497800;
	bh=VR/uo0/3COFFxpsEvLTJjQfIcz0L18j0CEftwfGTGvo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0kAjL2QWTgVqfqZqSj3lGPQACEbDGQzKdbgV0SChV6U3OUTEtjfcJuzNmOSPCBw1
	 63sAHqptntLpTmnoeNqbyrHREFElM7vLgUurHcvQ3rxAD3CsA/XP/UdtaP2BtrIXZ5
	 x/0ABsHJcSyM7hTJLnjWSCEU24PbH0fU5bcvZT2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57BD6F8045D;
	Mon, 11 Nov 2019 19:42:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70934F804FF; Mon, 11 Nov 2019 19:42:28 +0100 (CET)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96CA6F8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 19:42:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96CA6F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="rpG+G70X"
Received: by mail-qk1-x741.google.com with SMTP id q70so12045098qke.12
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EdfH8VcEqLj4288SgDtrT6pVzOWilOOSs21HeOTR5IA=;
 b=rpG+G70XBGLin4IDD5GTOFodjTP6N6YQCoywGaEY4QtKwswkfexiRQpejeZSOnnyRV
 xKtQh8bPQYtbv9ZNWN4/MkR0iAO1oRTp/XVQi8vhPSLxj2fCPdzvOmnsrw35vijAeo36
 XZ4S2H3psOpT/wtsu/j6DvQoVki7d67KLfQmIeB++YR0l404aQKw98RnzKn816wc1a3S
 HJx+cPi7Utmq5cmW/QwOgEupJ4KhlBJ0I5BvDUewqLg2FtoKiJQdtmDd+M3jIODgRtII
 Nje1BNIbEucqYbY0bBeGHQt5DfJdCBVDUth/A2rCp+0I9FGhc4Yy6f328UpOC1ICOJe4
 o9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EdfH8VcEqLj4288SgDtrT6pVzOWilOOSs21HeOTR5IA=;
 b=JvIn9GVR17QMUGy3eeInxwldCeXR/MExNfqDhInTHetv/gw5wTaNfX112gpcAdGDIE
 s/tQ+wGKF9IahAGohbS02BdoMbpFybK8vFLHjhyqk2leEkEZv5OjmN1vIT4pjywuYZ2C
 8tvV9pITykd5FyWPvixJEakVWWK1r4SLQBfr4Y7VTEcnElJ0+m5veN7B3vY+7g/+whwG
 A27f0uqvtdLQr9AU7+VWmWg0cQvYXVFL+qzGpTMhYZK0tv7Vl0wl3+wk5utFFYs2f2sY
 Y2f0SvYRc/YjNloUIb7BPRVWRbcuLYG5Hgu6tl2wH1zMuN52JU5//zwhZyxj7QbIg3wl
 Mhrg==
X-Gm-Message-State: APjAAAX5y3pY7eEswML/fEwrK9HLw9fPOWGI7YzD4KnY6slJ3K+idWlH
 bRITPRwWCGvWVf6By/vJ7biiLjMbNEJxca2s8jhLJQ==
X-Google-Smtp-Source: APXvYqxVyBIOK78HN907Zq9obmEJibeTLG7WMGf3fXIyPWcxmr0Z4XPfrThiPqgQNo5cmrsTFiCGgj6iylrl5iP36X0=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr11385855qke.92.1573497743331; 
 Mon, 11 Nov 2019 10:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-9-cujomalainey@chromium.org>
 <6eb3d595-d5a9-5749-32b7-77ba3a56aa3c@perex.cz>
In-Reply-To: <6eb3d595-d5a9-5749-32b7-77ba3a56aa3c@perex.cz>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 11 Nov 2019 10:42:12 -0800
Message-ID: <CAOReqxjs_R1r790swzyGyWfuNDW=B3bpeYxQwFA-53aZ_77Cew@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Curtis Malainey <cujomalainey@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 09/11] ucm: docs: Add EchoReferenceDev
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

On Mon, Nov 11, 2019 at 7:36 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 07. 11. 19 v 2:58 Curtis Malainey napsal(a):
> > Sometimes userspace may want to use a reference channel to cancel echos
> > when using video chat, this value identifies the device which carries
> > that channel.
> >
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > ---
> >   include/use-case.h | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/include/use-case.h b/include/use-case.h
> > index 9a10f390..e84f3f8f 100644
> > --- a/include/use-case.h
> > +++ b/include/use-case.h
> > @@ -308,6 +308,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
> >    *   - CoupledMixers
> >    *      - Mixer controls that should be changed together.
> >    *        E.g. "Left Master,Right Master".
> > + *   - EchoReferenceDev
> > + *      - If userspace wants an echo refence channel this value identifies the
> > + *        device to be used.
> >    *   - EDIDFile
> >    *      - Path to EDID file for HDMI devices
> >    *   - JackControl, JackDev, JackHWMute
> >
>
> It's PCM device name like PlaybackPCM ? I would rename this to
> EchoReferencePCM then.
>
>                                         Jaroslav
Not quite. The name associated is another SectionDevice.
Although I will have to send a v2 for this patch as I noticed a typo "refence"
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
