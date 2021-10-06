Return-Path: <SRS0=g44s=O6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81671C433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 10 Oct 2021 07:51:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F4C61056
	for <alsa-devel@archiver.kernel.org>; Sun, 10 Oct 2021 07:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F4C61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22C8B1664;
	Sun, 10 Oct 2021 09:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22C8B1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633852267;
	bh=XztkHHBko9Otp7UYrs4TVmHm1HrNlkMmqCRgxQa0Ntw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFcmmeM48HLE/9ucxJW6qJx3MSkwHFzqxOH8vTgR/ODWkAyCRJp3k3dwC3JRRltg8
	 6GoCWzjAZhhoCxcR3kjAQRkEaHmkFLr+q8nTruBgbqA+MaQ9/PmJUHljz2KR/peBcn
	 2763VIqHh3kQOHnQMnD2ubOx7Sro4ABw6M2H+pgI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 376F6F80302;
	Sun, 10 Oct 2021 09:49:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5DA7F8020D; Wed,  6 Oct 2021 11:09:28 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB8C2F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 11:09:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB8C2F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Y+lq3L8P"
Received: by mail-lf1-x132.google.com with SMTP id i4so7599739lfv.4
 for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2021 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3vIcEyr7QuVBCeh3mAP0j/ko23BFx3UEwrFTydDoOjw=;
 b=Y+lq3L8PXp/1DJR4LuSkH4uvV2i5I7JQW+Mg5eysonjJbDnGZYTGpaPdiR11IGqjhG
 JKH30t3CTeuWR3tTFw37vPdfhQwu5/jIu1wDWVkbzn89HlN35RhhEDICcFfEyNVMjckn
 SjqvEwF93o+Dll9Ho4OF2rQq/2zRsHdhwwtEhEOIwmkXpKoFcrqFxO4DVljYJs9D2ltS
 oFRDnzfCFwXbYYBsbXNY19dMVpF/xPb1fOKPr0zirVmIqBcGNmZLUQdMU4uSmOpxMzvJ
 0Ku5Vl+pdpzY8bLAUf/jPHbkD0qTEQzay2idwQYGswCmlxim/4JK2TC07JRXpKgjrVdf
 A3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3vIcEyr7QuVBCeh3mAP0j/ko23BFx3UEwrFTydDoOjw=;
 b=EhzUKAgRWMOHFvrNMSWTStIlFef+FxYjOwimMuKV4Jlc2klQ3EIITT2mVZmQch1RoB
 QHmJ/ysSxtjwqzC7EwSO61ImPWUqWV1VvGpVGLGdMENUTS02eOghMpPWdafKJoczVwK1
 SWGrGvF7I9D5XxsgX4yOXdt/KrqPi1WqYlzKCCVYkPLFSOzbBiY2pduRhm9tG2WKz36l
 3X+A/xkZDGOsb76wtdXA0P4Zk0c0GVMM1V7cDgeOBA94bRIyDmdmImlqX9aHrW3f6+ed
 IKUpgUpbBkXyn3+s2ItDehkYFx3XkCrfJDsScN/2+YD0AvINOFUAKgp9B8UAXs7tO3co
 kFYA==
X-Gm-Message-State: AOAM532cCXuT8nepWpjCtauN1D8535pj08GTBHNvsa+gurTEyX+2MfKj
 08kcVsp9tWzso+o3HARjvdBnqIoXhRcaOshhoV8=
X-Google-Smtp-Source: ABdhPJzMfNeD2VPG/6FkmkYV9CXq06WhI5WUIlsAqQRktPRR9FccwJ9bJa1onYE9OFp6sVr+8NN/olw+7nSRxwBQT1k=
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr26860600ljg.415.1633511363662; 
 Wed, 06 Oct 2021 02:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <1633396615-14043-2-git-send-email-u0084500@gmail.com>
 <YVw87lc4uXSvCiyC@sirena.org.uk>
 <CADiBU38X6nY1D7NpgW8+61AX6rUU7jngnPagryDKxUAKdtGjAg@mail.gmail.com>
 <YVxIv6NOiVdNSkXf@sirena.org.uk>
In-Reply-To: <YVxIv6NOiVdNSkXf@sirena.org.uk>
From: ChiYuan Huang <u0084500@gmail.com>
Date: Wed, 6 Oct 2021 17:09:12 +0800
Message-ID: <CADiBU3-A3vcn9ekKnL+mRjafHzi25W0OQs8HzGg_t99mtJurWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 10 Oct 2021 09:49:29 +0200
Cc: oder_chiou@realtek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 lkml <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 tiwai@suse.com, cy_huang <cy_huang@richtek.com>,
 Rob Herring <robh+dt@kernel.org>, allen lin <allen_lin@richtek.com>
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

Hi, Mark:

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 05, 2021 at 08:36:44PM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:54=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Tue, Oct 05, 2021 at 09:16:55AM +0800, cy_huang wrote:
>
> > > > +     /* Default config volume to 0dB */
> > > > +     snd_soc_component_write(comp, RT9120_REG_MSVOL, 0x180);
> > > > +     /* Mute by default */
> > > > +     snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
> > > > +                                   RT9120_MUTE_MASK, RT9120_MUTE_M=
ASK);
>
> > > As ever you should leave the defaults at whatever the hardware defaul=
ts
> > > to, the defaults for one machine may not be suitable for another so w=
e
> > > shouldn't be trying to do that in software.
>
> > The default volume will be kept in value 0x7ff (mute).
> > I just want to follow the ASoC flow to control mute/unmute mask by AMP =
on/off.
> > If to default set volume to 0dB and mute is improper, user have to use
> > mixer control to configure the volume.
> > Does mute function also need to be removed also?
>
> It's totally fine and indeed quite common for devices to be muted by
> default - usually systems will have UCM profiles that unmute things by
> the time users actually interact with them.
>
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.

After asking the HW member, there's already builtin HW volume ramp function=
.
Mute API is still no need. There's already no pop issue without mute functi=
on.

So the next change, I'll remove the default volume and mute config,
and also mute API.

Thx.
