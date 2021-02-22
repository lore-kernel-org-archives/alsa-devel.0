Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221EFC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 17:32:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADBA64EEC
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 17:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADBA64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9811B42;
	Mon, 22 Feb 2021 18:31:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9811B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614015148;
	bh=CS+315NjpZsMCBjQpHz7Z8jaiKoed5h7RXxAbJYKhHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YwwPi5edpnTZRcF0vhj3fKMdXVV6LCbiAyS6zfcIuff2m0BRxa7LUNlcIvK9gz8Kw
	 AygDRmmTJ5NuOCs0MIjlXbOUJHugEun2IOwuvHOYTz02+r5wvSKnXkO4uoXzjcglIc
	 gXHIXEPOjyE0y7qsplY3sJX9XT76qdfo+Pjs7jFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23CFEF80154;
	Mon, 22 Feb 2021 18:31:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 786F1F800CE; Mon, 22 Feb 2021 18:31:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A28A5F800CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 18:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A28A5F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Es2lFN+H"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DB5364F02
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614015088;
 bh=CS+315NjpZsMCBjQpHz7Z8jaiKoed5h7RXxAbJYKhHg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Es2lFN+HquZCQYbSRbzREp6Tb/QswmGg+fYQqSs5KB/12rmEmUzdQPee9S2hxb9ga
 alzv4cLfoDB1xXiL6ppwBteiDg8GMXZo3fH9h4NSmwu55T8eMBMeTbBXG3QdGRsEVf
 jkKksc90FDBJpTRwcZPXFiX0scJQ2f2HnG8Vl87dZ2wOKgomvSl2LpkbrbQ0rbSo2D
 vSHJQZu801gyMaYjvp+WwuL91pgDDypMydf/1LaDT1sEfWv9ySvOZ5V+4uQ6smWlno
 DN9IopQ03Eotkr8LwTzUIKSltAHxlW/Ft/EVzxeo7AN1mRyulpSpfk8wbWWu7U2hS9
 MMuwqdsTm7/7A==
Received: by mail-ed1-f46.google.com with SMTP id c6so23150639ede.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 09:31:28 -0800 (PST)
X-Gm-Message-State: AOAM530vKLLUJ16grNrCWqO4bwJH21fbmi/2bVvxEJXKHUu0oNkKZcxb
 WZh0CTo6rnZNcW4QWfjDRnWVywDMVo0jyD0Zbw4=
X-Google-Smtp-Source: ABdhPJyvdQCFO0BqaqMwuUZJ8k9W75Q4qHoar1gp40a7lrgPWZpNfdwmGpAItzRq6jJaqqkuKq6FLGEGLCojfCQEY8k=
X-Received: by 2002:a05:6402:3d8:: with SMTP id
 t24mr23491658edw.298.1614015086935; 
 Mon, 22 Feb 2021 09:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
 <161401004266.2538.5738460015320431431.b4-ty@kernel.org>
In-Reply-To: <161401004266.2538.5738460015320431431.b4-ty@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 22 Feb 2021 18:31:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe6LZuuL0ntPAEwudEtMcGreBLMHzBFg5jw_3=DpG8KVA@mail.gmail.com>
Message-ID: <CAJKOXPe6LZuuL0ntPAEwudEtMcGreBLMHzBFg5jw_3=DpG8KVA@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/6] ASoC: samsung: remove cppcheck warnings
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Mon, 22 Feb 2021 at 17:08, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, 19 Feb 2021 17:09:12 -0600, Pierre-Louis Bossart wrote:
> > No functional changes except for patch 2 and 3 where missing error
> > checks were added for consistency.
> >
> > Pierre-Louis Bossart (6):
> >   ASoC: samsung: i2s: remove unassigned variable
> >   ASoC: samsung: s3c24xx_simtec: add missing error check
> >   ASoC: samsung: smdk_wm8994: add missing return
> >   ASoC: samsung: snow: remove useless test
> >   ASoC: samsung: tm2_wm5110: check of_parse return value
> >   ASoC: samsung: tm2_wm5510: remove shadowing variable
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [5/6] ASoC: samsung: tm2_wm5110: check of_parse return value
>       commit: 75fa6833aef349fce1b315eaa96c9611a227014b

Hi Mark,

Hmmm, I had comments about this one so it should not have been
applied. The check if (ret || !args.np) is still not good (or
confusing) because args is an uninitialized stack value.

Best regards,
Krzysztof
