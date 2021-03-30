Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A4C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 13:13:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993CA61955
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 13:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993CA61955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 960241675;
	Tue, 30 Mar 2021 15:13:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 960241675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617110031;
	bh=qPmQCdKGrtaPXSXKTaWeeIyNR84SLMN2eUQzxJ5VoaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AlI4rSlH+OlS9fYhnDIp4A4vNTE5p+lc0G+vTOcO2UPiYXTyievBtJBUE8OUtyFwJ
	 9pT66HsAVLq7OEPPqzru/0pKXz1pn2gS9KgMZ2Laq6P85zaPRMr3JpV/zeJrm+jawb
	 /XszmF8ypl58hKJPJTn+W6wgngyEi6m3K1Vr1m9g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED008F8023E;
	Tue, 30 Mar 2021 15:13:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BF43F8023E; Tue, 30 Mar 2021 15:12:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1B21F80141
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 15:12:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1B21F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DMBAgTQm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 040C1619BB
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617109964;
 bh=qPmQCdKGrtaPXSXKTaWeeIyNR84SLMN2eUQzxJ5VoaA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DMBAgTQm5CYH6/tbFuSgoxmJTaetfYc59ABLZsp/SrC8B2xnF9n8OwBdyo/tFChBT
 JiRJ94/yn4IuV/+MdMdCHTq3n/MD7EzgvLAifvf+xh8TvfRLrts+hds/CrtugCOId2
 7D7yowC7miUl1HjxNRIavaJA2vA9ZI79YPczw25HHbtN4TFBq9Hedc6xj1fFpWVvxG
 EANfZKBnX9mKUb53hq19JYwgeiMgkiyuS8N7jXHWk/fKmDjJOPvnxO2n7GnPvv3gPd
 Y4VJwnVE1trf2O/DxRlKkr0cAG97V4Q2WFvzD0q8AAFdOfepO54CchZGfPv63P1jNq
 6QuqslnzWiyTA==
Received: by mail-ed1-f45.google.com with SMTP id e7so18114379edu.10
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 06:12:43 -0700 (PDT)
X-Gm-Message-State: AOAM5305GscjmQEEJgq/Lowg+49pnM8hZscyIUalDDSEo656sviD+ote
 6SoBMOcj6jkpmp5aUNwSoM2h+lVUGHL2eXQm1Q==
X-Google-Smtp-Source: ABdhPJxm9FGUYw8ORhvqWSsL8VCXPBYTH2fFm1fgaHhq15Lynx5V9zgDJI2lslkHpjMXZc9MoU3ywjqjvjKUYhfCijg=
X-Received: by 2002:aa7:c403:: with SMTP id j3mr33715082edq.137.1617109962614; 
 Tue, 30 Mar 2021 06:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210311025809.31852-1-jack.yu@realtek.com>
 <20210326203407.GA3815424@robh.at.kernel.org>
 <1b6969cffa9e4a65be0d2df114d2ef21@realtek.com>
 <20210329153702.GC5166@sirena.org.uk>
 <c414d49d283947878a0c5021388b8ac0@realtek.com>
In-Reply-To: <c414d49d283947878a0c5021388b8ac0@realtek.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Mar 2021 08:12:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8R6B8GvdafaR4mJ9Q2+QU0Z0PGX8cd1TJZjxiQ7xqgg@mail.gmail.com>
Message-ID: <CAL_JsqJ8R6B8GvdafaR4mJ9Q2+QU0Z0PGX8cd1TJZjxiQ7xqgg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: rt1019: add rt1019 amplifier driver
To: Jack Yu <jack.yu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, =?UTF-8?B?6Zmz5pi25b+X?= <kenny_chen@realtek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

On Mon, Mar 29, 2021 at 9:54 PM Jack Yu <jack.yu@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Monday, March 29, 2021 11:37 PM
> > To: Jack Yu <jack.yu@realtek.com>
> > Cc: Rob Herring <robh@kernel.org>; lgirdwood@gmail.com; Oder Chiou
> > <oder_chiou@realtek.com>; alsa-devel@alsa-project.org; lars@metafoo.de;
> > kent_chen@realtek.com [=E9=99=B3=E5=BB=BA=E5=AE=8F] <kent_chen@realtek.=
com>; =E9=99=B3=E6=98=B6=E5=BF=97
> > <kenny_chen@realtek.com>; Derek [=E6=96=B9=E5=BE=B7=E7=BE=A9] <derek.fa=
ng@realtek.com>;
> > Shuming [=E8=8C=83=E6=9B=B8=E9=8A=98] <shumingf@realtek.com>; Flove(Hsi=
nFu)
> > <flove@realtek.com>
> > Subject: Re: [PATCH v2] ASoC: rt1019: add rt1019 amplifier driver
> >
> > On Mon, Mar 29, 2021 at 08:09:26AM +0000, Jack Yu wrote:
> >
> > > > Bindings should also be sent to the DT list. get_maintainer.pl will=
 tell you
> > this.
> >
> > > 1. Does it mean I should add my name in MAINTAINERS?
> >
> > It means you should have sent the patch with the binding changes to the=
 DT list
> > and maintainers as well as everyone else.
> >
> > > 2. Is below warning message caused by #1 question?
> >
> > No, it's the content of the change that's introduced problems in the bi=
nding.
>
> Hi Mark,
>
> I'll add below "address-cells" and "size-cells " in to rt1019.yaml like b=
elow
>
> examples:
>   - |
>     i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
>         rt1019: codec@28 {
>             compatible =3D "realtek,rt1019";
>             reg =3D <0x28>;
>         };
>     };
>
> but I'm not sure how to fix some of below warnings, like 'reg_format' and=
 'i2c_bus_bridge' and 'avoid_default_addr_size',
> are these caused by lack of "address-cells" and "size-cells "?

Yes, but run 'make dt_binding_check' to make sure.

Rob
