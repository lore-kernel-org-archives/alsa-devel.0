Return-Path: <SRS0=ggqu=GJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB8C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 21:23:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561FB2313A
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 21:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561FB2313A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC63C166A;
	Wed,  6 Jan 2021 22:22:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC63C166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609968178;
	bh=EvHaluwIjbxzvXLKBZkhcHnxN0hbgNhiT9MKHzyyuK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nb6smqcQMQLgY53Vt8T8jJY5cP6o/fL4db22KL9JMkWI+Sb+ZAMCJkR8xhAjeZsiz
	 pMdzQK0fwO1poUnVsmoxHmNUmEdN/pj1vhpZoJ4uJNKbAawVbK++uZEZP3t//2JQGq
	 XWZTMZZCAHALE/gFFTmXvEg6TqqgAyKUQ3XJ//l4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36DCDF80165;
	Wed,  6 Jan 2021 22:22:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDC76F80165; Wed,  6 Jan 2021 22:22:05 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30447F800DD
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2021 22:21:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30447F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="U6s8cl75"
Received: by mail-ed1-x533.google.com with SMTP id u19so5779054edx.2
 for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2021 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+kJUG3qmiqeI4v/rmszW5dftC3twkY4ThLEn2qVvnz0=;
 b=U6s8cl75dKrBs9QfcuFlDuFoqgtm4dXCWSl/9JbH5m46Fu+a0bBYgVgnZAzr0BgCG8
 XOJL3WifF7TNjqWD/qF/zFaDNFkH46Oj2ZjN49gnAQzEnK3lGX45T2HRhwSrFEIC/B5b
 ojdBtbHJnTuPAmXOvQ9EtDY7hya91o5Xo/IWf+JRw2070ynd9fD4fNwDsy0B/qLy/nBf
 cgEGpx0o8Rw2yzavl/j7pWYZxoxtJnkbqwWIjTwUChRA2FUlC3PdiZcdNP4AJAKZieht
 9ZlKUWlOLIj4nwZg1SeUIG1jjQT4cXwhOYcPKJpBPe7ETJxzQav7/NWcgHt93m0DvtoF
 BloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+kJUG3qmiqeI4v/rmszW5dftC3twkY4ThLEn2qVvnz0=;
 b=MmpveGadDqtbJP3pKldP2lP613FGrJgnrca4etKpWn3qUpANnrO+C/r13o9yqK8DYu
 Vl8Q8kMUgNU2CIwiTgtQAjS7FL5fZGKUKFvNX/8I1v79364c5xoDyEEsqilE+gHtKFXz
 4lLQmR8xU1CcORr3Gw1MC/ni0bBbL/KqsuIS8kAZ5/Yb6Cu7NtRHiHn/ySgP49fzw5Xh
 WjUEsvKdFI1hZa3J98Dg8vCwHxUTgw8BvAXrGR+wwThBdSBIyKg+84lXRimmGVgG7jsz
 YmkxrtydvV6n56LDdxsESf1juze97i4i69sdWqdMztrAgzUOfGziAV+u0/OkwtUQXUN3
 n4OA==
X-Gm-Message-State: AOAM531LzXxjrAYMjzffg9qcAhhJ3+SBOlssBIbz3LDoG6vGEiWcFned
 r/eeWDMo/sZb2GW4SlnYupUXtapAht/ZjY8MqzI=
X-Google-Smtp-Source: ABdhPJxnbE3ik2Ny6dZGycAINdBJVP7Gv/IusbjJKYpHiw8XBj3JYbYG0XZxLR/ZGCh9CcagzA9486gF8KyPi+9hwnA=
X-Received: by 2002:aa7:d846:: with SMTP id f6mr5217613eds.55.1609968112943;
 Wed, 06 Jan 2021 13:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20201225012025.507803-1-pgwipeout@gmail.com>
 <20201225012025.507803-3-pgwipeout@gmail.com>
 <0c3665b2-bac6-546a-bdd4-0ab7a90adf7c@nvidia.com>
In-Reply-To: <0c3665b2-bac6-546a-bdd4-0ab7a90adf7c@nvidia.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 6 Jan 2021 16:21:41 -0500
Message-ID: <CAMdYzYraT5AXzyscN3Pa+0FWZwHFsD-4ZwbA80kNxgtn7Y1PXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda/tegra: fix tegra-hda on tegra30 soc
To: Sameer Pujar <spujar@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Prashant Gaikwad <pgaikwad@nvidia.com>,
 Mohan Kumar <mkumard@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 linux-clk@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>
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

On Tue, Jan 5, 2021 at 1:30 AM Sameer Pujar <spujar@nvidia.com> wrote:
>
>
>
> On 12/25/2020 6:50 AM, Peter Geis wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Currently hda on tegra30 fails to open a stream with an input/output error.
> > This is similar to the issue referenced in [1].
> >
> > For example:
> > speaker-test -Dhw:0,3 -c 2
> >
> > speaker-test 1.2.2
> >
> > Playback device is hw:0,3
> > Stream parameters are 48000Hz, S16_LE, 2 channels
> > Using 16 octaves of pink noise
> > Rate set to 48000Hz (requested 48000Hz)
> > Buffer size range from 64 to 16384
> > Period size range from 32 to 8192
> > Using max buffer size 16384
> > Periods = 4
> > was set period_size = 4096
> > was set buffer_size = 16384
> >   0 - Front Left
> > Write error: -5,Input/output error
> > xrun_recovery failed: -5,Input/output error
> > Transfer failed: Input/output error
> >
> > [1] states "Due to a legacy HW design problem", implying the issue applies to all previous tegra-hda devices.
> > The tegra-hda device was introduced in tegra30 but only utilized in tegra124 until now.
> > For this reason it is unknown when this issue first manifested.
> >
> > Applying the fix in [1] universally resolves this issue on tegra30.
> > Tested on the Ouya game console and the tf201 tablet.
> >
> > [1] 60019d8c650d ("ALSA: hda/tegra: workaround playback failure on Tegra194")
>
> This issue was never seen on Tegra210/Tegra186 and hence at that time it
> was thought to be specific to Tegra194. I never tested this on Tegra30
> since I don't have this device. I will clarify this with HW folks if
> workaround is safer for all chips.

So this is confirmed to not affect Tegra210 and Tegra186, but it does
affect Tegra194 and Tegra30.
Is it possible for the hardware team to pitch on on where the fix was
implemented?

>
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Ion Agorria <ion@agorria.com>
> > ---
> >   sound/pci/hda/hda_tegra.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> > index 70164d1428d4..f8d61e677a09 100644
> > --- a/sound/pci/hda/hda_tegra.c
> > +++ b/sound/pci/hda/hda_tegra.c
> > @@ -388,8 +388,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
> >           * in powers of 2, next available ratio is 16 which can be
> >           * used as a limiting factor here.
> >           */
> > -       if (of_device_is_compatible(np, "nvidia,tegra194-hda"))
> > -               chip->bus.core.sdo_limit = 16;
> > +       chip->bus.core.sdo_limit = 16;
>
> Future Tegra chips address this problem and hence cannot be enforced by
> default. May be we can have like below:
>
> if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
> chip->bus.core.sdo_limit = 16;
>

It will need to be a bit more complicated than that, since the
tegra186 and tegra210 device trees have "nvidia,tegra30-hda" as a
fallback.
Looking at the generation map, tegra30-hda can be the fallback for the
broken implementation and tegra210-hda can be the fallback for the
working implementation.
Does that work for you?

> >
> >          /* codec detection */
> >          if (!bus->codec_mask) {
> > --
> > 2.25.1
> >
>
