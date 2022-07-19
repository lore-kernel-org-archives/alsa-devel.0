Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C3C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 11:08:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E33E516CE;
	Tue, 19 Jul 2022 13:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E33E516CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658228900;
	bh=68Rqe548wABX7ECQVIHyTFjxTSOtDdk3134YBldAMjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PDA29jYM0xq8r6hYRmNEnNWhYYraeBLDUnT7/B9Dftpi4Y5RJVSOZQri9LIFcC4YD
	 LKSLe3RyqNbRGXs+oX8V30a3V7t6ci+oC7h28Z5ECkjrs8Vnfj60CYMqkEvEiFi9xv
	 4ow1x5x3Q54o5D2FOqjO0tMAjotHcT1pA2Kr1Mrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 889EAF8016D;
	Tue, 19 Jul 2022 13:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F9D7F801EC; Tue, 19 Jul 2022 13:07:28 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16F0AF80169
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 13:07:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16F0AF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JQyJz1AF"
Received: by mail-lj1-x235.google.com with SMTP id w2so16933363ljj.7
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KZX9OkWnyGpukIHwA9hQ3y3ysqX2GQG+zpKVgvPG8eI=;
 b=JQyJz1AFb8/gJxfSAEgJ456WAeUYQDO+2+/GwrafXtB98x0adLUGtpLAyRtr//vhJi
 ixOrCsu7XxazpbuEPnVP8e1UFpTvsOI8r1bjnGG0Mw4KeKKGCxdOKLZAdRR/XFw5MSoe
 rcpSOIeTeCrxTd8znoYMhPtusjJFBIW5+UGlv50odRpxT2oF1UUj+u8qu7cZ9BMvsK5C
 FcSUJnHslk3/DJl+AOIXWUhSzxbgQiQzQhz/StakGXZzpGDHyQ6NfJ5868J/FdTy2t/2
 mhVtVQ9yZ8AC9WSPm1ob48G+hF1YztLA2+13ZhmEJa3PWSMKMizRRlYnBNKnyvTdZL9w
 3ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KZX9OkWnyGpukIHwA9hQ3y3ysqX2GQG+zpKVgvPG8eI=;
 b=3VHO56abSG8gitJvm1RK8nsZenWQhSndR6S6Zh0u/lQRDmq9wv303DkUntH/4Zpo4m
 sB5ai8SMwrhrQeIUjPW3jxOLa2nyhYABdktLLApEhonzZmgP7clIlShfVgkuuMHpX7vD
 N0NaR8KwtQHYO9pz+f0zLlVfSrFWMWy++7mCVkZfSE765Wq+iJZ7JRJxslnrf5GNFVNJ
 0TU2dtGi4R4UGhWW/sPGSHyH+MZ2bp4Q+ZJKhTXrRPKUft91C1oUU3nn3ANFFlru/U6G
 fOR46Hyq00gwnXSCZClYcc/jsg4qlQFcyZbxyGmRSB/xqo+zGIGlt7hK1OJN+OpxPTBG
 czOw==
X-Gm-Message-State: AJIora8XOPn3Vc7FohvDNie+fmcHUnqceV7EnrOZpoYJXDqOKw6dD4Z3
 aXHdReISW6/MZo19JxUlXUZfrvryc8z3tyNxa6U=
X-Google-Smtp-Source: AGRyM1uZo6G+pP3uxmrsV9nTWsYSjZ1BgWxXlS08BhNto12Y7m/pr6eM6an/ZqsICAvUvG1SwMPhjeyjzzyvoR6C81o=
X-Received: by 2002:a2e:8707:0:b0:25d:bbd5:c2f with SMTP id
 m7-20020a2e8707000000b0025dbbd50c2fmr3722343lji.464.1658228840068; Tue, 19
 Jul 2022 04:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
 <1658222864-25378-3-git-send-email-shengjiu.wang@nxp.com>
 <f2609401c8834e8bbe926200bfc87971@AcuMS.aculab.com>
 <YtaEpf6Cd7KH7wH4@sirena.org.uk>
 <20cfcc8e59a74166846cff028cd2c4e8@AcuMS.aculab.com>
In-Reply-To: <20cfcc8e59a74166846cff028cd2c4e8@AcuMS.aculab.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 19 Jul 2022 19:07:08 +0800
Message-ID: <CAA+D8AO6P2AcOJ+E97Y1=P72Qa1wjtMGMneWnsP+VcdnCzzYuw@mail.gmail.com>
Subject: Re: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format type
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Jul 19, 2022 at 6:34 PM David Laight <David.Laight@aculab.com>
wrote:

> From: Mark Brown
> > Sent: 19 July 2022 11:17
> >
> > On Tue, Jul 19, 2022 at 10:01:54AM +0000, David Laight wrote:
> > > From: Shengjiu Wang
> >
> > > > - ret = of_property_read_u32(np, "fsl,asrc-format",
> &asrc->asrc_format);
> > > > + ret = of_property_read_u32(np, "fsl,asrc-format", (u32
> *)&asrc->asrc_format);
> >
> > > Ugg, you really shouldn't need to do that.
> > > It means that something is badly wrong somewhere.
> > > Casting pointers to integer types is just asking for a bug.
> >
> > That's casting one pointer type to another pointer type.
>
> It is casting the address of some type to a 'u32 *'.
> This will then be dereferenced by the called function.
> So the original type better be 32 bits.
>
> I'm also guessing that sparse was complaining about endianness?
> It isn't at all clear that these casts actually fix it.
>
> The sparse is complaining about the snd_pcm_format_t cast to u32/int type.

The code in include/sound/pcm.h also does such __force cast.
#define _SNDRV_PCM_FMTBIT(fmt)          (1ULL << (__force
int)SNDRV_PCM_FORMAT_##fmt)

The change I have made does not cause an issue.

Best regards
Wang shengjiu


> (Mark: You'll be glad to hear that the office aircon is
> broken again - two weeks lead time on the spare part.)
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1
> 1PT, UK
> Registration No: 1397386 (Wales)
>
>
