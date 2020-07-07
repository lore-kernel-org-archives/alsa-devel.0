Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF1AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15512206E9
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CX1oaCWv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMmuWprb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15512206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A4AE82C;
	Tue,  7 Jul 2020 21:05:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A4AE82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594148771;
	bh=0qz/rxKw4DPWxuZQa7o2O1i5X1PGdtaDYeIMzWFig/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CX1oaCWvxVz5eR9VomG0/43gddQ8aQSCplce9zmHtFJ5ZV6NPoCXp9tlZSsLrbGDp
	 ec/7DCIse7UAyRXsaUcTY0KJXriHnfi9ccvZHSv5vkL3KsXTqeZqf4ewR51P8sWcWn
	 4FcByuq3aish3VxTqw3pArEZtlwgeM5WsnkbT1pM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C041AF800D0;
	Tue,  7 Jul 2020 21:05:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B223F80216; Tue,  7 Jul 2020 21:05:16 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D00D4F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:05:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D00D4F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mMmuWprb"
Received: by mail-il1-x141.google.com with SMTP id a11so28722170ilk.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zHBejmL+SEJEUZLWBp9S+2uVbUS1y2+V9fjU/0Z1fds=;
 b=mMmuWprbmO3OMc1RefE29K1zXDuO8JlaNH8tje5ogRe5rJ4ve4trxZFjHaJjhOKJya
 DRrkO6ebpbkzjhCdMxuPX9qoKv4FqW7jLb/hYL0hVkbUT9SqgRoHebEjTdWUBIHK1snT
 Y5z5ZQ9jQkdQmFF3otSJDvzn/rpdfPD2uWI67yiTaHtEpFM3hgeaeB7nE6Fzq/0oEC/M
 wjcE6kpSGm4vY85tozymM6DAn9JFwfiU03w68gYy1NAAmM0SaMm3oTqaKh0pq47lheoo
 faKWmd93L/zmfcktF6wkbIa+ZJkruDMpQgnRXQsO1MOz7JazpxPyBOoh8G+3kiVzU2RD
 ZrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zHBejmL+SEJEUZLWBp9S+2uVbUS1y2+V9fjU/0Z1fds=;
 b=nzbd07EdpF9w/v9FSJOpTXBZ2oAV7nQKz7M6zKp58V+dGD5oRB9Th9AXIUj3xbGq4k
 uNBJYBgme1LHbNiWTHSAgw+6Lf7B01C4ZZS60kpmGX+82nYGNLbfVxyYIZKjW2v9T0mt
 j2SvyLxfRcYV9dUBCEhnHs4YLHlaBQf6RqFRlJFSLU6r39+SKbl6+lTGsVruTSSx72Gk
 0LKH1vfSXVr41N6Dj7qOiNeGfWyzs2gElqBh8iSR04S82VBpToA9mdaJ+yM+DWwZtEkN
 K0pdChCdoFbD1jzoJiIfOGEDNb4XfYXJ2I9PfpNvjlngRkl8psWMjFkMQwD/r+QtnIHH
 vBsA==
X-Gm-Message-State: AOAM530ohlv6CKjZhIK6bhivbL7fE0oYp70S1jvZ09qGX5G4IRSpwI1W
 vUEAB9PjNAnyVgJ2dNJ5MxLy9StJuC4e3VlRuyhPrQ==
X-Google-Smtp-Source: ABdhPJzZx2vZ8gOpaoCaI115NuW0J+qvLM9oGh6IAklm0sYCQj9ZNmCNoLXfl3CUyo/PwGj/JFIsNyJQo6/erOrH9qE=
X-Received: by 2002:a92:b684:: with SMTP id m4mr36746602ill.153.1594148705263; 
 Tue, 07 Jul 2020 12:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101915.GC4870@sirena.org.uk> <20200707103735.GG3500@dell>
 <20200707104017.GG4870@sirena.org.uk>
 <91692dac-1723-bec8-a6cb-88dadb9bf424@linux.intel.com>
In-Reply-To: <91692dac-1723-bec8-a6cb-88dadb9bf424@linux.intel.com>
From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 7 Jul 2020 20:04:55 +0100
Message-ID: <CAF2Aj3jvnAjddBTpFV9LbmZBDJcnfn_J8+Rw6+SJ8EEjUV_+ZQ@mail.gmail.com>
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 7 Jul 2020, 16:44 Pierre-Louis Bossart, <
pierre-louis.bossart@linux.intel.com> wrote:

>
>
> On 7/7/20 5:40 AM, Mark Brown wrote:
> > On Tue, Jul 07, 2020 at 11:37:35AM +0100, Lee Jones wrote:
> >
> >> Some of these issues have been present for years.  It's quite the
> >> coincidence that we both submitted these this week!
> >
> > I'm guessing you've both been inspired by the 0day bot turning W=1
> > warnings on without having first done a cleanup run :/
>
> Yep, I was tired of seeing my email polluted with trivial problems last
> week, as well as seeing dead code that reviewers miss but tools don't.
>
> Lee, do you mind if I merge your v2 series and my own v2, and then
> resubmit what hasn't been merged by Mark?
>

Go for it.

>
