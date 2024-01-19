Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E314EC47DD3
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jan 2024 16:03:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3315183B;
	Fri, 19 Jan 2024 17:02:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3315183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705680182;
	bh=pX77ipe+Gsy5sdRmPvMGCJoBu6eqr4SlhVjTSxXiRl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JepkOMADoqZED2ZRVUYw1dz0rZ3ECzmk4d94g/Ez/cOBYWcMlxr/HrPIYvzcDzZGk
	 9tiRQaX+zadDE38tSwqTAlYSfLxtFtyv4jg6s85qBn1mQqofpupJ6Z7GSRmdXZkC10
	 z/dwyiZDzc+rnsuF1YtagSMs3TbG1VkiBHsDMWr4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70077F8057F; Fri, 19 Jan 2024 17:02:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB114F80580;
	Fri, 19 Jan 2024 17:02:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC77EF8014B; Fri, 19 Jan 2024 17:02:24 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9C01F80074
	for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2024 17:02:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9C01F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Ar/0W13/
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55a356f8440so1150464a12.2
        for <alsa-devel@alsa-project.org>;
 Fri, 19 Jan 2024 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680136; x=1706284936;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhJgD3zP9zngaSpIBMlj3gbLccR2tuQ/HQYsBEgXc04=;
        b=Ar/0W13/485L6dzh3CdVpv1xjBEP8QJESLBoRG7FlsbrQOpJ/4IYDdqOyU8lxpNP6r
         jM4ptgMzhh1MDPvggRlEv0dFNvMV4J+1EN6mlQF78Qq7CK5cRvDEV8EzUFHFOEQPQQAn
         U4UOWiOaSCGQfZffFpfcKiq6gylTXd3ukZ/PnAdNhN/Ov1jny8tLbNYVYrhFmC7GsZFG
         decp9F/cAIj3dKBoQiRbJShgqMztxM8P6dV9EJpiZJFASVdNFMRQzTnYWBVXEWZsqthm
         lpVWU2i34GykPQKrACxW+nof7ejc/enQa17ArdEnqZ7F5jOFsTIASNPGx+QswnpBCbUM
         +MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680136; x=1706284936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhJgD3zP9zngaSpIBMlj3gbLccR2tuQ/HQYsBEgXc04=;
        b=DzH9x04czf7BINyosijdKB1amIQjLKfInAhZD6ibym5IfNH/Uvam8WDzCpj2rHRW72
         sLPhgJiDkhPULs2fs+urCtkOS+i1UbBzIVHXZ9tDDrLemoFYxDA9QWe33Nk3+Ov/LsuB
         nVMfIo2DMLw6wXBZrAjXs2sI1falc89qT0hJpfo7hHwhqPC+QirZPmLnPhwPf6rlXolT
         oX2lM5QOsBDzbmkZFhwERbwGjwQD9A5zwiT5Ns0ELgVYyQ2oEt6G37FGDifTLUjuMo9G
         UWPrE274OAEnNMVSJSbzbNNZSUxniwmVyHiYNW4TKBh4QF4JoAO+n2mxzOb9VSVLcdfs
         n+Bw==
X-Gm-Message-State: AOJu0YxouA/QsjMeom2Lh/NzjjCVhNGEsDRGeBG6NhmHiKkgRatWn+/6
	27pDCLmGlO0Ag2EyOBknq4Ek2dAo9QNC0lBkJo0/bnJrJyyeBdE/I+AWkddko21AJUHlglkpM5Y
	xKMHWkbrbkLiup9kfiPcxQGItS/c=
X-Google-Smtp-Source: 
 AGHT+IF3+Nq/o91kf1Qzz3pAJkg83GJHPQk614/748N9uRatEUTFGG26s9DzXUBqtocFl8OSIsh8IeChhwKnrMDv1NY=
X-Received: by 2002:a17:906:280c:b0:a2c:e148:e2d7 with SMTP id
 r12-20020a170906280c00b00a2ce148e2d7mr6539ejc.2.1705680135691; Fri, 19 Jan
 2024 08:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-4-ckeepax@opensource.cirrus.com>
 <ZalU8r1OvqKOLHrf@surfacebook.localdomain>
 <20240119113203.GA16899@ediswmail.ad.cirrus.com>
In-Reply-To: <20240119113203.GA16899@ediswmail.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 18:01:38 +0200
Message-ID: 
 <CAHp75Vco3+B_mcLRr7dcLx79601poLJtLt3Av6d-hAJQLYbe6Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] mfd: cs42l43: Add support for cs42l43 core driver
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: AFE45OY5KBRIIJQZ65YYVTHFPCVXW6IG
X-Message-ID-Hash: AFE45OY5KBRIIJQZ65YYVTHFPCVXW6IG
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AFE45OY5KBRIIJQZ65YYVTHFPCVXW6IG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jan 19, 2024 at 1:32=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Jan 18, 2024 at 06:42:26PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Fri, Aug 04, 2023 at 11:45:59AM +0100, Charles Keepax kirjoitti:

...

> > > +#if IS_ENABLED(CONFIG_OF)
> >
> > We are trying hard to get rid of this ugly ifdefferies (ACPI as well) a=
long
> > with respective macros that are often the PITA for CIs.
>
> Fair enough, but what is the expected alternative here? Is it now
> preferred to just always include both in the driver? That does
> come at a small cost in driver size, but it doesn't really bother
> me.

Yes. You may have noticed the pile of the "remove of_match_ptr()"
patches in the past cycles...

> > > +#endif

...

> > > +#define CS42L43_RESET_DELAY                        20
> > > +
> > > +#define CS42L43_SDW_ATTACH_TIMEOUT         500
> > > +#define CS42L43_SDW_DETACH_TIMEOUT         100
> > > +
> > > +#define CS42L43_MCU_POLL                   5000
> > > +#define CS42L43_MCU_CMD_TIMEOUT                    20000
> >
> > > +#define CS42L43_MCU_UPDATE_TIMEOUT         500000
> >
> > > +#define CS42L43_VDDP_DELAY                 50
> > > +#define CS42L43_VDDD_DELAY                 1000
> > > +
> > > +#define CS42L43_AUTOSUSPEND_TIME           250
> >
> > Usually we use units for the macro names as suffixes...
> > E.g., _US (for microseconds).
>
> Can add those, does make it clearer.

This is a nit-pick, but just to let you know the standard de facto in
several subsystems (which hold drivers of different devices). Not sure
if MFD or others related to this driver are really bothered with this
nuance.

...

> > > +   irq_flags =3D irqd_get_trigger_type(irq_data);
> > > +   switch (irq_flags) {
> > > +   case IRQF_TRIGGER_LOW:
> > > +   case IRQF_TRIGGER_HIGH:
> > > +   case IRQF_TRIGGER_RISING:
> > > +   case IRQF_TRIGGER_FALLING:
> > > +           break;
> > > +   case IRQ_TYPE_NONE:
> >
> > Are you sure it's a right place to interpret no type flags as a default=
?
>
> I mean... no... but I might need more to go on. The chip
> generates an active low IRQ by default so it seems reasonable if
> nothing is specified to assume the chip is doing what it normally
> would.

The problem is that if NONE comes here it might point to a mistake in
the initialisation / probe code somewhere else. Please, double check
that it's a valid case to have NONE here.

> > > +   default:
> > > +           irq_flags =3D IRQF_TRIGGER_LOW;
> > > +           break;
> > > +   }

--=20
With Best Regards,
Andy Shevchenko
