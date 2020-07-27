Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D2C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:07:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB6120714
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qEo8nRS/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qBKAtwD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB6120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CA9916AC;
	Mon, 27 Jul 2020 20:06:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CA9916AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595873233;
	bh=LUdqfyFU6xFJ+aXP5Ie6AYv/UYPfG5AADQRbfL5MPgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEo8nRS/eB2rUq+ubfcJy6p4MSUWgLLdADXySo7uZ2W8VlaZg+qy6GSEeC4xm8hKJ
	 bgXhGmBblT9VZ5KCbjFm/5pXNdZTCmPQY7pyCJtodateIj/7qRRbIZ58LIAW0CKmdh
	 jTOZryC3AP4O2S5JUgKH4cOg2sLh3PYGcnu/p9pg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50B98F8027B;
	Mon, 27 Jul 2020 20:05:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8363BF802BD; Mon, 27 Jul 2020 20:05:36 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5186FF8028D
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 20:05:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5186FF8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="qBKAtwD6"
Received: by mail-pg1-x535.google.com with SMTP id p3so10249763pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3tJxZmEU+VW3MaXyB6CuvotPUBdLaj0rPzUDs5SstE8=;
 b=qBKAtwD6twbNxexGVNtZrdowrUkOD+6FU2vrhwHA4jJdVhzCrUwwMMn4KfW9JbzRWl
 5QSjGG+mvrIHXMekhITj8NioOaYgDqQECEYc9/ThHKc3lhsCctwz2vVZVbaDpe2xy7Ro
 AwcNKPCRxDbIQFPdCvnLhUWR4pr1uGzpt0aQTaLGjX0xhqG0UJFmaqBkRa3UYaCIW48y
 zMo2PD7TCFUgJgrcGD9dnRd8Vi2py2UfyPlXi8hU/DDNpWASjaGA4CTI6QfZMRxgrH5p
 vlh4ptBNuN+zAP4387uMmB2uP+6NwN+fJY2pUpiq2g0BEESXdwvcPSQj4GhKL0lFHF4k
 MHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3tJxZmEU+VW3MaXyB6CuvotPUBdLaj0rPzUDs5SstE8=;
 b=fEz7WSKI544ZJVEua+pxwqM8HrhUqRsUo3LVZumrVdQy7GpUWd5zh1RtqaW7UvjlUd
 8YKPNgAajgBRAv5IhJTcnU18OH+UeZl9mxjF7FgKLDct6mBvF8l2qPBTl4V2/9SEmi2p
 7usy4xZOr3SSQLfnfxKjB3nNALrDuCYe13F2dF+cYtuDw6FzZbenimfYTPVwNTCXlt4X
 q1ZugJ9QLyBf+m1lhE5yYooGC2teLd8j6WblrD9XvnekBJMQSVeCYCTNArHxzR/TzWMW
 NZydlTw7Og/o98QE6u2vsPz8n4ffF77co/eTrfytztsqV4N2tqjNHHiPHolb2xtb6ISw
 eutA==
X-Gm-Message-State: AOAM532triNRogMxN+o5S9gtoKWlggZ6jmNgq8mKYe5aHPlYchpNDXO3
 XXQUziuYCv7DMxzNe2q8vVsGY0HPPYMTtr8yVLglJQ==
X-Google-Smtp-Source: ABdhPJzRCJwD4U7l8FXKkO4K/jXPF0wskztDtI33xfMhoIPStjpMGSQLiQmDfQiNhZfMkCrruDjmr3Z42V96gzGxOAI=
X-Received: by 2002:a65:64d8:: with SMTP id t24mr21391884pgv.286.1595873123124; 
 Mon, 27 Jul 2020 11:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+wM6_3tS9Of8GDpxGBX=XqHDTW042=EYbmagFaZ0o228Q@mail.gmail.com>
 <s5hr1swj0p2.wl-tiwai@suse.de>
In-Reply-To: <s5hr1swj0p2.wl-tiwai@suse.de>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 27 Jul 2020 20:05:12 +0200
Message-ID: <CAAeHK+wu3WvODwA_33uPDdFCtipeQWuitb_EDXOfDNO_RGYnvA@mail.gmail.com>
Subject: Re: /dev/sequencer descriptions
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

On Mon, Jul 27, 2020 at 8:02 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 27 Jul 2020 19:47:54 +0200,
> Andrey Konovalov wrote:
> >
> > Hi Takashi,
> >
> > We're working on syzkaller descriptions for /dev/sequencer [1], but
> > have some troubles understanding its functionality. The main question
> > is: is sound/synth/emux/ code reachable when tested in a VM (we're
> > using QEMU with -soundhw all), or does it require some specific
> > hardware to be present?
>
> It's for Creative SoundBlaster EMU chips, and it needs the specific
> hardware that isn't emulated, so far.
>
> > In our setup (with Debian Stretch userspace image) we have
> > /dev/sequencer with SNDRV_MINOR_OSS_SEQUENCER and /dev/sequencer2 with
> > SNDRV_MINOR_OSS_MUSIC. For the former, there are no synth devices as
> > reported by SNDCTL_SEQ_NRSYNTHS. For the latter, synth devices are
> > there, but the load_patch() callback is not reachable as this check
> > [2] fails.
> >
> > Is that code impossible to test in a VM at all? Or are there some
> > specific kernel options/drivers that need to be enabled?
>
> Another possible device supporting the OSS sequencer is the old FM
> OPL3.  But it seems also not properly implemented in QEMU (I see only
> OPL2), unfortunately.

OK, got it, thank you!
