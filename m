Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3BC63777
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 20:10:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A83D206DF
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 20:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sm9BegfX";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpEwgLwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A83D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB67516FD;
	Mon, 30 Nov 2020 21:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB67516FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606767030;
	bh=953VCQcr4k1EowvwT627lVRBs/xV9mZx25kvX80TidM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sm9BegfXNOa68zJP931ENMdZSXFH0S+4H/rmCnRMFVxtydixon+TXZeC0qUTR/9n0
	 KOrJUqdYjJYBmOa8XXFOoyCt8cHs9DF30S6grQD7X9B3hNfLHNu36y9seGFDXp3xzd
	 B/0wZmT8OqNmNaaYW+4SJfw5EEcXc3ew7Qo94rWU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C1ADF80254;
	Mon, 30 Nov 2020 21:09:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14816F8025F; Mon, 30 Nov 2020 21:09:39 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35DB0F80146
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 21:09:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35DB0F80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QpEwgLwK"
Received: by mail-qv1-xf2e.google.com with SMTP id ec16so6278778qvb.0
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3uvhuMHkUig4cWE4qSBrVjyp2x4n5TblgmrS/d/iioQ=;
 b=QpEwgLwKBeU5n8jf6qhzRaLTXybUBQTw9ghcltvrvn0pJNxzTJnq1juRSBXaJY99NW
 UeqMQG8qI97WHUiWVPrXurX6j5Qt4vaTLWDXKPbQYFpk3XjWHw7BqdPqzq/zLhqexuAE
 NbLf0f+0fZn+RAUIzLdRIbHOfFldgZrLd3KuC259QfKV5MzZT1lOfMYE7M+nk8NvkFV0
 cj0QYZTM4bJ+Utd2CO4U/A/uTnwUYcBT6+6FH+6bqA88yPh1gsch9tgvuvOhCL2E/XHN
 G0Wge6HUhZLZPOhpEpgOf6LQLQgETlwSp6/B9zZeG4xcet4Xms9/fdULOgDUz4eSt/5/
 BJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3uvhuMHkUig4cWE4qSBrVjyp2x4n5TblgmrS/d/iioQ=;
 b=Z/In9pbIlJuHWsQc6Sh8JMEX2TafiZVXpuK94+63s8rsKk/eI3lJA0caaJ5mn1fpEt
 TFo2TAAN7raWxtaLqLCjgU+SqUV9Tv0b67HP+Kz+Yc7l7sQ/PLUDh24DcXFC8zKKZMld
 f7ZT3dvUAIevKwK3TRH+G8YIZQJ4twr3M4YOpq97C7/V5zj9dt9BBcIgC+xrHAI4xdPP
 valSokEilsf7fS756yqGOQsZMxe3uIr/aopwCFs7J2emJvlnp+wV0UlktOx8VS+RwESa
 k/fPbu/9O5PuxVBEJqZdjdjw3l8/o+lxFsU7FeEsupGvnUe3a2nhq1wcJjhAOD6ql+Zc
 ooSQ==
X-Gm-Message-State: AOAM531BGbE4ev/w0LN/+fPdiw7tnKmkMp8bjQ/0I2OF5j1l/ychIgLz
 B0kQWY0Mh+sTK5OS+XXHar+Fa3liZ1/FJ2lrFvU=
X-Google-Smtp-Source: ABdhPJyWNxv5EWImq12WTZD+zj3CX/LhHFlUJygSu1BcFtuMX4Kb7ncAm0LlIu7h6y0DmNqvGgxzZIp1Bpa68LECQU0=
X-Received: by 2002:a0c:ec8c:: with SMTP id u12mr24475337qvo.53.1606766968456; 
 Mon, 30 Nov 2020 12:09:28 -0800 (PST)
MIME-Version: 1.0
References: <CAGvD0_bewR3v4Pa+9f4XLGMreVL9cx6BNj=GXWnUN2XJuG9r5w@mail.gmail.com>
 <s5hr1oaeq8l.wl-tiwai@suse.de>
In-Reply-To: <s5hr1oaeq8l.wl-tiwai@suse.de>
From: Soham Sen <sohamsendev@gmail.com>
Date: Tue, 1 Dec 2020 01:39:17 +0530
Message-ID: <CAGvD0_YjY74O2DraQ3cmONC-+QuVKM_Sra79wTbKNpxs4=RAFA@mail.gmail.com>
Subject: Re: Mute LED not working on HP (Realtek ALC245)
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org
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

> > I've been trying to debug the issue related to the microphone LED not
> > working under Linux. I've confirmed that the LED works in windows.
> > Seems like most HP laptops have this problem, and they are fixed by
> > adding a model= parameter, however I've tried all HP mute LED related
> > models on https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html
> > to no success. A very similar model to my laptop, running Intel HD
> > Audio can be fixed by using model=hp-mute-led-mic3 but this didn't
> > work on my laptop either.
> >
> > Can I get any help on how to further debug this issue? I tried
> > searching for the documentation for this audio card, but wasn't able
> > to find anything useful.
> >
> > Output of alsa-info.sh:
> > http://alsa-project.org/db/?f=4173cebd458b6badbc21668461e9ba2e890333c2
>
> I guess you've already tried to pass the model option, but judging
> from the alsa-info.sh output, you passed it wrongly.  As the onboard
> analog output is from the AMD HD-audio controller that is the
> secondary card (while the primary card is Nvidia HDMI), you'd need to
> pass "model=,XXX" (see the comma before "XXX"), i.e. set in the second
> entry of the array.
>
>
> Takashi

Tried both, actually, but the result was the same. LED won't turn on either way.
