Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A6FA3740
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 17:49:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF1251E9;
	Thu, 27 Oct 2022 19:48:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF1251E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666892982;
	bh=6KCnP92hVg2b4OPU8MtnSYIJzA7N3h0NpJJjHHoL8P8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvlCYa/05Bg+vcjgW7uxamjW6dKm2scd3R+oJwaLdr7EMn+Pgcnw094ByBIxhy030
	 bndniZVrHJHaqIYxNhDOl4YQ4NTp/3NCsXl8TqXdYcQ91hfxzu8wO3L8v7OqW3wUiC
	 4hkmK0/X27N704/KEnPwLDpDGHACBSeWVr8GDV8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 388E7F80100;
	Thu, 27 Oct 2022 19:48:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEA47F8025E; Thu, 27 Oct 2022 19:48:49 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AB92F80100
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 19:48:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AB92F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="F2omDsoP"
Received: by mail-vk1-xa2c.google.com with SMTP id g16so1182958vkl.11
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KCnP92hVg2b4OPU8MtnSYIJzA7N3h0NpJJjHHoL8P8=;
 b=F2omDsoPpXXQur7mSB0dnyaFLhNZV4z5D7DchgCW6Bha04vnZBiTMnkZ0HojExFiPS
 KdBMG91XUVNUEYIc8uUkbTBBivETBLA08Oj1gsphbMKBc12iKgM/ePnqZYxnOBw1Gl5D
 jYiWDihIbAWf/Epw952HJ2d3CWz00/Qtm9/8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KCnP92hVg2b4OPU8MtnSYIJzA7N3h0NpJJjHHoL8P8=;
 b=Q8IkeqyO54D7HYzwinPBRlQ6aaw/JEwrQrwbGhmj3lyT8mUtiUk96Ig9yKEv+oCib6
 PluQI1sEk/04DVk0e4Y/E0xkbTtUZH3+KUcrIEgKdmif6DLFN9ke+QRnR3FDHnu9JsP0
 prs7CtaVbMaJK6sJVjzzzKfqYh2uL/dNoKdGL88icDI9mi6WVo9SUFz19rOeTJeNzIXd
 mnMs4gmacQe613TNdonIILKnYTDWu2MrdzGUJxd7JngClOfRtYxYR4YL+di5BPsSorwb
 rdABL9G1RP+8/YwbV3FS+kD9WV75Fgi4tIfwpTSqXjLVKCpfLxERrz8KZIJY4OTT3b4h
 WNWA==
X-Gm-Message-State: ACrzQf1gVGP1WXxd+Ehm2meVBQ3onkvYPFs1+bK0FRtsAZnjKxY9st+4
 JCseU8LK3wNT7AdkTuLNPNWjjUk4nRfeWxMNQn0bXQ==
X-Google-Smtp-Source: AMsMyM6fdbfm1xIT3CDDeYdHZqjTpKCb0UWp+jaha25OIvK5KR4BPj1fdpFAXxmgHFlAMdNMl+znMaqyHInybaIOGMg=
X-Received: by 2002:a1f:9116:0:b0:3a2:362b:fea9 with SMTP id
 t22-20020a1f9116000000b003a2362bfea9mr26689153vkd.11.1666892917792; Thu, 27
 Oct 2022 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
 <20221027143627.nbbketezqunkclxh@notapiano>
In-Reply-To: <20221027143627.nbbketezqunkclxh@notapiano>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 27 Oct 2022 10:48:26 -0700
Message-ID: <CAGXv+5Hki=VsvZrtANujFYseBp0Lxj4WVf3nzT7cx1kkMmWPFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Thu, Oct 27, 2022 at 7:36 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> > On Mon, Oct 24, 2022 at 3:01 PM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> >
> > The actual chip also has LDO1_IN (for digital core and charge pump)
> > and DBVDD (for I/O). However in the Chromebook designs these two
> > and AVDD are all provided from the same power rail, through separate
> > filter banks.
>
> What about rt5682 (no s), does that chip also have these same supplies?
>
> Also, since you already gave the purpose of these other supplies, could y=
ou also
> tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I could =
add
> some description for them in the binding.

As Mark mentioned in his reply, these are quite standard names.

AVDD is for the analog bits. MICVDD is for the microphone bias.
VBAT is called battery power in the datasheet. The block diagram
shows it going through an internal controllable LDO whose output
then powers MICVDD. This could be used in designs that don't
include a suitable external supply for MICVDD. If MICVDD is provided,
then one would turn the internal LDO off.

So either VBAT or MICVDD has to be provided.

ChenYu

> Thanks,
> N=C3=ADcolas
>
> >
> > Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> > LDO1_IN for power sequencing, just that three should be toggled togethe=
r.
> >
> > Should we model these? Or wait until some design actually splits these?
> [..]
