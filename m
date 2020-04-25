Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64FC54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 16:51:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D07206CD
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 16:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N4lxHsWf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmgbXANI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D07206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13AF61675;
	Sat, 25 Apr 2020 18:50:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13AF61675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587833500;
	bh=IBrQA0sWavx+VgeS5B+KNVP1/p1YFoY2NGsTfX3pRTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N4lxHsWfhevKtafgvPId2/lG348tUDlrHnbYqe2j3oR9C8rcBMOSANf1ANuS83Zx8
	 iLmznv3nPo7LfA6o6Eqy/z80EiquCHPi0vymQi7+7GyM9s8Ly18n6jdP9kHhtDDuyz
	 DkArwp4nbd6ewE57jIJ7AFqycROqLSQSm0pJ1Y9I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A121F80105;
	Sat, 25 Apr 2020 18:50:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B613F801EC; Sat, 25 Apr 2020 18:50:47 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1291BF80105
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 18:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1291BF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JmgbXANI"
Received: by mail-lf1-x142.google.com with SMTP id j14so10292154lfg.9
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IBrQA0sWavx+VgeS5B+KNVP1/p1YFoY2NGsTfX3pRTs=;
 b=JmgbXANIiy+yvJTOgWJ69WOcxnO23NOs+ej0zq/lOA+fimLXbCycNCr7ZL378I7tKv
 nQlwLvEa94rgnRj/kCgA3uMh2hdO9lpN0Q9uDTXePgMOOj24HcC5ui0Cg7MtAeTITn2C
 FQ2njeZ5zLhlLwpOkXb4EFftUXk7L2nfPene+xINhR9kooB/ZqAPnjiutcFyPcGv4hCw
 1Ur/JXdEnXaxpnjqDt2bA5yzXzugDcZkLd+IjLRPrGhsU4JERPOvQ8OzmNqaYFCsSxPz
 KXUpt2/P6iH3X+hwm/Ic+su+8v9ZBLuzS9houlXt0VR5vqPW/LVWrwH1aPm3a+JZ9S3b
 tMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IBrQA0sWavx+VgeS5B+KNVP1/p1YFoY2NGsTfX3pRTs=;
 b=RNE3Y1G4I6WLUSuhbMOjhPhYOqR74fAwZUbf6PhPixasHvuozy5oLegI/ii/lVg6Pm
 mMOKKLCaKe5ifOekhUfMcYv0AUk2heqHQqxfFCcwed9obQ0hJsgCCmBMZaG9K7UlErPf
 e9BdE0Sa9MuZaabGYICk8xUhSroaDy6D1tuQ6eSfG972k1W+vqcU/pPzSiEbxaxfnS1f
 gkhbqqc4abuJ37Gsiwsv4lEISa435LCG1JNQLr48VuRXvtGuPYj1ZgNpsE9M/+hWxF3Z
 ji8nSqjdaMxmLfRmMldT3IWWaBOXgdl8Tuoqn0sdPtzz4vatGZUc30ZOn13CIaZGt/uv
 w58Q==
X-Gm-Message-State: AGi0PuaoLzdHiN1lwRum/ynCoGNTS7TeMZAoZlnMVoFr7oKtYQAlvjHF
 eUwmZVvidxT89A803nYtwAWJfa0wSPCskZIgn/k=
X-Google-Smtp-Source: APiQypL6Ex05xMuCwbbhanyA9CcFXv6jeXzAQWgzgWB8jsfk4iSHUDnW/PREVPmHKFM+EaHdMQfnvNd+TVaqE2mpCbk=
X-Received: by 2002:a19:550a:: with SMTP id n10mr10039353lfe.143.1587833439497; 
 Sat, 25 Apr 2020 09:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200424022449.14972-1-alexander@tsoy.me>
 <CAOPXC2kF-k9xH8KhP_s+RmebgTdZW7avn9uedMRAooOB5WhzCA@mail.gmail.com>
 <6eb7b878b82659f7e9b9859186dfe40320402438.camel@tsoy.me>
In-Reply-To: <6eb7b878b82659f7e9b9859186dfe40320402438.camel@tsoy.me>
From: Gregor Pintar <grpintar@gmail.com>
Date: Sat, 25 Apr 2020 18:50:28 +0200
Message-ID: <CAOPXC2nXJBp_qhOZwQALbB5ZQh4O-jPMVojCGUG-9tNH7-dQ3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Improve frames size computation
To: Alexander Tsoy <alexander@tsoy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Roope Salmi <rpsalmi@gmail.com>
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

On Fri, Apr 24, 2020 at 6:44 PM Alexander Tsoy <alexander@tsoy.me> wrote:
>
> =D0=92 =D0=9F=D1=82, 24/04/2020 =D0=B2 17:02 +0200, Gregor Pintar =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Apr 24, 2020 at 4:24 AM Alexander Tsoy <alexander@tsoy.me>
> > wrote:
> > > This patch fixes this issue by implementing a different algorithm
> > > for
> > > frame size computation. It is based on accumulating of the
> > > remainders
> > > from division fs/fps and it doesn't accumulate errors over time.
> > > This
> > > new method is enabled for synchronous and adaptive playback
> > > endpoints.
> > >
> >
> > Hm, I still sometimes get click usually in about first 2 seconds,
> > but it is hard to reproduce.
>
> I wonder if it's because the driver doesn't honor wLockDelay. Anyway,
> the second patch can be reverted if there are still issues with 2nd gen
> Scarletts.
>

I just got click with async. I better stop testing before I get click
with 48kHz.
Could this wLockDelay affect async too?

Does anybody else still get clicks? I would totally think I'm mad, if
I would not
record them. Maybe it is something else.

I guess I will just switch back to 48kHz and try not too think about it.
