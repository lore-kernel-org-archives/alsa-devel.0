Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1239BCA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:55:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2D521734
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CbPXs/Ah";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Prqdct9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2D521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EB491F29;
	Mon, 28 Oct 2019 14:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EB491F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572269968;
	bh=LuGAznsgB06XfCd31I95pXjJMmPYwmJTOhOcNxxsSdk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbPXs/Ah3mXL5ku8g0aE/PqMNnNWHXRy5rm4Pb1PzHZCxEChStfoS8RizO9iy0ZUF
	 +i2U+WjFSYQ152dzHjNv/bl033szaqS3RxU4WQ/mH/OtmQi2oWRaJ4I6h+GFRplWws
	 s5WNzw4uW8rliATv78rSyMv2THz2THlovfMT3K7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF06CF80145;
	Mon, 28 Oct 2019 14:38:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EE8EF80361; Mon, 28 Oct 2019 14:38:36 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFC0BF80145
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 14:38:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFC0BF80145
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Prqdct9i"
Received: by mail-pf1-x442.google.com with SMTP id d13so5845392pfq.2
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wGuG1asRy1Pd6i7LZD0Q+1ycYN3PhkFDWywCgQeZeaY=;
 b=Prqdct9iwqd6MXUyCkYp/bYuS5H5kh75fxMDBkRg1GIZvSnA0QDrplJypF3PpZH/O4
 1Bp+n8ikRLiZi3wCtGM5EdYBOUSz43ptgDe6c+Hcy8PHIkk340xqjpnw5vAMXQg0epVe
 sAf4KtMlQiU90VOC0jQg8FpJ3tAS9FfS+/E+g84+mPVoqjuk3idBMh1ij/at+XIY4dN/
 g1LqadNQdpFOsPeWQcLJBphikMDb2w6+nCdjtvvL1t72BlJyYbk7JTKEXssBVe5BmlJj
 C0FCkIgO895PljSkL7ELKH67zSNzBeDxynIcajMChCFXKzawtODk/UlUtEcUk5oF7eZA
 z68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wGuG1asRy1Pd6i7LZD0Q+1ycYN3PhkFDWywCgQeZeaY=;
 b=M+cQqEbJF+/9bP2XmoUllZCGM0QSk+kjnn2wbTohZn44bh2LGFmeG7KS/Czfw1E6aT
 ENlJuzW8OiElvvhAcxOLNa1+nAMxVkRTGMlfDKRaZ3q3h4a0LDfptMpl9M+lFt8JFgbi
 QsqvlPyStp94NKN8Um4pJfWCQ7lQjd9xgBdjyhTmaj2WnkjxKvyh2ZZZT0Fi9Jj7dK3b
 ee/N2yHbxLhiOVIVB2KiowTXivzYpSJ1raWrJ65XuxkmuAgnJutq9ARgxSf6Id46LGK8
 plIakKzZqPIco5B61Vr4fEDIRLoF/c2NtBAUHvcRRMwHahWZrgkTHtI1GB7VK6klVzN6
 WXCQ==
X-Gm-Message-State: APjAAAV+WwhK/oMfDwIpqBozd5vq8eCm3qqWYM/WWaXOwGZBZlgNSv0f
 DZVHwn4KaBAglHFkY5Rwv2yw4LSiaDV34ZKeMDwRUg==
X-Google-Smtp-Source: APXvYqydhmDxjTnxvFA+bkrPFtaf5CWiccBWdY55qCD8pTVEhAH/wNy6ubCJ6Wv9G70Sm8WS+siNyBaJx6EIINzy3lQ=
X-Received: by 2002:a63:541e:: with SMTP id i30mr20918922pgb.130.1572269911356; 
 Mon, 28 Oct 2019 06:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f838060595f602a7@google.com>
 <s5hr22xau8f.wl-tiwai@suse.de>
In-Reply-To: <s5hr22xau8f.wl-tiwai@suse.de>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 28 Oct 2019 14:38:20 +0100
Message-ID: <CAAeHK+yUrW00w_qDZ9L71WVXyX-Y__cbohZkUhNWDnYoVfV69g@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, wang6495@umn.edu, yuehaibing@huawei.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>,
 Allison Randal <allison@lohutok.net>,
 syzbot <syzbot+8f2612936028bfd28f28@syzkaller.appspotmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?B?5b2t6L6J?= <benquike@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [alsa-devel] KMSAN: uninit-value in get_term_name
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

On Mon, Oct 28, 2019 at 2:13 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Oct 2019 11:32:07 +0100,
> syzbot wrote:
> >
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
> >  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
> >  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
> >  parse_term_proc_unit+0x73d/0x7e0 sound/usb/mixer.c:896
> >  __check_input_term+0x13ef/0x2360 sound/usb/mixer.c:989
>
> So this comes from the invalid descriptor for a processing unit, and
> it's very likely the same issue as already spotted -- the validator up
> to 5.3-rc4 had a bug that passed the invalid descriptor falsely.
> This should have been covered by 5.3-rc5, commit ba8bf0967a15 ("ALSA:
> usb-audio: Fix copy&paste error in the validator").

#syz dup: KASAN: slab-out-of-bounds Read in build_audio_procunit
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
