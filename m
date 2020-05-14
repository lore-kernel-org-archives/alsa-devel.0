Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6930C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 12:15:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1C0206A5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 12:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JgUcreES";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSjnfo9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1C0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 594FF1658;
	Thu, 14 May 2020 14:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 594FF1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589458515;
	bh=cVED7Rui+oeAfHwM6ciwiFn/QaMl1IqIb3Dd/Z0NpVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgUcreES9IUkvM2t3xn5+aSQY1fyIYAGyKGKK397A7HhQreRMImLVFOjqp6oYh+m2
	 Nuab+/7UebToAOrYMW1KlsKpTTnkfqatV1zGREWPu0FVpH5Gqz4Kr2nbeeUtUpQkdT
	 dRpPCZaQ+MBRY4BesHgAXVhhF6cJGZgrnQsToUo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8FACF8014C;
	Thu, 14 May 2020 14:14:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91D45F80158; Thu, 14 May 2020 14:14:22 +0200 (CEST)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2141CF80101
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 14:14:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2141CF80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rSjnfo9m"
Received: by mail-lj1-x244.google.com with SMTP id a21so3199078ljj.11
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VXnRTW9/Xaare9cYIycGqJDKjuTFI88F9YjRcgsnR2M=;
 b=rSjnfo9maX8dbNw6zQ8HuA1Jg9YgBoyGE3TXIU120l6p9DcnC7g9hEtcHfdqf44y7w
 I5IPEdYKfWyMsIB0LuOcojVB7NDX4ioX94yEi/YBkendliBPbPe5WhB/LSh3XLt4bAIU
 o+aLxNCyfk1RstPzDMheP1GlhPpU4kTmrVIKrUHAWgs4N2NlLgbYPQgL7z18qkozAlSz
 z9o3rVT9Dszsl3mKjwiQjZWudliNwj5+4DM02itlCJkZBvtouk+guR/cyh42z2Ely6cW
 OUOUza/cOz0vpkHPEvtBEdEakGasJlF+dPmjsTrFwJmNJ57CuRhxtLKI+Y3QyUpTwIvf
 NP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VXnRTW9/Xaare9cYIycGqJDKjuTFI88F9YjRcgsnR2M=;
 b=o7wqevkum6ibVgSTHYsNpKhCZRIdvAztK7nkHjjopPL/1L/Tt3GaFC1Ujv2A3OEapB
 PodcNHLSO63CR5iVzTw2MsDJ1MNguePDBPW6qGno+3NY7WWpAD165Jk3whb+GllIDp0d
 bgrAKe+5/RuvPCm2US1fa/a2vX3unTPJnGx39d671UtAwYHsvY9lLYBZ96MIgnTxNlb4
 jQMwGCkLZOpgb1UNK9wvTnPpVY+yc33wbIryc1YN8uCWcJbY3dt0BezMpaL3hrvbbIYq
 hpTvpzKnnJO1ANtavtGZwDwkqaV6pJmWLwYoUT2kO8RK5N5thOSbUHohVeaiJh9gI4Ia
 Joyw==
X-Gm-Message-State: AOAM532nLY+II0HjCkXmzbX5wOuwQHlr7SGn22f4rSlUH5CTM13mJSNs
 Mi7mVV9jlsm3nYBL96od5nbycUqQOOqmHtKgq+o=
X-Google-Smtp-Source: ABdhPJyZawv5nbT8xSPpRhThQabdohiRc/eQFL5QMSoo/e+x1equc5hDVBrg2F1TBelzbk1g6u268CxTsoBbuWEatbw=
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr2625094ljm.49.1589458458026; 
 Thu, 14 May 2020 05:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
 <20200513105144.GC4803@sirena.org.uk>
 <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
 <20200514101711.GC5127@sirena.org.uk>
In-Reply-To: <20200514101711.GC5127@sirena.org.uk>
From: Steve Lee <steves.lee.maxim@gmail.com>
Date: Thu, 14 May 2020 21:14:04 +0900
Message-ID: <CABff4NQh8ZtHUfn4KYcXfgbZgiaRQb_5s5e7sq0_jZkp2OMg4Q@mail.gmail.com>
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: jack.yu@realtek.com, ALSA development <alsa-devel@alsa-project.org>,
 ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
 ryans.lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Tzung-Bi Shih <tzungbi@google.com>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, geert@linux-m68k.org,
 dmurphy@ti.com,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 steves.lee@maximintegrated.com, nuno.sa@analog.com,
 rf@opensource.wolfsonmicro.com
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

On Thu, May 14, 2020 at 7:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 07:58:12PM +0800, Tzung-Bi Shih wrote:
> > On Wed, May 13, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:
>
> > > > Changes since V2:
> > > >       * Removed warn massage in max98390_dsm_calib_get func
> > > >         and add comment.
>
> > > The problem isn't the warning, the problem is that you have an empty
> > > operation.  You should either implement the function (eg, by caching the
> > > value written) or remove it and fix whatever problems you were running
> > > into further up the stack when it's missing.
>
> > The purpose for the mixer control is: to signal max98390 to start to
> > calibrate from userspace.
> > Thus,
> > max98390_dsm_calib_get() -> do nothing.
> > max98390_dsm_calib_put() -> call max98390_dsm_calibrate().
>
> In that case it should probably do something like read back if a
> callibration is currently running.

Thanks for feedback. I will follow this guide.
