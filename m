Return-Path: <SRS0=R5RK=XF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1A9C49ED9
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:28:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D242168B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jb2fGxZ0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzrwy9xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D242168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FAA416B8;
	Tue, 10 Sep 2019 21:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FAA416B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568143703;
	bh=Ctu1h0TQusY5LaVmpE95+C95BHiQqugYlG9hWhBVs+c=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jb2fGxZ0ijpNOyjemaLzj3/aALjiDWmKmgjXY4i9c3QAirIsMsAisutZihYk3lz7h
	 7diy/Jt12z1ogZanfpL8nCJlU5WsXLRq3CLBQsxqQ+Z1crWMH/oIsnvRUSrJm4BpZG
	 j/BASstWDjap7iYypAHck4g0vFq+aFgq+7DE3h7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 247A7F80321;
	Tue, 10 Sep 2019 21:27:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43CDAF80368; Tue, 10 Sep 2019 21:27:31 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7048FF800A9
 for <Alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 21:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7048FF800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Uzrwy9xf"
Received: by mail-qk1-x72f.google.com with SMTP id d26so18333219qkk.2
 for <Alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tpJPGFGSp2SPUQy5t1ryE/JUx6050V5AkBNUN7K0bTs=;
 b=Uzrwy9xf468qU4QyiKW+f4hG1MUIaAjerldiDOyKlnu3yY/tOSIATFZPxrc1P/LLYx
 wNWAIzun/9GDqRhuUBn1Sbf2oWJGC0N5In6xNXzqfOgO/rNbGPt6NP5wrcMtmiCg1t2G
 Lvqd3Ph2Bs42Qxl6l/yacf0PYLD/fafQ0veY8XNHgoTsdwQRfjO0CNA2snhbRR5PdAUk
 W4uYqYfE4dw1iBNcP9wuV1Y2ao2ce3rz+ToOkvP3SFbPjgXuIcAld9dWvL5eAHe7BXr6
 Ncmh7zalFez9Hsh6qHoGFFdqP/euCVRI/xX1PCKiqp07nKAeQv0R/dNMvgRYpo5ArgX8
 2LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tpJPGFGSp2SPUQy5t1ryE/JUx6050V5AkBNUN7K0bTs=;
 b=akNWUbH7M3Na9ZUSJB5nGFuzdo+jue5CxD7bMja7zM/6pQQ9sC2QB87pwpthwpCJSu
 2rvjJVKt+M8ztDjYDOPnz7oXsRINsgbQJsYu2MdM76YHckFLlgMh2G2F7Kr/YLfad+r6
 bIw8OGzgX7LmlbFONTW0s0d+NzGUtseKDY/dNPVBhFWutoHoKzFRBfxTwZrynz1V5Bfz
 EJakB/qKiuiz6xJ060hJQ9xt2mQDUalRGFRb7B9Hir91Wl0owTivssmbVCoYmp8UmtPP
 M2EQoKLqhhAsrsILzP8RIk9Mp19Hzy2EkM6SCuqM21L88/cnBfC8U3PUuTDyV08Ainj/
 o/7w==
X-Gm-Message-State: APjAAAV1zq44C5HBglfI3oto7nDJCn616ztLiDjaELlg9VonmgbxjliM
 SUUrT/+mF1r4gqwwdb4iQg02t3m3izE7rOcNLTU=
X-Google-Smtp-Source: APXvYqwiFo22mPDeRJdShvO5LRDkTzl1btJm4oxm6Kfe3sCQ4gWDOZAPKne+nUy1PmFMX7tPAyQEl5xx7U7n/qAagrI=
X-Received: by 2002:a05:620a:1393:: with SMTP id
 k19mr9433137qki.35.1568143646500; 
 Tue, 10 Sep 2019 12:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+SWvNx9hGJN0v9erykioJUKyd726VzfP4b77u0RUHh_mgFooQ@mail.gmail.com>
 <CA+SWvNyUAyBQd9ktaZpvV8R7XcK8opA1_VQeMEnPfmr6jcSANQ@mail.gmail.com>
 <s5hzhjd9xg4.wl-tiwai@suse.de>
 <CA+SWvNw_=Fj_3M3sqVP767OOR+YDY=6-rPtPgmGXg+BcvuG3oA@mail.gmail.com>
 <s5h8sqwaabt.wl-tiwai@suse.de>
 <CA+SWvNwLUzPknid7ZDq114iX8zxMhayRvdxmLMxdDtq9AV3FbQ@mail.gmail.com>
In-Reply-To: <CA+SWvNwLUzPknid7ZDq114iX8zxMhayRvdxmLMxdDtq9AV3FbQ@mail.gmail.com>
From: Pavel Hofman <pavhofman@gmail.com>
Date: Tue, 10 Sep 2019 21:27:15 +0200
Message-ID: <CA+SWvNx5V+EQswC2p=zvO8Xvwbw=U-dGAK0pFjyDOk-wETVoqw@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Measuring Device Throughput - MMAP vs. RW
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

On Tue, Sep 10, 2019 at 9:48 AM Pavel Hofman <pavhofman@gmail.com> wrote:

> Thanks. IIUC, if I call snd_pcm_status() in that mmap_commit method, get
> data between e.g. 10 seconds, and divide the increase of status._ptr
> https://github.com/michaelwu/alsa-lib/blob/afb2fbd0e554e42e51325c3197a176ea96a74203/include/sound/asound.h#L422
> by increase of status.tstamp, I should get the the most precise available
> soundcard rate estimate referenced to system time.
>
>
Upon hard-coding params->tstamp_mode = SND_PCM_TSTAMP_ENABLE in
snd_pcm_hw_sw_params, the snd_pcm_hw_status method started returning hw_ptr
and tstamp. The variance of the rate calculated by these values is
perfectly acceptable for my purpose, I will use this method. 10 sec
averages of the previously "jittery" mmap arecord:

STATUS MMAP: time: 6679.12, card = 1, device = 0, averaged samplerate:
191995.485933
STATUS MMAP: time: 6689.14, card = 1, device = 0, averaged samplerate:
191995.833616
STATUS MMAP: time: 6699.17, card = 1, device = 0, averaged samplerate:
191995.589371
STATUS MMAP: time: 6709.20, card = 1, device = 0, averaged samplerate:
191995.647669
STATUS MMAP: time: 6719.22, card = 1, device = 0, averaged samplerate:
191995.740024
STATUS MMAP: time: 6729.25, card = 1, device = 0, averaged samplerate:
191995.709675
STATUS MMAP: time: 6739.28, card = 1, device = 0, averaged samplerate:
191995.588850
STATUS MMAP: time: 6749.30, card = 1, device = 0, averaged samplerate:
191995.706994
STATUS MMAP: time: 6759.33, card = 1, device = 0, averaged samplerate:
191995.641393
STATUS MMAP: time: 6769.36, card = 1, device = 0, averaged samplerate:
191995.530104
STATUS MMAP: time: 6779.38, card = 1, device = 0, averaged samplerate:
191995.764419

Do you think there is any chance a code generating the average throughput
into some file identified with card/device IDs, all of that enabled by some
environment variable, would be acceptable into upstream pcm_hw.c? It will
be a key part of the working async usb gadget. The current version
https://github.com/torvalds/linux/blob/master/drivers/usb/gadget/function/f_uac2.c
does not comply with USB-audio v. 2 specs due to the missing async feedback
endpoint, and works only for the adaptive mode (requires resampling).

Thanks,

Pavel.



> Thanks.
>
> Pavel.
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
