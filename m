Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1940C33C9E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:21:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7738120702
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ee12fky+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzLERXMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7738120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCB431664;
	Thu, 30 Jan 2020 13:20:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCB431664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580386892;
	bh=4FR3V5Wqezm6QMBb1Oyx7ZoTxLczSxnrFARaZBGvHqI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ee12fky+rca0m6+WVNbrcu+EMjBGe5//USEosRFmKAz3BqZkmHzukSYK3gsT4Kny0
	 TeX0+bQoJtzaV7Q0eROOnQ88P2fNM/gcy/j0cjOgIbvN9JtnTJc6ms5BWntBPFiIsF
	 Zv56lf6DryifBHm5N9OrJ29SQ9qlxO6A+GmeNMvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54A6EF80082;
	Thu, 30 Jan 2020 13:20:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69F2DF8014B; Thu, 30 Jan 2020 13:20:41 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0857F80082
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 13:20:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0857F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JzLERXMF"
Received: by mail-wr1-x434.google.com with SMTP id b6so3842146wrq.0
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W7kaz+UvUnrU1pfKncXXT57GaG2seo6lHJLVyC7XCUU=;
 b=JzLERXMFEmQfAtBKoCfzlRHao7XY0z7Euv0CBh8P1Oi8CozTqOwK//bTlEYwvUQzmp
 aw+egQd3aTgdgy7tkp7I8s82ye0nkRKZihRWOfpUD6Av2M7a9G3/G4Iuse+AL4E0cMv+
 CKn9nQuF5bhZmE1E2HmmHDcOQg3aIaw6fKhanhtdHqlNjr1UTU36leXTQ/iiwTRAMD8h
 HpiuOB1z9yI4UUDtMIB6H9QnbDcE5T4AJteHUmrX1G2ndory0xOtIx4THqANGBnXCHqq
 QR4cHZMNm/GTwt7Dn421LV1kJWufqoyYDpAE2/KGaIMGuIV5hBl3f8soMuL7kNMyGxjU
 GA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W7kaz+UvUnrU1pfKncXXT57GaG2seo6lHJLVyC7XCUU=;
 b=U27lCohDrvy/ROoXsdwDIT7nqIEzGl/2avq6jOcPRMVae/t/j/AO9s5+nn2zIk8lvW
 3VfCpF1d3fytND32IL5GiC4SoEo6C+AYv6N9ohpFVqEP1W07uJ9erqAexa7/0L35lFGF
 GMzi66/4vjrwoTswqEM3lo76y6ts3CDHRAM62VteU0uxuOKVKaUgdhJw0S3iz8rYrFfa
 zfRrqz6sdVALAbQBrsIVAUjIqxSk4xYBcmEZgoklniXk3n20yzJSIWkiL6bzQLxBosRC
 xcOkrSlaa1QpTMum824ZEKbokx6GuI6nbEpo2c2ueJiQxET7wnXmgFzyo6Pli9JV9F4S
 neCg==
X-Gm-Message-State: APjAAAWl1DHpsyWih6iSA2W5EVSz1CyDdUyXNBA/JMHdMmXo/9qUaGoQ
 Jdiz2zDqNKziml5Y6fE8MQwfxPRUY7IgAbNF8V4=
X-Google-Smtp-Source: APXvYqz3dzsRhsn6hnJG0vhOfGWwFCdRTp9GtQxga8KAxnqzfvJcedSNdNlv50Ov/cx+lY9Vdl2LrS5fN+cnVzQ3Sqg=
X-Received: by 2002:a5d:630c:: with SMTP id i12mr5467215wru.350.1580386837765; 
 Thu, 30 Jan 2020 04:20:37 -0800 (PST)
MIME-Version: 1.0
References: <CAEnQRZC=9_fnqEuBJsjc1QpCsXtV0NbAT0o_Yh58uMYGfHxz_A@mail.gmail.com>
 <eb665210-eecf-6ad2-caaf-a90c0e7d139b@ti.com>
In-Reply-To: <eb665210-eecf-6ad2-caaf-a90c0e7d139b@ti.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 30 Jan 2020 14:20:26 +0200
Message-ID: <CAEnQRZAdUVufU0e7DbpwNK2PFqeK99oHC=r6uM1M-B_4es_1UQ@mail.gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] Managing resources of DSP from arm core side
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

On Thu, Jan 30, 2020 at 2:03 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi Daniel,
>
> On 28/01/2020 17.14, Daniel Baluta wrote:
> > Hi Peter,
> >
> > Liam mentioned that at some point (when working for OMAP)
> > you might have had the same challenge I'm facing now.
>
> Sorry for the delay...
>
> > I'm trying to figure out how to properly manage resources needed by
> > the IPs configured
> > by DSP.
> >
> > On i.MX8 we the following scenario:
> >
> > - Application processor (arm64) exposes an ALSA sound card to applications
> > - DSP (Hifi4) does the processing
> >
> > DSP has direct access to  DAI registers but it doesn't have (easily)
> > access to other resources
> > like: pinctrl, power-domain, clocks, etc.
> >
> > I was wondering how did you tackled this for OMAP?
>
> It is (was, as the AESS/ABE support is not upstream) bit different.
> From the audio backend we do not touch the DAI registers, all setup is
> done on the Linux side and the AESS 'only' managing the data flow.
>
> So the back-ends are the DAIs and they are managed by Linux, the
> front-end is AESS. DAIs are configured by fixing up the hw_params for
> them in the AESS (front-end) stack, so they are configured correctly for
> the use case.

I see. Thanks!
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
