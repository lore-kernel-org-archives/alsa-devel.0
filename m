Return-Path: <SRS0=57+Y=CA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB248C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:29:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409452078A
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S8UhrKyA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KLnDf3lT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409452078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C774284D;
	Sat, 22 Aug 2020 22:28:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C774284D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598128185;
	bh=boJjz+jCu46E2CpXDjcqR6qTauMlkH6rx5V65hLcJsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S8UhrKyAeewOewpaerFH71FMEdWsmWbYp3Ob40bTc6qZJwsJgRkw+lzgv9/t0+gKG
	 K+pEzOet/aGJuhkbrD9iVqsaKmA/tzaZDq+pABU/jRNrcJ8GgvHQgl+3Xe7/jQb6pd
	 R8jGD9CEhLbreOlL+TnjZS/DYclY1fVUhch9F9QQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58F24F801ED;
	Sat, 22 Aug 2020 22:28:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7C60F801F9; Sat, 22 Aug 2020 22:28:51 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C508BF8007E
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2020 22:28:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C508BF8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="KLnDf3lT"
Received: by mail-qk1-x743.google.com with SMTP id 144so4298064qkl.5
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2020 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=boJjz+jCu46E2CpXDjcqR6qTauMlkH6rx5V65hLcJsA=;
 b=KLnDf3lT1rW/K+Xy4REq848OKEALYpOEXxbPvGKCSsQ//nUyk4XQihPB/zTwAekZKj
 YmqMrSiY89Nnivscj0Qu5DsWfzoye5xK7XGQ/jBSDVxqelyDvzvPVwpSa+QpoaxC+6h3
 0W+CrIJ4l43HOTYaWdkhvc0pQEX1E56zQF6ize6X0YH63x7GXy2ZvtCNBvgUGxjdiM4E
 kczo5r4pMLapr6zzuWzDZ8Q21cQoMFILOISh6a2Dmz7OSoxV644+8MQQ7q/ukZhwKghC
 huXOm7H25VOY6wo3fS1IA4aIwWmgASzecQhnuCy9in6oGDA1kJzQhxreaHH1TyFv+jaY
 r6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=boJjz+jCu46E2CpXDjcqR6qTauMlkH6rx5V65hLcJsA=;
 b=iV7H+pGvG8Z4CqRtenJOQnPXzGxsDjMo6UyIt1IMDLFBJrsJVPo6pUMwLD6zzDBP/0
 g8yr9MKVU50/zEH9JHSkuUsPR8yrJkyeYp775OrMZWiUIIR+B84TV9nJvxT3AzQCs+7M
 PCORt9CCCwF9089NDB557m748hakcCOzJ5ifIUAmV8W4WwOdhK/285u39YrT6l33PjhV
 0oueinrA0GyKk09g8C7hymvt/Sfi6sCc+TxDI2EEgFbaEBZs/4S0HYU9nrfH0DmY76FA
 ftI1BgUXSAzFqRud5cn5Kg4CU+Uw4/JKZ0sW3zV42tAGmNRXhz22w8Fl7wZvIWxrvntv
 UaTA==
X-Gm-Message-State: AOAM530aSjt36NI39P+perXB0zEtGODECYsSWrkgAmdan6YdCYQPP8Jh
 YDFcarUOOf63ObgGbfx51TuFiSKMFZYU7cVYdsLXZw==
X-Google-Smtp-Source: ABdhPJwVGomdGSf8D28OBTGx2yJPIONk+pnyroGiGj3d2ix+qMr1SEIev/WwfqwwZizXnXkmYVJkFLm36orvauaxufg=
X-Received: by 2002:a05:620a:2489:: with SMTP id
 i9mr346545qkn.92.1598128126547; 
 Sat, 22 Aug 2020 13:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200820233205.505925-1-cujomalainey@chromium.org>
 <b98a8a77-7652-1995-27ba-eb7b6d30202a@gmail.com>
 <CAOReqxiS6TKxo7REebEs2R22Es1_kgzeq5OAhHONBZ6GYjeyWw@mail.gmail.com>
 <7160e4a2-886a-dc04-b47b-48ca8eff812f@gmail.com>
In-Reply-To: <7160e4a2-886a-dc04-b47b-48ca8eff812f@gmail.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Sat, 22 Aug 2020 13:28:35 -0700
Message-ID: <CAOReqxh6KeSOr2bsWzsQwCoe-inJPzHWMZdJvxDF+15of7ixuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ucm: Add JackSwitch definition
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Takashi Iwai <tiwai@suse.de>, Curtis Malainey <cujomalainey@chromium.org>,
 ALSA development <alsa-devel@alsa-project.org>
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

On Sat, Aug 22, 2020 at 11:33 AM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> On 22/08/2020 20:07, Curtis Malainey wrote:
> > Typically we use JackDev over JackControl, and this would add similar
> > support to what you added but within the context of using an input
> > device instead of an ALSA jack.
>
> Oh, I forgot JackDev was actually an upstream thing and thought it was
> ChromeOS-specific. In that case I can't really object to JackSwitch
> either.
>
> Still, problems with jack detection are common for people who want to
> use ordinary Linux distributions on ChromeOS devices and from my point
> of view it's "Google makes their things run on JackControl" vs "Someone
> makes PulseAudio etc. support JackDev+JackSwitch" to get things working
> out of the box in the future. I was trying to propose the former, but I
> don't know the merits of either approach, so can't say much other than
> that.

I understand that, which is why I am trying to pull our configs into
alignment. Currently we support JackControl or JackDev (I believe as
of january.) And I am gradually pulling the rest of the configs into
alignment. I think given the fact that JackDev is an upstream
construct we should make it match feature parity with JackControl.

>
> Regardless, I appreciate your work on reconciling ChromeOS configs with
> upstream configs.
Thanks :)
