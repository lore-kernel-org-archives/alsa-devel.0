Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA9EC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:34:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA23B207DA
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JLz+KlbG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svUM0Ptl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA23B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24D911662;
	Wed, 12 Aug 2020 13:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24D911662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597232045;
	bh=w4SJrTHJm69aFnEmeaqXnWMvGfZwawWzB0kCD/BpImc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JLz+KlbG+RH9TgO26kqWB1fDLKpBrk6V9WWXmfXtcoSUlUgFKes0ahGl7GBzxB7sG
	 xNHxKrmviDelpqHrunP2JDeV+eAYdlIFqOdt8eOnI4ANCToBJMdZdopXWWs4OvTjU0
	 1gsxGrkXJBg8kj6k4bQfvbGpQ46zgDCFEgfNept0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86F6FF800D3;
	Wed, 12 Aug 2020 13:33:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFBA2F8022B; Wed, 12 Aug 2020 13:33:12 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32DC0F800D3
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 13:33:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32DC0F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="svUM0Ptl"
Received: by mail-ot1-x341.google.com with SMTP id r21so1610967ota.10
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Em9Sp8XmzIpv/p2/XIEVSGX1+QelGDXMy8mBEoKzQGA=;
 b=svUM0PtlSc/BsJ398hEypGo/dtDceKxpkxJL2XapJiufbso1e8LfFI4bXYobnoySJa
 SRjvv9f/48b5GJPA7fHwECXPGN7eO/ub5qQngsk3EUO83vMzAXxkqcbbp5j1xemvZIq9
 s5mftpWisvt6SbOmNG3lr1AFiu06MFhrdLN47I42cpfWHFnGFPC0kmoM7pnxUZpSyLQj
 +N4Js6sN6aumylIuGGMt2QsXP+hkf1Ol4GBV8Uuo8S00kvpt2DD1ugHsd9sXoZ13vg/2
 3wLqiAgbMsq3tbjK6M6brM8AX2Uig0dYIzJF4KNHkRmKijkDxBWgQ34F0o2mtUai8o4g
 hCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Em9Sp8XmzIpv/p2/XIEVSGX1+QelGDXMy8mBEoKzQGA=;
 b=p0rgMMZ3dogZMctLPbyiqbaLat4qqe+cqA1WzvI8Bin9X/k0CaQlIKXKSZLvXkrMgY
 sGb0Jq8c5BtIene2fS390KCijqQ0Gm7RugUyIIL2WM348fIObZKO3ru5qmG6hlFRcpU7
 UfQmM3naIorD2U8a6kuqD75J+JsTNoVdDZMA/rAscSQXwlH3couUWwx8cy/iBiTUFSxd
 CcJgaa/ozy2mP05oMvYaj2qReWT5bPb4Oxql98jviKlC2vsvKzWPHTArx76HKM7WkTDr
 sYzyRrifaBx0UaLZ8z2/2xLkGPHFEXZ0tLqfXBmPgraRT7t15Uu6Ke3N3p1kJXPl/u8X
 JdhA==
X-Gm-Message-State: AOAM531ZVnDwSw9b51nf2WRWbUSIqn3v0lUUeC38XnbHa9y+k54FVl+x
 /6CpL9wYt0/dikztfxLRQR19voHUnWFxpfoKgN8=
X-Google-Smtp-Source: ABdhPJyApW1cAsqfCZE8viTLCHhX3eA/ksSTGjILeL6+zxKJ5TOuIeeZt8iyPAiUApQEScansB5N2ki5ANp9kIXSCiU=
X-Received: by 2002:a9d:128c:: with SMTP id g12mr8585420otg.242.1597231982871; 
 Wed, 12 Aug 2020 04:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook>
 <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
 <202008111427.D00FCCF@keescook> <s5hpn7wz8o6.wl-tiwai@suse.de>
In-Reply-To: <s5hpn7wz8o6.wl-tiwai@suse.de>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 12 Aug 2020 17:02:50 +0530
Message-ID: <CAOMdWS+FJm0NZfbj+yyShX2edX6_9w5K+rA+_u+Z6-rrjcwucg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 alsa-devel@alsa-project.org, Oscar Carter <oscar.carter@gmx.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>,
 Romain Perier <romain.perier@gmail.com>, linux-input@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

>
> I have a patch set to convert the remaining tasklet usage in sound
> drivers to either the threaded IRQ or the work, but it wasn't
> submitted / merged for 5.8 due to the obvious conflict with your API
> changes.
> Each conversion is rather simple, but it's always a question of the
> nature of each tasklet usage which alternative is the best fit.
>
> FWIW, the current version is found in test/kill-tasklet branch of
> sound git tree
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Great. Currently my tree has these converted to use the new
tasklet_setup() api. I will add these to my threaded IRQ/work tree
(which is still wip).

Thanks.


-- 
       - Allen
