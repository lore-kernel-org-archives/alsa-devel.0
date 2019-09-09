Return-Path: <SRS0=MTqT=XE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF51C4740C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:31:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9385821920
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D/2YymdM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VarEGhU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9385821920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E26724E;
	Mon,  9 Sep 2019 18:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E26724E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568046684;
	bh=nRvY18jahO+TF0DFd/aB1Mt3/THJbBL6tQIzpffMnyM=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/2YymdMfG0XN0m6SUu12naRLAmdSp7V6OzsbvaLi2qNYJnJOqWbLMamg4qHfNh8J
	 PKHT830SFapdlGpjxxqDgWJvAZNqhdPkThGA6V93qpIU7jhhLrTpHSiIKTDBntee3q
	 e8oz0gaqfeKbdDlWGr4cxePLUsnZsibjJTLODuCI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EFF1F800E6;
	Mon,  9 Sep 2019 18:30:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 238BAF80323; Mon,  9 Sep 2019 18:30:31 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F4A4F800C9
 for <Alsa-devel@alsa-project.org>; Mon,  9 Sep 2019 18:30:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F4A4F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VarEGhU7"
Received: by mail-qk1-x734.google.com with SMTP id x5so13668110qkh.5
 for <Alsa-devel@alsa-project.org>; Mon, 09 Sep 2019 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=2KQmj5j4WWNGWSlrZ67pKqW5yzRtyVvLIgif2HnBjic=;
 b=VarEGhU76UoKIbpDrmHlkyN5IglBrh7cGSVL5C4/eUEymglhrDUI6JwUth3Cld02ML
 YJCLjDfF/A2zdxDoEGkA7hzCUqM5untzBoeuaj016CPdhTETbZkGgZfGKGRjs9BVKs4O
 1lqDgdVg0yJLIQ7OFP3+oYsp1DGnN/5qLxACssK2qCEWGkYXZ0a5b8yeXfT5z4lJg0PF
 jqlQF58mLPvkXFxS9wBTyLbFmoY4PAurSoBi2Xq0SLS1yNCeiLR26WYTde7SPv4eR1PK
 q4F7pOGxx/RsyunLUPSqikcVWoEZ942+og81/BlI1guroulnQFWXHR4AxrnliZt8bnzQ
 FbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=2KQmj5j4WWNGWSlrZ67pKqW5yzRtyVvLIgif2HnBjic=;
 b=G1VopRLOCOl9qcmzFwG1V1yVj7stVe9L1IMQm8k+DkhPPHPHEjVc7ph55iVE+f5k0+
 yacDO+/luAkWpiU+GphqkGu4LZZQTTks+akejJ4IeGfWreJJx2N3Y+qHVdO9bZ4+yKWB
 5iKhMVdj6DfxgmwQgYYd5yE2zhPTuqVPp+YQj5GFdE73ZOJ5/nGuCkXYEAaVPXLnkSUv
 kKgppdd8Bj2VBQn22ipZ0zZSueRw45PZoJoKqP2S63I8jPuqRfTwuzjQ8Urvcr4S8FEl
 Jsk92L6bBuXZE0nxeEMPJ/WTR+ZaHF/zuCaSKTTG8p8uo+Bde0PyrHnMZHJIaMTGWemH
 VUIQ==
X-Gm-Message-State: APjAAAV/zox15Zc7SYbu030HNi7cvybxejd4O/oRo7beQulHQvXVFgBS
 CT4hPxlqY3dzVy5hQfRUGUvSl6VEoHdN6DmV2qLnjPPm
X-Google-Smtp-Source: APXvYqwuJn2UhX0H8W2keB+qa68lNqlf1j5t9ScVOEvBI6/FJr9xc0G35gg+6HDn8GL2SQ07JTctQsibTCsNTPzESjc=
X-Received: by 2002:a37:410:: with SMTP id 16mr23745389qke.52.1568046626308;
 Mon, 09 Sep 2019 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+SWvNx9hGJN0v9erykioJUKyd726VzfP4b77u0RUHh_mgFooQ@mail.gmail.com>
In-Reply-To: <CA+SWvNx9hGJN0v9erykioJUKyd726VzfP4b77u0RUHh_mgFooQ@mail.gmail.com>
From: Pavel Hofman <pavhofman@gmail.com>
Date: Mon, 9 Sep 2019 18:30:14 +0200
Message-ID: <CA+SWvNyUAyBQd9ktaZpvV8R7XcK8opA1_VQeMEnPfmr6jcSANQ@mail.gmail.com>
To: Alsa-devel@alsa-project.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

On Sun, Sep 8, 2019 at 5:23 PM Pavel Hofman <pavhofman@gmail.com> wrote:

> Hi,
> Gathering data for USB async gadget feedback (
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-August/154819.html
> ) requires measuring average data rate to/from a device. For testing I
> added measuring/averaging code to methods snd_pcm_hw_writei, snd_pcm_hw_readi,
> and snd_pcm_hw_mmap_commit in
> https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm_hw.c .
> In all cases I take the parameter "size" of all the three methods as the
> number of samples written/read.
>
> MMAP: When mmap is used (e.g. plughw:X + sample format conversion), I get
> very stable results for MMAP playback on all soundcards I have tested. But
> for capture I get identical results to playback for one soundcard (PCI
> Envy24), while the averaged rate calculated from "size" in
> snd_pcm_hw_mmap_commit fluctuates for capture on Intel HDA.
>
>
> I suspect the size parameter of snd_pcm_hw_mmap_commit is not the actual
> amount of samples read during the MMAP capture. Please how to calculate the
> number of samples read from the variables available in that method?
>

The mmap fluctuations seem to be fixed by using increases in hardware
pointer pcm->hw.ptr values instead of frames variable. Please do these
values wrap up or do they grow  to max long? Still contiguous after 10
minutes of running.

I see the hw.ptr gets zeroed at XRUN. If I do not check for xruns (
snd_pcm_state(snd_pcm_t *pcm)?), can I just monitor continuity of hw.ptr
and restart the averaging if the new hw.ptr is lower than the previous one,
or are there any quirks to watch out?

Thanks a lot,

Pavel.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
