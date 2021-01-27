Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632E2C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 16:37:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BCA64D9D
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 16:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BCA64D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8F0816E6;
	Wed, 27 Jan 2021 17:36:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8F0816E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611765462;
	bh=VaXvFofDQBL43I0u6dtbr2m8OtQ1+s1/YV8MzWBJU3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AR7vBVdau2Ro8ckYf0HSoqYQ15uDHtW4blMOauhBBtPAjL065f1yf7JQm7DF8Ia/g
	 hDoC1gyHSMITDwnPcDnNqSSvQWEd7zTE7cgZ9N1ZV8VIJy4+XAOBZ/xcElWnx0kxaF
	 v28YuEv27e6dWSgomWv04jhXX9ift+F108PcLG9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22AD3F80218;
	Wed, 27 Jan 2021 17:36:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3D76F80259; Wed, 27 Jan 2021 17:36:50 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE225F800F0
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 17:36:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE225F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="EWz0LkYB"
Received: by mail-wr1-x42c.google.com with SMTP id g10so2603627wrx.1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VaXvFofDQBL43I0u6dtbr2m8OtQ1+s1/YV8MzWBJU3Y=;
 b=EWz0LkYBq5Nywb4xl/My35Fixpsum7hCQKUhKJxBgW02Si/UzjX4UHtG5Aqmn/WvUP
 JYJVpIWtO7g3e82G3hKzowHgfNCUeW5EirVQR9ppnwxjolQuhRC3ACc8ZxeaZOktD2aq
 qaWmavxvynzJTodXRtVNOp+xiQimRXk2uVsIUEvsqi/J4BoLkHdv6LYuMmV6NFmZfqhj
 GjRw+z6C/On2/cUL76j5MpbrP4lbZK09jXsn+Rpw2ouoN6Vu9TF21hhVvbqzugA5F2oh
 5W00CTOdFlTxV0/11pjk6lk3IV+VchqSAPwE5dJ1hbeWEhYT9LsJiNfr9ZFQBvXySe13
 ZWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VaXvFofDQBL43I0u6dtbr2m8OtQ1+s1/YV8MzWBJU3Y=;
 b=aBISM2zuXNmjHMki++Kkk9IgO1wLJmnjWT5WdNDUMmO1zhnhUoNTIhdU280gOfVISm
 lFjUWM/adEzJdtujUEQbjU8KitnKOfgaEiz7deHxKdpu2ThFMwN+FiAMLzQKs7U9GyjP
 sdRl2IvbCS9FEASCKWAU4kwELjQ/hnznPm5ZnFNKC+4IaUSh3B7asZ1Vm9Wy8azLSYeK
 pGo1dh52HMKNxilSpCWv8FJqNaJ3a5Bzmbd3hin2JrnXNPdYcT/8CF+qi8sAjZIeh5nv
 D7FSIiI6i2rM9d21TUM8ZKRwInLKrP2aLzMTvptCg4+xfyVd0fUqrKBRPbGCXK8mFMou
 ddJw==
X-Gm-Message-State: AOAM532YPYAnoO4qSJ2qurhjT92LBUg0jZc5Rr28O4YMzDCN3i9nOC5w
 GpcZIwIGfNqZ/D8Ss5zJZzYILhY+CqBqesRCl0s=
X-Google-Smtp-Source: ABdhPJy1eeybekzidx0QliVZxuDpU6HjIbJ3kRak7obqIc44Oxlvar4O/7qcIT3/NHPLNpX9dTi9BKLD2NbTPDmJxuo=
X-Received: by 2002:a5d:5611:: with SMTP id l17mr12361882wrv.2.1611765404004; 
 Wed, 27 Jan 2021 08:36:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
In-Reply-To: <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Wed, 27 Jan 2021 17:36:29 +0100
Message-ID: <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Len Brown <lenb@kernel.org>
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

czw., 21 sty 2021 o 18:47 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> na=
pisa=C5=82(a):
>
> =C5=9Br., 20 sty 2021 o 23:28 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> > >> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine=
.
> > >> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I=
'm
> > >> sending this to both
> > >> lists. The W taint flag is because of an unrelated nouveau failure (=
It
> > >> was busted on 5.9, and is
> > >> still on 5.10). Full kernel log down below.
> > >> It's from a distro kernel, but I can build my own kernel with patche=
s if needed.
> > >
> > > Please try to add a check for handle against NULL to
> > > snd_intel_dsp_check_soundwire() after
> > >
> > > handle =3D ACPI_HANDLE(&pci->dev);
> > >
> > > and see if this makes any difference.
> > >
> > > This should check handle against NULL anyway, even if it didn't crash=
 later on.
>
> I'll do that later.

Weird, I can't reproduce this problem with my self-compiled kernel :/
I don't even see soundwire modules loaded in. Manually loading them of cour=
se
doesn't do much.

Previously I could boot into the "faulty" kernel by using "recovery mode", =
but
I can't do that anymore - it crashes too.

Maybe there's some kind of race and this bug depends on some specific
ordering of events?

>
> >
> > Is there a way you can share the DSDT?
>
> I uploaded it here: https://people.freedesktop.org/~mslusarz/tmp/dsdt.dat
>
> >
> > The only thing we do in that sdw_intel_acpi_scan() function is check fo=
r
> > an _ADR and read two _DSD properties. I think it's been 2 years since w=
e
> > wrote it and never had an issue, never say never I guess...
> >
> > If you want to bypass this problem for the time being, you can add a
> > kernel option in /etc/modprobe.d/alsa-base.conf
> >
> > options snd-intel-dspcfg dsp_driver=3D1
> >
> > that will force the use of the HDaudio legacy driver and bypass the
> > driver autodetection.

Yeah, this also works.
