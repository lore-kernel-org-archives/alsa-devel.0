Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F3C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:51:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197062088E
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="emTmD5nZ";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG6hsiFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197062088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93ADB1840;
	Wed, 24 Jun 2020 11:50:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93ADB1840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592992283;
	bh=i01px3Vuayzo121kyLDtsm9qpE7YLnmGfsoremYpDlk=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emTmD5nZLl36tpQIvMx4hdZOigUWsiOpLUlIPvKwcxu81t26CqWpDZgrAwR4CNYbs
	 Ef8wU1gZPl3TElPBxAoMk3olP+izYhoHfl2W6HRj58xIY1ARn6V1QsmBnbajIgA4m8
	 Vnk71pzMX4ZXN8KKQ0Qf+LFzVVIIZdBDzEGCB6no=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19E75F8015A;
	Wed, 24 Jun 2020 11:50:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1AEDF8015B; Wed, 24 Jun 2020 11:50:30 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92F70F80084
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 11:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92F70F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LG6hsiFA"
Received: by mail-io1-xd32.google.com with SMTP id y2so1450743ioy.3
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=i01px3Vuayzo121kyLDtsm9qpE7YLnmGfsoremYpDlk=;
 b=LG6hsiFAEb5bTM4394p1e0vDcob4HMi09Vp/7gCZybNfGF+wV+OuCFlFDAEKTCFVCc
 KRaRskoHmwzJ9tQzUfJsMiJE1T3gi0rLJmO5ivwxKAlkEzq81noRy/S9JJCYvZcZwgth
 NuPwCkz2BoaahzXM/bzK5JznFK+67/sW55L5SbeBizGwi9zNsWpepjZDWcPmLCeUwyX8
 5L1vJxiilWT3u4t+DElncC+qbG2UPjMcccB2zlAMTnraoXWgTETv5tEl1tPKey2OWzdO
 18triWyvRQm+Htl3gazYJMWP8mAprlKF32lT+WUyUUNz8bEN0AkeWRg3VAtvSk9yO29+
 0Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=i01px3Vuayzo121kyLDtsm9qpE7YLnmGfsoremYpDlk=;
 b=F1GRCmvPzwpONDSav+PpkpGPDfYnIyacZjeK+aSwKh406fAG09UU3wOnNPIGmkERor
 8RAeB+ENCibwcEcHQtT1WkVnsUN2vmfjB/8hQhVDA07bJ+5IuLw/d34yzoxAVqNWg7g3
 YNRxj9l/ezFdntW702Ph3QqYvBXAzDtvkkX3ZAL3wKqqejHqfWU149lpD+3TInmbO4n7
 qQtyv/iQYNJ7sJnNFmNZINv6PfqoFUSO/fwvRTPS5QW1UYNaY4NI0COFYDCe32tf7vmx
 Va7hwR/Sr5/4Bd2K0Ff/tu1sjqJ+YaQ6Ry2EsYeP8Eu1AYOyfX9dJCVj1kpdXaFyr2Sd
 JgBA==
X-Gm-Message-State: AOAM530Ki0vJOVSiChnQ/3L1y82c7eSGcrwsc/omTzF7aPMIcLM0Kb+U
 qZWdyNwrOMEaVjaBY/zq5PLD2M96KrjM6sVfjU4=
X-Google-Smtp-Source: ABdhPJyySuy9ApKV3weFE1PQmtcJv7Ocixo7pgfEBf5PDD/Lneqrd4MUHVlbd6FBUof+hSgszg3MPvDn2MQ4X/Fd6EY=
X-Received: by 2002:a6b:bb43:: with SMTP id l64mr11534920iof.191.1592992221999; 
 Wed, 24 Jun 2020 02:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM+SccvqTBR68b_a=a__BPN2+XCqjCGSCoGBKGqRZLV5Q@mail.gmail.com>
In-Reply-To: <CABXGCsM+SccvqTBR68b_a=a__BPN2+XCqjCGSCoGBKGqRZLV5Q@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 24 Jun 2020 14:50:11 +0500
Message-ID: <CABXGCsOB7DZSCC5M4miPdi9PXSRUbQRiMxrnwi3QBFhkgetFAg@mail.gmail.com>
Subject: Re: [snd_pcm] [5.8RC1] kernel BUG at mm/huge_memory.c:2613! (system
 stopped playing sound)
To: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 22 Jun 2020 at 10:26, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
> After upgrade kernel to 5.8RC1 (git69119673bd50) my system stopped
> playing sound.
> In the kernel log, I see the message 'invalid opcode: 0000 [#1] SMP
> NOPTI' which probably related to this issue.

The problem with no sound was fixed after RC1 git 1b5044021070,
but all my USB headsets (ASUS ROG Delta and HyperX Cloud Orbit S) play
sound as if in slow-motion.

Demonstration: https://youtu.be/-1caV5Yn85E

And RC2 git 625d3449788f does not solve this issue.

dmesg output: https://pastebin.com/d5Mb2Z2B

--
Best Regards,
Mike Gavrilov.
