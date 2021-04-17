Return-Path: <SRS0=rxpm=JO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB9C433ED
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Apr 2021 14:38:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5BA60FED
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Apr 2021 14:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5BA60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE18E167F;
	Sat, 17 Apr 2021 16:37:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE18E167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618670286;
	bh=IlXtyWDAmj9rDiRarly8SfDswlDfM8r9xFJUAgkpx8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDm/5cJZiAbVkLs6YYAkC18/g4kFLmxrR3NjAsrktndWzogbgEkURJiF+q9GqfdnX
	 KWawudL+vsTlWEtHYvz7W+3Wcal6s/LYs9CmpO11mfEXK3Nj9nEbyhDb5i7aaEyZNB
	 HK7RRcQpY7uSrzbNXByXC12tzW4AY9rkk/jOu8MQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36F33F8021D;
	Sat, 17 Apr 2021 16:37:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23137F8022B; Sat, 17 Apr 2021 16:37:14 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C519AF80152
 for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2021 16:37:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C519AF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="dt9fyCSK"
Received: by mail-ej1-x634.google.com with SMTP id r9so46266332ejj.3
 for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2021 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EII9dEoZL1Amogsa3+pGcosXzGZbE8PH2orbiptHPno=;
 b=dt9fyCSKNPY2u5BjB1o6QUze7t+EtqK7MM9/nANZHgmhcDZxu/28hcw7+ZbNIlrUgG
 9rJy0csZ5IL3XjGb1O0IJ8OOSiIPmHrKmk/5R+P6ajw9Yq3FhlEcWapy+Ji7s5YCdREU
 2BQu8lQo75RDD/leNRB/D7w5bokaIzrwiadmMTMJ8L6U7+HbTlgDZcioBAE9FO6lD9bk
 GPVqpxgXYvs2ohfZHVyQ7N+UTDgdAUYaFWz2OlmEqAIqqgdcZe7aTfuX85+ORLUzotSY
 oH3f7jdpciKABiZSh57WoVVPxcCHP/buGlcDib+bNOkmjSfGrIrAuBaVSxksGhBOJVU6
 jG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EII9dEoZL1Amogsa3+pGcosXzGZbE8PH2orbiptHPno=;
 b=VuLJy2RzRsN9sCvPAYe/r16to0+9ZhIjHdgcC+4FxeYzxZed9fYBG7C+Z/PyrfM5+O
 P6gJLAE+cPm65YOXcmdBDGpfocG+BcY66KI95z3wwLO4y2aMMsY9huMw/DJb0wfl0rzy
 uBvZQvVGol6hSuSRPvltTVWBFP69BYzWM6F3l+hYtgCEbMciFXJ16+QEGfhqBE6wA/9f
 UCc8YvYnmKduV/pbhHxpJEuLIxuwv419RgMJyYda/5bdVw0h6YDwxlZ2Y6/syAwzGsbv
 B+uINNT5HY8AM+O9/Hzyy+QSOjf9umavUDcfrSl6Bnf6Ptq7kiuIVb1rTct1fLNu2MDq
 Iw8w==
X-Gm-Message-State: AOAM5335OXjlY6b634h+yx20q+CQBA7FvBy469cc1HGRpNzJNqZJdqOO
 IuiG6wN+F2Q9R0LH8DKWYOo126/v7iVQxwsn/TE=
X-Google-Smtp-Source: ABdhPJyOGU1pniVyrSoY9GjpkcXJfV+JRQ4PCADItiRTpRA1tRFdbWgClh1JAORj/SJobRqwhIAg9Mv0VLkeKQs+gN4=
X-Received: by 2002:a17:907:9691:: with SMTP id
 hd17mr13518489ejc.205.1618670227039; 
 Sat, 17 Apr 2021 07:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOsVg8rA61B=005_VyUwpw3piVwA7Bo5fs1GYEB054efyzGjLw@mail.gmail.com>
 <s5hy2dhfi2j.wl-tiwai@suse.de>
In-Reply-To: <s5hy2dhfi2j.wl-tiwai@suse.de>
From: Lucas <jaffa225man@gmail.com>
Date: Sat, 17 Apr 2021 09:36:55 -0500
Message-ID: <CAOsVg8roXxu4nA92HPXRf9dyb3KSzaCbsQZ=tJx7RDvhTSSzQA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add support for many Roland devices'
 implicit feedback quirks
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

Thanks a lot!  Sorry, gmail seemed to remove the leading whitespace. The
Edirol UA-101 didn't work with a quirk line at all, probably because it has
its own kernel module conflicting.  Other than specific cases like it,
you're probably right.

On Sat, Apr 17, 2021, 3:09 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 16 Apr 2021 18:50:20 +0200,
> Lucas wrote:
> >
> > It makes USB audio capture and playback possible and pristine on my
> Roland
> > INTEGRA-7, Boutique D-05, and R-26, along with many more I've encountered
> > people having had issues with over the last decade or so.
> >
> > Signed-off-by: Lucas Endres <jaffa225man@gmail.com>
>
> Thanks, now applied manually as it seems your MUA deformed the patch
> somehow.
>
> Yeah, that's a lengthy list, and let's take it as is for now, just to
> check whether this makes nothing wrong for each item.  Later on, we
> can clean up the quirk entries with a more generic matching.  Judging
> from the number of entries, I guess we can assume all Edirol / BOSS
> devices are always with the capture quirk, for example.
>
>
> Takashi
>
