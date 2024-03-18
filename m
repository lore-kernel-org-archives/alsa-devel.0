Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E5CD11BF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:03:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 769FE218C;
	Wed, 20 Mar 2024 15:03:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 769FE218C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710943405;
	bh=0Bx39X9nrmaOe2siDGBtD8UvPB5+0atvcfW4BaACz+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HkLNwjYqcIDdTiopkYtKsZwFAMytGx3qTqdZ9gbTlVWrWfcLnY8OR7i+CiUtqfKD/
	 TLWdT1qaUB6g5ytClpF4dVYtLeg7BhPZB7t09kxrj5bmi6Jhms4WORs69t1DyX/871
	 ZB465Nsc3s6Mt1W/a0PrVDKpUsHR4UAJS8DueIvQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09CB4F80716; Wed, 20 Mar 2024 15:00:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D872F8074D;
	Wed, 20 Mar 2024 15:00:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58FE5F804E7; Mon, 18 Mar 2024 12:12:44 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32D8FF80093
	for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2024 12:12:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32D8FF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com
 header.a=rsa-sha256 header.s=20230601 header.b=DJi3a5hf
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-609f1f97864so45693587b3.0
        for <alsa-devel@alsa-project.org>;
 Mon, 18 Mar 2024 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1710760358;
 x=1711365158; darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJoZDN6ezIJlLMa5gaDKCST13mLnHhS66r8V7Evf8Jc=;
        b=DJi3a5hf3dhNRnaOYUf4LVQdKbcPXH5SM0MRphqKXo1vECM8YsI+xZaVGTL5t9w96e
         HS3lgwuICJLX6tLSpUbB9/sY03k48ltkLDl5VXL3WC4aFqZjJCN2zW8Q+UeqmH0+PVOF
         E01Vh8mDw3uhlXaFyULK93uBbFjQKMoxr910CMixaBp0ypElLzEtESALyGWCz7i4iVCK
         Uy9+7689/cSdv+ECXfCdULxykF4dhmOE9VzDBxRKMuifJavyp7Q9qTfBsUsfq/6wWQT6
         /JZtrEizuTA9F8+f6aAGLqo8WLF/mGT5BlzJnL9R9Atac6fCemUUTDqjC/cWUU+io0yY
         OivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760358; x=1711365158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJoZDN6ezIJlLMa5gaDKCST13mLnHhS66r8V7Evf8Jc=;
        b=B/QdoRUD5gcmpbN7U51fMxtsUcE/+vuF9pIvnxhMP5MQhMNEjAoOhFBZ9edEHxk2Cl
         PyZRPRA0hjrpxxX01VANziWvMVbxZDrLJx+S9uJwQTDs4snA9TL/69tgYWUieQil+Qw1
         Z7MDGCspaAKz0U1kRhdNuFH25jLH7xE8doZum4U45NXo6S41p/k92QQf4sVYic8o+uOF
         F7Tl900HuiB9V6jeRsumwO6zPZ+z588xN38EFBJ0kg9iH//cxYzg7aqFMFskHMm49EVz
         1vH88Dv/JIv+jIqG/8Y97B9avYEaXMS/eScR93Nw0pHEH6CHK5LJJ2451w335vUQEFgM
         8esA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsqRnGW1wRXMBNcpWBxa8Ks/8Iih6LcgLEXh49ehi9Chr3AINIxODy0f46ELBO5uKxXlf0jJKma5nr6livLyuNHUHCYvAPfjDFOTo=
X-Gm-Message-State: AOJu0Yz8+7PoYi/zK75pdeVK8t85DovtCG81IvQy02+mHLWkyqeN6pVG
	WHSZlHCiVQ2S5nFFhl4z8d0U3To+NIGcQmfM4yWV5+rccqkFbKBQCKlvJFAuLsHmlvSVUnqdBWl
	px+t/ck5H+pEwyq2/smcyF8laTRMb5DpK3KgI
X-Google-Smtp-Source: 
 AGHT+IG/HgIgdSgvQqy3AXOe0r/4PVhQlkf8W/nO+Clig28YU2mx//r0WREn/yYLRmNX0scfU3SYjJOJrqswVfJx9YE=
X-Received: by 2002:a25:3187:0:b0:dcc:1449:71ea with SMTP id
 x129-20020a253187000000b00dcc144971eamr8864308ybx.50.1710760357653; Mon, 18
 Mar 2024 04:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <570989e3-299f-4617-adde-b6b8d1e06277@cpp.in>
 <000901da7922$c81acee0$58506ca0$@opensource.cirrus.com>
In-Reply-To: <000901da7922$c81acee0$58506ca0$@opensource.cirrus.com>
From: aigilea <i@cpp.in>
Date: Mon, 18 Mar 2024 14:12:01 +0300
Message-ID: 
 <CABYkuAi9+XmXnJP0J+jvXkOaOGyK0pvRiFic1v2LmxkGo4ic0g@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support HP Spectre x360 14 eu0000
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: anton@cpp.in
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 64IIKOK2XZEKYKKFUESPKE623Q5HIYBH
X-Message-ID-Hash: 64IIKOK2XZEKYKKFUESPKE623Q5HIYBH
X-Mailman-Approved-At: Wed, 20 Mar 2024 13:57:59 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/64IIKOK2XZEKYKKFUESPKE623Q5HIYBH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi.

Indeed, my bad, this patch is obsolete then. I will update and resend
the second one (for the patch_realtek.c) as more quirks are needed.

On Mon, Mar 18, 2024 at 1:55=E2=80=AFPM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Hi,
>
> Support for this laptop was previously added in patch:
> 33e5e648e631 ("ALSA: hda: cs35l41: Support additional HP Envy Models")
>
> Is your branch out of date?
>
> Thanks,
> Stefan Binding
>
> > -----Original Message-----
> > From: Anthony I Gilea <i@cpp.in>
> > Sent: Sunday, March 17, 2024 2:05 AM
> > To: James Schulman <james.schulman@cirrus.com>; David Rhodes
> > <david.rhodes@cirrus.com>; Richard Fitzgerald
> > <rf@opensource.cirrus.com>; Jaroslav Kysela <perex@perex.cz>; Takashi
> > Iwai <tiwai@suse.com>
> > Cc: alsa-devel@alsa-project.org; patches@opensource.cirrus.com; linux-
> > sound@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] ALSA: hda: cs35l41: Support HP Spectre x360 14 eu0000
> >
> > The new HP Spectre x360 has _DSD for CS35L41 amps in ACPI but
> > reset-gpios and spk-id-gpios are merged into single Package of size 4 s=
o
> > _DSD parser fails to parse it.
> >
> > Overwrite broken _DSD with the correct configuration.
> >
> > Signed-off-by: Anthony I Gilea <i@cpp.in>
> > ---
> >   sound/pci/hda/cs35l41_hda_property.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --ruNp a/sound/pci/hda/cs35l41_hda_property.c
> > b/sound/pci/hda/cs35l41_hda_property.c
> >
> > --- a/sound/pci/hda/cs35l41_hda_property.c    2024-03-10
> > 23:38:09.000000000 +0300
> > +++ b/sound/pci/hda/cs35l41_hda_property.c    2024-03-14
> > 18:22:01.887566917 +0300
> > @@ -64,6 +64,7 @@ static const struct cs35l41_config cs35l
> >       { "103C8BE5", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4100, 24 },
> >       { "103C8BE6", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4100, 24 },
> >       { "103C8B3A", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4100, 24 },
> > +     { "103C8C15", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4100, 24 },
> >       { "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 1, 2, 0, 1000, 4500, 24 },
> >       { "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4500, 24 },
> >       { "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> > }, 0, 1, -1, 1000, 4500, 24 },
> > @@ -405,6 +406,7 @@ static const struct cs35l41_prop_model c
> >       { "CSC3551", "103C8BE5", generic_dsd_config },
> >       { "CSC3551", "103C8BE6", generic_dsd_config },
> >       { "CSC3551", "103C8B3A", generic_dsd_config },
> > +     { "CSC3551", "103C8C15", generic_dsd_config },
> >       { "CSC3551", "104312AF", generic_dsd_config },
> >       { "CSC3551", "10431433", generic_dsd_config },
> >       { "CSC3551", "10431463", generic_dsd_config },
>
