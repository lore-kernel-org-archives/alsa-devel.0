Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3DC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:58:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C00660F35
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C00660F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 571681688;
	Mon, 16 Aug 2021 18:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 571681688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629133091;
	bh=UxIg9VisTJBww+V0N8cWY3DshOWyKqmIQK4vbFfigAQ=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pWFeefmP90X4s/sm5MoaxeoYtV9vka8ZziLmQ3ZL21/sX9YFpfuAp9DvfiwNt6QWu
	 oicS7qFuFGGgWEpEsTW1hk7SaUgAjo1U81pbqZ27T/K+/6BUe1p26m5CJ1f0DclrQP
	 ntCo6J1ABP4glwwTz2vUocTcxOFzCo5ZWB2pd56s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB7C6F80246;
	Mon, 16 Aug 2021 18:57:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A02C9F80249; Mon, 16 Aug 2021 18:57:18 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D19FAF80154
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 18:57:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D19FAF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="B+ISxVf2"
Received: by mail-pl1-x629.google.com with SMTP id l11so21403333plk.6
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=hZVwvco17xJQW8JuzB/Vd+7RglaFyjm9hY3oZ9ogtbc=;
 b=B+ISxVf2tKmzTbG77fe9qHZXwf+NyiwzderZmBtHiDhCGlgO42KJGkNqnVLxKcWLvw
 93A9djoJSZCEOAP9QQxDfMNkdRWJ3D3GB2n0GJhtYF8izRHHQaDEvHu0azF8E9kI9JAQ
 qHcpWnq6TjGKat4q52u0iP5Y8w9tMxMAsMTcyqv71R4g00H22hM969Am1ROJGTSTS2lG
 KnxFH5u35ofCHlZhm1du09C/CfmYzyoT88Jw0t5rF+AQIkRCx81FrTHM/17NM70oV3xR
 me/zhydDoJ85nlQfQH9h+l2XTYnyRdLYJY2AKWF1ws+FF+ckDywR0uiSeO+FbBTht7uj
 I3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=hZVwvco17xJQW8JuzB/Vd+7RglaFyjm9hY3oZ9ogtbc=;
 b=sSiFrgnpK5epQaDrHwOGtkxK7W+sesU4r62gQ8qqBMKRE5TbJeO7vlhDOK98TRhHSu
 6b3KoyuqIMN8j+6ZYl9bHjsF7mFNxufcRjsWm8XW7wiVV9VG6D0GlQIZC8GqLWbr1gzN
 xiQVAmv65AqGuxhP5Uu1GbI9wtctTId5WUGvZwU8XVeMakiMjDNiQo9LWXR5r/n30eLm
 qSVjowoQ7jzoma5mvJriRySiaVWPMF8L13/KyGf6FNz7CQ8OeEeFiYSOAOKCp9NCH+t0
 Jg7Jsvw9NzzWR/Ca+SR7h4zZljS9XmmjDV1suZBD78RYi40UJkAY9SYTxRvZKaKRB5ZP
 ilLA==
X-Gm-Message-State: AOAM533Dt6IqQ/ZPIco0BHNl6EXaLQtvNxXH0p+CXq7o7ZTLcZeSscUn
 0abZOK0kUHe3kL0rmSbVtkM=
X-Google-Smtp-Source: ABdhPJy7arED7cIXm+rQ0s1P6Aq+JwCyVr8obt7+l7wa44V3KJxVuB/gYExwyyHGR71G/txvvWKa/A==
X-Received: by 2002:a65:4001:: with SMTP id f1mr10594018pgp.209.1629133027322; 
 Mon, 16 Aug 2021 09:57:07 -0700 (PDT)
Received: from [192.168.1.92] ([106.104.151.171])
 by smtp.gmail.com with ESMTPSA id z16sm13290338pgu.21.2021.08.16.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 09:57:06 -0700 (PDT)
Message-ID: <54f729b54ffa6226a97c9eac897d5f08f6636e31.camel@gmail.com>
Subject: Re: [REGRESSION] "ALSA: HDA: Early Forbid of runtime PM" broke my
 laptop's internal audio
From: =?Big5?Q?=C2=C5=AE=BC=DE=B3?= <lantw44@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Date: Tue, 17 Aug 2021 00:57:03 +0800
In-Reply-To: <s5hy293gj3j.wl-tiwai@suse.de>
References: <s5h7dnvlgg8.wl-tiwai@suse.de>
 <ac2232f142efcd67fe6ac38897f704f7176bd200.camel@gmail.com>
 <s5hy293gj3j.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kai.vehmanen@intel.com,
 mcatanzaro@redhat.com
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

於 星期日，2021-08-15 於 11:20 +0200，Takashi Iwai 提到：
> On Sat, 14 Aug 2021 16:02:36 +0200,
> 藍挺瑋 wrote:
> > 
> > I am not sure if I should join this old thread, but it seems that I saw the
> > same
> > issue on my ASUS B23E laptop. It couldn't produce any sound after upgrading
> > to
> > Linux 5.10, and 'git bisect' shows it was broken by the same commit
> > a0645daf16101bb9a6d87598c17e9a8b7bd60ea7.
> > 
> > I have tested the latest master branch (v5.14-rc4-322-gcceb634774ef) last
> > week.
> > It still had no sound. If I reverted the broken commit, sound worked.
> 
> > 
> > alsa-info from the broken kernel:
> > https://gist.github.com/lantw44/0660e059c488e3ff3d841bb03b371866
> > 
> > alsa-info from the working kernel:
> > https://gist.github.com/lantw44/9367f425e4f5ba98cf12343cb90f3301
> 
> Thanks for the report.  A quick workaround be a patch like below.
> Could you verify whether it fixes the problem?

Yes, it fixes the problem.

> 
> 
> Takashi
> 
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -1041,6 +1041,7 @@ static const struct hda_fixup via_fixups[] = {
>  };
>  
>  static const struct snd_pci_quirk vt2002p_fixups[] = {
> +       SND_PCI_QUIRK(0x1043, 0x13f7, "Asus B23E", VIA_FIXUP_POWER_SAVE),
>         SND_PCI_QUIRK(0x1043, 0x1487, "Asus G75", VIA_FIXUP_ASUS_G75),
>         SND_PCI_QUIRK(0x1043, 0x8532, "Asus X202E", VIA_FIXUP_INTMIC_BOOST),
>         SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", VIA_FIXUP_POWER_SAVE),

