Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389BCC43465
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFB02085B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bj8zG6Wg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1xvXmos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFB02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 575C016B6;
	Mon, 21 Sep 2020 19:15:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 575C016B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600708589;
	bh=9HWmOQH7e587AlVY6KVBtHvZovBVBdabTljJbYGF9/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bj8zG6WgOoe85rU31FWPsrxHaRnfvJGZ3C0o9p0ep60fHlhwM4DDCqAFYafS4s3MS
	 mRXwsFpb+Vv8vCAnva9xuTOnYPbr0O/U6LNq7FnzIKjrOKODwDptPltYMwVZjjjdXJ
	 PfWO3DI49jNoOv5Pw0AUenK7LREEsv72pSakBGOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD13EF80161;
	Mon, 21 Sep 2020 19:15:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3357FF80162; Mon, 21 Sep 2020 19:15:37 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E73F0F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 19:15:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E73F0F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="a1xvXmos"
Received: by mail-io1-xd41.google.com with SMTP id g7so16184723iov.13
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OfjpKCjgpFcyIPadh1UeQQlqIJ/XQ8FTUIY77xhbs1M=;
 b=a1xvXmosY39aq2upt7jpTrsD4onvVX8CyT0/UwKVqUS7KlrTR0AIZii4mUTvT32hmA
 i/0S+WQLWmKm3JW8G8i16TOuvz/hze0R9QTcDctff7exS5RH9aTEon6Ks4J2C1XrLpIq
 xFqUaJfXncTM1HMMug97koDCv/+ZeV9t5l7roUlBfTvxjwg2gkiOFv0kNRzglmFEmxoN
 En3Z/sxR3CXjsx4MCibYjSY7G0OvMc6K/zvr4xIUxmel8A8XPK7XyJDlKGlgPX/pOj4W
 qo32rdACDgyvcH4JPfCUN+ic9b57C4nWB5JEB9lk0ckIlmA52RJokQdnJ+2vUXBLEiBn
 bWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OfjpKCjgpFcyIPadh1UeQQlqIJ/XQ8FTUIY77xhbs1M=;
 b=m19N6g/G8/1GEG96O1KlehhNlqwDDfFjyfh1+67c2zbphLzrDWAkLuyPjAliQw4mo6
 5RA6JqLc6Famiboey1ObDpj5q1VgarXKow5ve9Clvf4sm3fppUexK00BgYtUtWSOXvXK
 J7Rxoz9FBjkfHgjziEIvyWAZfNLTfREofd3gNuCCXMLS5/7wFm4DEO/CDoyEwXyasQqA
 H3kS8GIksbn5LFHIuZ8Ufm1jpjjNp9kZ7HRxSqgOf/wAEaM4hPA/nKyrmXmSvWSa+UjD
 4m2RLCJ5KQi7xg5w8VhQ8dI26PP068r/G+f+zyH64SFnemPXRMFYkK1TXdTQFQka5InQ
 rURQ==
X-Gm-Message-State: AOAM532EQoxllKeac7h2rNq4W7G57v2EgFwFd+cL7uY6gSVs7271xlH/
 uRUE9PKRmZC/sRpgUOZKQueac3CcUH9OFngKBZE=
X-Google-Smtp-Source: ABdhPJxZBxQ1fxsquRrTgaINgoIJXJR0GXEKUzOWZH8kFP5ZkKMxh6FQDWwyDbq36aMx3Yi3EhEDiEA2U3q/7QrGEac=
X-Received: by 2002:a02:734f:: with SMTP id a15mr907939jae.120.1600708524243; 
 Mon, 21 Sep 2020 10:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-3-peron.clem@gmail.com>
 <20200921122918.kzzu623wui277nwr@gilmour.lan>
In-Reply-To: <20200921122918.kzzu623wui277nwr@gilmour.lan>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Mon, 21 Sep 2020 19:15:13 +0200
Message-ID: <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
To: Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Hi Maxime,

On Mon, 21 Sep 2020 at 14:29, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 21, 2020 at 12:27:11PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > As slots and slot_width can be overwritter in case set_tdm() is
> > called. Avoid to have this logic in set_chan_cfg().
> >
> > Instead pass the required values as params to set_chan_cfg().
>
> It's not really clear here what the issue is, and how passing the slots
> and slot_width as arguments addresses it
>
> > This also fix a bug when i2s->slot_width is set for TDM but not
> > properly used in set_chan_cfg().
>
> Which bug?

Do you mean my commit log is too short or is it a real question to understa=
nd ?

To answer if set_tdm() is called then we set the i2s->slot_width and i2s->s=
lots.
But we use lrck_period =3D params_physical_width(params)
instead of lrck_period =3D i2s->slot_width ?  i2s->slot_width :
params_physical_width(params);

>
> Also, Fixes tag?

I think this only happens when 20/24bit is enabled so the issue has been
introduced in this series.

Clement

>
> Thanks!
> Maxime
