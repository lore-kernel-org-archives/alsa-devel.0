Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22660C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:49:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1A120714
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mw0sTXMg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cvU1zYSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1A120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C8F31697;
	Mon, 27 Jul 2020 19:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C8F31697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595872146;
	bh=LSJU3X5A9YcZD/wAGRBlsn4lUm/2qrC4q+4OL1NgTZ0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mw0sTXMgmKcfuiEAEiDqkFfmJM/xx6AZ5WEZ9GwxEsBzrwzNOq44BpOYwFt6PGgYo
	 j6NhBWHXE2Ms6crqsFSEqy0Ard2C/0bBc0v+NmAI+MXLw2lULvc+0iMKBN7fIc67cd
	 lwGWvzN5D4OR0XKWw6rNyB+3xX6mKNmhDQIFjHYw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C36BCF80158;
	Mon, 27 Jul 2020 19:48:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5771F80171; Mon, 27 Jul 2020 19:48:14 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 726FAF800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 19:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 726FAF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="cvU1zYSn"
Received: by mail-pg1-x52d.google.com with SMTP id l63so10198191pge.12
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=LSJU3X5A9YcZD/wAGRBlsn4lUm/2qrC4q+4OL1NgTZ0=;
 b=cvU1zYSnBLaWSbLmsr5/VkSuyl3IzBzi+JWK4FHRmlLvPuIvH2dNmX0vTxEJfrKJ43
 tX4Sebvg2jzc5nJqSSgLIdy2D2AvGilRpYfaqv4Kr+1B+tK3AyvIMmykOItpqAG5oOWR
 aMwWg9CRE7253Agtw6gpXQgxES3nu8OWozOR/FIK7i/CAKanpBLTkyt4i9Ny+UHq5Yah
 YLh32w5ccM/96IKjaW73x4nKmfXWehzwwMUh2SJ9wBMy9mqQt6ooQHeuj6dMeJ4JdlNL
 qWs4UDHAwPzl1pX8QUW+v8N2B/14rQCR2dxjAhn5Jlm7CPwfvc03nvX5Ibta88aaxMg1
 UhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=LSJU3X5A9YcZD/wAGRBlsn4lUm/2qrC4q+4OL1NgTZ0=;
 b=ppsfzwY+EP+ze3bjmj/IEz7HY/eg1jnzYclfVZEdmZ/pmKVAIU7VF0/fOYh9PhgWjY
 mp2COiwwOapQBDtrGXv3NSrEPR+tETq1vFhPvO9IMpL3YSGD8yM7v1JyVspA5I7a6P2m
 IXeO6scWJZyNqAa8rUgx+q+8CL6kY41U8q3A522dajiNUJKwHp8mnJ8QL1R52NRRN27/
 jbwNhPfdCHqV/WiRDKeZMWldIvUlJUq5YR7YXmVCV5RVppASG7Aao/Pgak9uN2CyKeMO
 uNpbtG86Z68HKhvqNRxFUA1TurNTsbU7Rzc++z0ylwn/FtaG1jlzmzcQR+D0XiwbQCHR
 +QFg==
X-Gm-Message-State: AOAM5327iBqp7vji6HAb3D67lgg1fwNbWCWplga1NBCZIb6jsOMRjCRF
 k/tc9hFsW1ND1eQxvjxKNMEvAEeGo15WVRj3+wcFmw==
X-Google-Smtp-Source: ABdhPJxdY6ON9/mRPO49l2bxNq7NSlaofKRFaGXv+4CGVL78LNl6z47HFLDdAa8UCDbsZlixv4QX6wDYpvVD9uTQaiI=
X-Received: by 2002:a63:2241:: with SMTP id t1mr20624120pgm.440.1595872085215; 
 Mon, 27 Jul 2020 10:48:05 -0700 (PDT)
MIME-Version: 1.0
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 27 Jul 2020 19:47:54 +0200
Message-ID: <CAAeHK+wM6_3tS9Of8GDpxGBX=XqHDTW042=EYbmagFaZ0o228Q@mail.gmail.com>
Subject: /dev/sequencer descriptions
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 Nazime Hande Harputluoglu <handeharputlu@google.com>,
 syzkaller <syzkaller@googlegroups.com>
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

Hi Takashi,

We're working on syzkaller descriptions for /dev/sequencer [1], but
have some troubles understanding its functionality. The main question
is: is sound/synth/emux/ code reachable when tested in a VM (we're
using QEMU with -soundhw all), or does it require some specific
hardware to be present?

In our setup (with Debian Stretch userspace image) we have
/dev/sequencer with SNDRV_MINOR_OSS_SEQUENCER and /dev/sequencer2 with
SNDRV_MINOR_OSS_MUSIC. For the former, there are no synth devices as
reported by SNDCTL_SEQ_NRSYNTHS. For the latter, synth devices are
there, but the load_patch() callback is not reachable as this check
[2] fails.

Is that code impossible to test in a VM at all? Or are there some
specific kernel options/drivers that need to be enabled?

Thanks!

[1] https://github.com/google/syzkaller/pull/1952

[2] https://elixir.bootlin.com/linux/v5.7.8/source/sound/core/seq/oss/seq_oss_synth.c#L452
