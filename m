Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C27C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:57:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E428D22B30
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E428D22B30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3586316BD;
	Tue, 12 Jan 2021 14:56:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3586316BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610459849;
	bh=vB5lpzTt29XTbo/psAk398X+85pbJwcW2+S3O+w/Q2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfWgUoGnT01PE2AgmF58CEcwh+dB8j/kv7Mzw5cJVyjYH7L7YO1kxlOyPo2aa9a30
	 F0ahU6XGxVqvIZxqSXdIDEcoukB/fOJreq/t3NnAmtydchQhef6Lmit//2RwyJgmqp
	 5oYqBXI77iePOY9T/vB6BXyWMJkQpUazDRDKqYS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3237F804CC;
	Tue, 12 Jan 2021 14:55:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A0D3F804D2; Tue, 12 Jan 2021 14:55:55 +0100 (CET)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07F7BF804CB
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 14:55:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07F7BF804CB
Received: by mail-ot1-f54.google.com with SMTP id x13so2289304oto.8
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 05:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bewu31Wz6BYeJ3fs1tGieNc7Cxbmk8ZWGMFgmRHxzYM=;
 b=huhstTxiXczqdAgR2P2R3AfgikTtasB685swpN/OeSkB5J2enlsjljU6y7il4tP7VF
 TR+H/ig+aYHVm6nCffgdBC6AdrX6hk4hofVziCXKdK6S3+ucKwijxxP8fNa+8m/BFPPV
 9oRpYzwTyYg83FlnfMdYYC6R1T1PJbKaN9jNdRM8V1rKEZTKpXik955bReO4LFUvzU7F
 GET7c5W1zBBXfZwg1XOZ+pTnymfRAauwYeCivWBFm+sG1StEJWK3RiP7+zGonXN7UH3z
 BNT10vZHeIode09I8HIKmgRXlSUdIZSgRGiQlAe+Uq+Wc91oNEun/w21LWwPqGxbzW5q
 E6sg==
X-Gm-Message-State: AOAM531aXXAohGXmvzTS21x86IJuqV2yF1v7tgXU7JfK8CU7aBFM5FsJ
 BGMbMtnpx5D6JDygfTFDI60Y5DdTInnvMUOD8jU=
X-Google-Smtp-Source: ABdhPJyqsv/zc32Ef1sgaxu3RqyHKnI+wz9AokVKR6Fi6eobl+AJ3SaWHGDvlbGhD47al5nqDyg551JsdyMn1qupqCc=
X-Received: by 2002:a05:6830:210a:: with SMTP id
 i10mr2834180otc.145.1610459747107; 
 Tue, 12 Jan 2021 05:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20210111130251.361335-1-geert+renesas@glider.be>
 <20210111130251.361335-3-geert+renesas@glider.be>
 <20210112134259.GA44140@workstation>
In-Reply-To: <20210112134259.GA44140@workstation>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Jan 2021 14:55:35 +0100
Message-ID: <CAMuHMdWo6uSBYr=uBWVPBfELfs6g5ZdnLdADakBj5ze9wkq9BQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/2] ALSA: firewire-tascam: Fix integer overflow in
 midi_port_work()
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>
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

Hi Sakamoto-san,

On Tue, Jan 12, 2021 at 2:43 PM Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> On Mon, Jan 11, 2021 at 02:02:51PM +0100, Geert Uytterhoeven wrote:
> > As snd_fw_async_midi_port.consume_bytes is unsigned int, and
> > NSEC_PER_SEC is 1000000000L, the second multiplication in
> >
> >     port->consume_bytes * 8 * NSEC_PER_SEC / 31250
> >
> > always overflows on 32-bit platforms, truncating the result.  Fix this
> > by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.
> >
> > Note that this assumes port->consume_bytes <= 16777.
> >
> > Fixes: 531f471834227d03 ("ALSA: firewire-lib/firewire-tascam: localize async midi port")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > I don't know the maximum transfer length of MIDI, but given it's an old
> > standard, I guess it's rather small.  If it is larger than 16777, the
> > constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
> > ---
> >  sound/firewire/tascam/tascam-transaction.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Indeed. The calculation brings integer overflow of 32 bit storage. Thanks
> for your care and proposal of the patch. I agree with the intension of
> patch, however I have a nitpicking that the consume_bytes member is
> defined as 'int', not 'unsigned int' in your commit comment.

Thanks, you're right.
Note that port->consume_bytes being signed halves the limit to
8388 bytes, which is of course still met.

> The member has value returned from the call of 'fill_message()'[1] for the
> length of byte messages in buffer to process, or for error code. The
> error code is checked immediately. The range of value is equal to
> or less than 3 when reaching the calculation, thus it should be less than
> 16777.
>
> Regardless of the type of 'int' or 'unsigned int', this patch can fix
> the issued problem. Feel free to add my tag when you post second version
> with comment fix.
>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
