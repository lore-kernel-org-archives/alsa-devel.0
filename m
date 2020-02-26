Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DDC4BA0A
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:27:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E13C222C2
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZpOboZcR";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR/nn1iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E13C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0912166D;
	Wed, 26 Feb 2020 08:27:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0912166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582702075;
	bh=TakMUQM3MxvwBfi/91yDf0iEq1Cx4adF0aU1JkNd+yo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZpOboZcR8cFlr+6qqaBKsIqQNoS8t+FlnhPbl9PmfA6YrIfglQ/Zq76BVcz4dyK4G
	 OdwF14Pk4jBC5AQ9Er1bciYQ8wndoFJbIsamYktUS0Pu4Hw76nGjx24lNbc+JVmoKc
	 uvnCTp9BdgSiB0uAPl8fViZu0Mp4CUqWxcF0xOw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 351D9F8014D;
	Wed, 26 Feb 2020 08:27:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56A09F8014E; Wed, 26 Feb 2020 08:27:03 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63E86F80089
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 08:26:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63E86F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qR/nn1iX"
Received: by mail-il1-x141.google.com with SMTP id p78so1499943ilb.10
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=oBD04HfpWsFm83WdJsnByehk/7XwoghwM2hIXyz/zvk=;
 b=qR/nn1iX2iVwOayqps9ZFtfly7arHhjp3p6T5EyxGSwIzIy9qsetYuYcsyA/c/eaot
 Htvq86+sQwzokMoCdLGvmlGrVwN/UNfUpNTNEk8nTJrtOXC0Uu5jguCw/8ALUD3JMQKF
 Gdp3lFhpVV1FDqQ1H3PENlND3ZAvfBwbDkMezXCRX3ZRKdxDlvpccTHqmzQz8c1+7Jb5
 TMcKne+qGGt+TtB+KDCpAV/xkqNpuiuOkntU5YSHYCMqpv2MPYX9si5v4en4YoE1wKpH
 SqWayqEcwJ+Z9NMPdfXZmsA/4p1V8bOlDYgwfjLTmKgqgQpI4z0hXb3aqiMWa+npYRC5
 A4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=oBD04HfpWsFm83WdJsnByehk/7XwoghwM2hIXyz/zvk=;
 b=pqUo7T04NNPmGb4RXDJewVzdnlChwMCWFscND7DfjVbf9g7jJU/qR/8UFdu5kOiUez
 KWPy+BtF/WhqE+alFnnZ6LS7TGeUBu8LNDGKYQcqS0U74H4xPGkprCxMBi8OZwtXnlg1
 LOppnXZO9TZn+yDyvPqXUlLb6euhmUQKbBUsCyUaZstxZyO0u+iCpd8iE1JSuhhq8Lue
 3pJglCm1jt1c6MnB2zydgUxIppNpHOjUaevIf1d82qCqSMAfmMb4EpO5oQpyzRoVWCyF
 Sk45eBJlqMky8etVWC07oARl6OARRRjEqShghx9v/V30xU1r/EAL0cjyipC7fsoYvPew
 1K3A==
X-Gm-Message-State: APjAAAWw7PZ2B/5qrE6IIMmx+1Vv4NMmSgDxd9j0xlawoLjWEG3ml0Sv
 JLjHYr5x+0oJ3MqQ5mdkgPOB0JrGwiy+siXQ612528FIs4M=
X-Google-Smtp-Source: APXvYqxpRsOt1yIWaXmLgFtz4E7w7jQwtpfU9Y9NtJUZSsJSlFm5Vo2C/K64e/uzRSKffvUpG58iSbhw3WkF97Mm2sE=
X-Received: by 2002:a92:c111:: with SMTP id p17mr3043033ile.204.1582702018006; 
 Tue, 25 Feb 2020 23:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20200223092416.15016-1-gladiac@gmail.com>
In-Reply-To: <20200223092416.15016-1-gladiac@gmail.com>
From: Chris <gladiac@gmail.com>
Date: Wed, 26 Feb 2020 08:26:46 +0100
Message-ID: <CAE3uWP254FLRPLRTES0Zg-ASsdLBA0wb0BdAvBL1hPVNv-MyfQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix silent output on Gigabyte X570 Aorus Master
To: alsa-devel@alsa-project.org
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

Hello,

on Sunday, Feb 23, I sent a patch (Fix silent output on Gigabyte X570
Aorus Master) for a sound-problem my motherboard has and made the
mistake of not registering to alsa-devel beforehand. As a result, my
mails are pending for approval in mailman and wont show up in the
mailinglist. I did the registration now. Can someone please approve my
previous mails or should I just resend my patches?

I am really sorry for the mishap - it wont happen again.

Greetings,
  Chris

On Sun, Feb 23, 2020 at 10:27 AM Christian Lachner <gladiac@gmail.com> wrote:
>
> The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
> requires a similar workaround for Clevo laptops to enforce the
> DAC/mixer connection path. This patch sets up a quirk entry for
> that. It was tested by myself on my own hardware for some time
> and it works just fine. We should probably rename
> ALC1220_FIXUP_CLEVO_P950 at some point as the amount of
> non-Clevo hardware needing this workaround is growing.
>
> Christian Lachner (1):
>   ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
>
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
>
> --
> 2.25.1
>
