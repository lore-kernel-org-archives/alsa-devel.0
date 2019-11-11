Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39EC17441
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:09:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B4421872
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K3vS2/Ok";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KzDbuOQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F474166D;
	Mon, 11 Nov 2019 23:08:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F474166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573510177;
	bh=fi7JHbHLzbO1Nhb3UW/aRIvkDyOVgTc9V9OW+rAlKJU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K3vS2/OkG1QjLbtqtahPH4L68sc7HNYTI6150OryLn3CVgetxY8CwaQL0KV9BZTPL
	 IREGa8+ewuNPyAb0L63+wRh322iuu6VfDmpC66IelllnZrGBHWhxR9lOPjinbOpAl7
	 8hzDQWhvJZ+WlpzQ/MjQg7HaYH12HLCuvr0wp2og=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAC9BF8045D;
	Mon, 11 Nov 2019 23:08:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B364CF804FF; Mon, 11 Nov 2019 23:08:44 +0100 (CET)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68BB1F802E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:08:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68BB1F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="KzDbuOQK"
Received: by mail-qv1-xf41.google.com with SMTP id g18so5531967qvp.8
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tPfL0kq62Lz7F7c05pYra0ok4V/5HL/RCOiRouaQRMw=;
 b=KzDbuOQKchCSFMrKmVPuNQ0SeBaBBb2BZaBnDWYVhhxOOTSs/u3NN8IruNTjAcOKtW
 XosuKjKG0PlDw05vl3XoP49dhPI3mkZQlcgYb7seOVoBhyh4Lyw+vfAuAVBmwhrox/7u
 +Fo5E19fcMKOX8nZf4Qb258fhUZMjEXLlEGC1IhW8dCtVOsaOYQ51B17dzqNiKtnPt/i
 HdSM1qvGlgUSWWQiZn+2sqrv09wByOeClX7VkmbnHQU+ZxbElfsuURoRZmlfkTRp6x2C
 R+Y3z9WosraC2zUcdJWxYNL2QKmYH6vi3EmL00DRp72b6usmho9cgpFRvwXAthx130vs
 xNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tPfL0kq62Lz7F7c05pYra0ok4V/5HL/RCOiRouaQRMw=;
 b=Br5eEQj2PO8dNWd+wJG3qcsgW0DVKGN3F2165vJW5sVkU+dds3qFWkVPg+gQOfsCQl
 1sFozCtKFiYVxvXSwpocjuStF/Yx/U5JrcUiFfhbzNjnS/QrcPsosy3QdK8QyWA4gPRJ
 q8ouiRIJtjlRNZ3bWbKAkMpnaCBOrNR8juZT8tE6ZhXQlPmu13l/NG+vGNbjNqF4vmnC
 VFTg+BEdV6vlAhOoGRwU79ktOIH7hZyeQ6WqgNBUXUo1RC4w2cjB/ArQIfOxVub66Mrb
 h18Js3di6XrmVNJwLdQUD+iosmuTjPQEmN9UeB+s4bxUT36vrQ6eGKn++dfGW0ud4Nw8
 xmCA==
X-Gm-Message-State: APjAAAWa6hJX4LM1VVDeegbt82CRvb76a7nffZuM123IP4b/6xRr6qtz
 84Eenped4x9zt1FTZdWm6vjZ/k9kOk1C9umRNCS5IA==
X-Google-Smtp-Source: APXvYqz6PRPMjHshzZ/548r+jBEtgUysDL8T4DdpOk+wsh0ak2bVZLoGynVyBvLjaMtkYgwnoGC25OFKOKY7Ot7sVrI=
X-Received: by 2002:a05:6214:12d2:: with SMTP id
 s18mr26090120qvv.199.1573510115974; 
 Mon, 11 Nov 2019 14:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-7-cujomalainey@chromium.org>
 <ba0fb03e-8085-d2c2-ecda-af454001c835@perex.cz>
In-Reply-To: <ba0fb03e-8085-d2c2-ecda-af454001c835@perex.cz>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 11 Nov 2019 14:08:24 -0800
Message-ID: <CAOReqxg+yRPDdkvPGoANLzuzpgu3e8KjyiQ=f==BvqrqnudtGA@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Curtis Malainey <cujomalainey@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 07/11] ucm: docs: Add CaptureChannelMap
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Nov 11, 2019 at 7:30 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 07. 11. 19 v 2:58 Curtis Malainey napsal(a):
> > Add ucm value to tell userspace to remap channels. This is useful for
> > systems with DMICs where there may be more channels than active
> > channels.
> >
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > ---
> >   include/use-case.h | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/include/use-case.h b/include/use-case.h
> > index 1aeaf9d4..31f9e4be 100644
> > --- a/include/use-case.h
> > +++ b/include/use-case.h
> > @@ -301,6 +301,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
> >    *      - name of capture mixer
> >    *   - CaptureMixerID
> >    *      - mixer capture ID
> > + *   - CaptureChannelMap
> > + *      - Remap channels using ALSA PCM channel mapping API notation
> > + *        E.g. "2 3 0 1 -1 -1 -1 -1 -1 -1 -1" means, FL takes channel 2,
> > + *        FR takes channel 3, RL takes channel 0, RL takes channel 1.
> >    *   - EDIDFile
> >    *      - Path to EDID file for HDMI devices
> >    *   - JackControl, JackDev, JackHWMute
> >
>
> I see a room for the improvement to have a better and complete mapping
> description like:
>
> CaptureChannelMap "FR=0 RL=1 TC=2"
>
> The location names should follow SND_CHMAP defines.
>
>                                         Jaroslav
>
I am definitely for that modification as the mapping for the plugin is
not easy to read, that being said, do we have a tool to handle
parsing/converting that from a string already? I feel like we should
add one if we are going to make that the spec.
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
