Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD9C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 10:33:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F2D2312F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 10:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F2D2312F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C069166A;
	Thu,  7 Jan 2021 11:32:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C069166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610015609;
	bh=DpBoN1LVXmETXjAE31rnLADbsPY1LgdG1c5YeXrFgCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MleuJAPPt8/X8VXJFBtYHL3I9VzJFG6RFH7FvnYC0umWih2wUOaX7IME6INoGr1+o
	 iCbNKbUoxqTDx5mMQAqgWhwLUYDuQ1RD1n47wo2CAv3TOPk/pnTQ1BmDUdSqi9uw/Y
	 U1uLqAQ2Vya4lwdEkKOSYIw78zOyWlI9Hh3fW+g8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAA14F801F5;
	Thu,  7 Jan 2021 11:32:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6456EF80271; Thu,  7 Jan 2021 11:32:35 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB624F800E9
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 11:32:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB624F800E9
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1kxSac-0001fp-P5
 for alsa-devel@alsa-project.org; Thu, 07 Jan 2021 10:32:22 +0000
Received: by mail-lf1-f71.google.com with SMTP id i21so5724013lfe.14
 for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2021 02:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D/Y5buNtMZu8paZ5pdJK7XpNPN8q/w0jqWstP/iLbT4=;
 b=abnqx/xpu/leMu7S76+gSZ+uJJKiYNbntzNBVLFELSuawmweLk5gklcFXJlGpf7BOI
 qzkl8LGrJlqc8uYhu8K+Mqgbu0CfjXupBD/7fNLaFvz2AOnlojQBJYLK4zK3CfNKvD+z
 Tq5UWBmwNM86ooLYkylmNkijHcgUhq3QoO5pCumOeBkjF4AFyn9/+HQeQSq8BIJwwyWJ
 G405WQ5X8UB0QY91Qu8wOwgwB3Pot9CUp54KQ4mTycp+YAEFap2W3gHvPXjoIaY8HUGa
 NjmZNrHOl7vtO+zxQivlCylSLyObQgLPXpftNRPyJRqkwPN1J+dmTl19dHkMJ9at7gm1
 ePxw==
X-Gm-Message-State: AOAM533VAh8rwLz9TPdz+gOAwTw01wE5uUMqw7FFB2+3+vnU0j+DSxdF
 D7t1v3tQZYd46CNWFwibmNQ71Qa00T/gV32mSMm89roDDFJmxniN6dYcSrtnQAsY8qdmxNk8WX7
 VVXcmxwlS0DmcD0kOagJPXFm3gIlvPfWtT3BG8Q0M08rsIcoRe4LGzvzO
X-Received: by 2002:a19:dc5:: with SMTP id 188mr3947117lfn.513.1610015542155; 
 Thu, 07 Jan 2021 02:32:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvjI7EOWLxlJykcG6C96lN66Kbefk0r7+QFwEUXJQvjuBr5gTp9PCQ7STZfkhNmOn0+mGm3OC0x4+P2PVAzZA=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr3947096lfn.513.1610015541825; 
 Thu, 07 Jan 2021 02:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
 <20210104140853.228448-3-kai.heng.feng@canonical.com>
 <alpine.DEB.2.22.394.2101051354300.864696@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2101051354300.864696@eliteleevi.tm.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Jan 2021 18:32:09 +0800
Message-ID: <CAAd53p7JvPAYt3NGQU-cCEDtLaL8L+vBoSyYbYSD-bkKS-g50g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Marcin Rajwa <marcin.rajwa@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Keyon Jie <yang.jie@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>, daniel.baluta@nxp.com,
 "moderated list:SOUND - SOUND OPEN FIRMWARE \(SOF\) DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

On Tue, Jan 5, 2021 at 8:28 PM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:
>
> Hey,
>
> On Mon, 4 Jan 2021, Kai-Heng Feng wrote:
>
> > System takes a very long time to suspend after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
> > [   90.065964] PM: suspend entry (s2idle)
>
> the patch itself looks good, but can you explain a bit more in what
> conditions you hit the delay?

If both controller and codec are suspended, I can 100% reproduce the issue.

>
> I tried to reproduce the delay on multiple systems (with tip of
> tiwai/master), but with no luck. I can see hda_jackpoll_work() called, but
> at this point runtime pm has been disabled already (via
> __device_suspend()) and snd_hdac_is_power_on() will return true even when
> pm_runtime_suspended() is true as well (which is expected as runtime-pm is
> disabled at this point for system suspend). End result is codec is not
> powered up in hda_jackpoll_work() and suspend is not delayed.

On my system snd_hdac_is_power_on() calls hda_set_power_state() which
takes long time to write to (suspended) codec.
I am not sure why it doesn't power up codec on your system.

>
> The patch still seems correct. You would hit the problem you describe if
> jackpoll_interval was set to a non-zero value (not the case on most
> systems supported by SOF, but still a possibility). I'm still curious how
> you hit the problem. At minimum, we are missing a scenario in our testing.

The issue happens with zero jackpoll_interval.

Kai-Heng

>
> Br, Kai
