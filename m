Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43066E75440
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 10:18:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A856E82B;
	Tue,  3 Oct 2023 12:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A856E82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696328322;
	bh=gz1G32NpltRZqjFg6bpZFDxQ9gKj2W33wlCujOs8NqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tcWqK1wvQ4jy2EiVF0BajuMwSSTSRgS7VTckr4wX8KGoDJo8ijqIu71liZ3avDV5y
	 AMi/vb2gZQXaGNaMkK7wdJkeGdJf/QFaqj2fW9UURTKhJ4XbwkKq/CT3/l0HURMVXE
	 JfFtiv/m+TXJbq32K3lZg20huLJMGoD4ONJp7YQk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F45CF80558; Tue,  3 Oct 2023 12:17:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AD8CF8047D;
	Tue,  3 Oct 2023 12:17:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81AE7F8047D; Tue,  3 Oct 2023 12:17:26 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C178F801EB
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 12:17:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C178F801EB
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-59f6e6b7600so8364567b3.3
        for <alsa-devel@alsa-project.org>;
 Tue, 03 Oct 2023 03:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328229; x=1696933029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DZsLBpVAosCAPqQeZ7sGwOoAu9EmebzedDkf2LRpxg=;
        b=bEBMW1hTFc+eW6pJcBO7p4nsVlu4mWyfg7Yc1kEUwAZxLcwhpFt5U1dPMVbcyTfq4Y
         iGP0B+StgJjfEAsebK6hVLbqHFdBRX9ZSCCKHhVg4DMTwdrWpa8jYQBT9rDsAn4fkFRw
         pEAkDu+HMcOy6XZ3M5d3YGa8G3a20YuHE6ka8cqW7Kz9Gd5nX5tH0Z4PdGKmSX+NAi2Q
         HLRvaXfMzR+JXDyULSsEQP8E0BDYNl3xvT+0VYDDqK3MxySH+Es62qO+VNwdOKfh24ev
         zGzddsmx8rbqoXGlyl/gaBxovAVW6yQfN2zshMm+AhrYc+KIdHf5FwzeWTPU1mbhXysE
         uZEw==
X-Gm-Message-State: AOJu0YwBh0fAAwPc/s95ku+g+grPYPEQXNkvIRgn7tsKYeB2eOoblcT6
	3oZ7vxSojrUOKC/CxcbMF83Ahc9YCK6ZAw==
X-Google-Smtp-Source: 
 AGHT+IGs6GHXwx3ChjPjiSawqaQZ55HP6RHykbgijhZ843LCpRGZshDGCqT+T7pBngaLWKGZjTm5ZA==
X-Received: by 2002:a0d:d7cc:0:b0:58f:96d8:e7ad with SMTP id
 z195-20020a0dd7cc000000b0058f96d8e7admr14178692ywd.18.1696328228866;
        Tue, 03 Oct 2023 03:17:08 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com.
 [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id
 z184-20020a8189c1000000b00594fb0e2db3sm273522ywf.138.2023.10.03.03.17.08
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 03:17:08 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-59f4f80d084so8443697b3.1
        for <alsa-devel@alsa-project.org>;
 Tue, 03 Oct 2023 03:17:08 -0700 (PDT)
X-Received: by 2002:a05:690c:ecf:b0:59f:4ee0:26e8 with SMTP id
 cs15-20020a05690c0ecf00b0059f4ee026e8mr1857503ywb.21.1696328228270; Tue, 03
 Oct 2023 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231002090434.1896-1-shenghao-ding@ti.com>
 <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
 <ZRvWQQzrvtzkJ/UV@smile.fi.intel.com>
In-Reply-To: <ZRvWQQzrvtzkJ/UV@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Oct 2023 12:16:56 +0200
X-Gmail-Original-Message-ID: 
 <CAMuHMdU0SUJd8wduTcZ6XZjcDvEFSCOgbwc4Fbcu0U3pVH=PRg@mail.gmail.com>
Message-ID: 
 <CAMuHMdU0SUJd8wduTcZ6XZjcDvEFSCOgbwc4Fbcu0U3pVH=PRg@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 robh+dt@kernel.org,
	lgirdwood@gmail.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	mengdong.lin@intel.com, baojun.xu@ti.com, thomas.gfeller@q-drop.com,
	peeyush@ti.com, navada@ti.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: O4UDKGCGLFQZLNOMHBYWFTW4JIQEDCK3
X-Message-ID-Hash: O4UDKGCGLFQZLNOMHBYWFTW4JIQEDCK3
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O4UDKGCGLFQZLNOMHBYWFTW4JIQEDCK3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andy,

On Tue, Oct 3, 2023 at 10:52=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 02, 2023 at 09:24:21PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 2, 2023 at 4:38=E2=80=AFPM Shenghao Ding <shenghao-ding@ti.=
com> wrote:
>
> ...

> I believe patch is already in the Mark's tree, so we now ought to live wi=
th it.

I know. I would still like to know what is the real cause.
It might resurrect again, here or in other code.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
