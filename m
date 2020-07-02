Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD62BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491EB20899
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JKTywpF3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvgK32p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491EB20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B51ED16D3;
	Thu,  2 Jul 2020 15:44:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B51ED16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593697502;
	bh=3MSMquasFAjnciVa57vrc8ovpDKT0aHiUA9DL1SWpI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JKTywpF3Sw+oribLT653GlSvnvJMc/cmbBTNpLRI8IkHh8NnU+Q82viqu8xywEu1b
	 EH4qmBaVJEEFFjM7Dsy8xv2LOHT113k/RMhf/1R2ShzqbnFbSJ+0iqY2ZNCjgtaSDD
	 4Ew0b7yiedp5G8ySIOFWaDw4iR3a3haKLzZtjNt0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38FA4F8022B;
	Thu,  2 Jul 2020 15:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B83AF8022D; Thu,  2 Jul 2020 15:44:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1054DF800ED
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 15:44:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1054DF800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bvgK32p7"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6096220899
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593697440;
 bh=3MSMquasFAjnciVa57vrc8ovpDKT0aHiUA9DL1SWpI8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bvgK32p72fDSWie8VaIV4AsDZq8PqPB16wEnSplqMb8KnuL9LBCzL0/DG9bco5GPL
 BST3oQhsE+sLn7s9/FJkBFBG5CEGcKpWVSHtdM5c7Uafdk1KoLi2xfUwtfsEGhmwoh
 E4VWJySd5iLyQXDL10a52YycuQTYV9GNGrVNLsFs=
Received: by mail-ot1-f54.google.com with SMTP id h13so3575787otr.0
 for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2020 06:44:00 -0700 (PDT)
X-Gm-Message-State: AOAM532iTLAHRomCkh3Yh4oyR5TR6wRkBikLIWwSfz3OQ4RNJ1dCq8pn
 PhD9GS3V+9Y1iw7wxf5eSAoINpGcR7lFCbkbJw==
X-Google-Smtp-Source: ABdhPJxP9ySsJVKfJwG+UMovWOfxtv+Snj67Sfxn4ir4gfqlxAwfDrHeOiKxBwoJpo6+5RpBkmfjlNjsM6io2P+1Kzg=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr25256828otb.107.1593697439697; 
 Thu, 02 Jul 2020 06:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200630223020.25546-1-festevam@gmail.com>
 <159364215574.10630.10014931369710772889.b4-ty@kernel.org>
 <CAL_JsqLzae5qUJXF-otsUQqy+zyk9fD_AKd8b8F+PFWZBH1QDw@mail.gmail.com>
 <87eepuzufl.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eepuzufl.wl-kuninori.morimoto.gx@renesas.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 2 Jul 2020 07:43:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a+XvCU6GY0H0WV3BFyW1JncORdeMs5xpSHtcNbJyOrg@mail.gmail.com>
Message-ID: <CAL_Jsq+a+XvCU6GY0H0WV3BFyW1JncORdeMs5xpSHtcNbJyOrg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Fix 'make
 dt_binding_check' warnings
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
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

On Wed, Jul 1, 2020 at 5:29 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Rob
>
> I'm posting same patch and waiting review/response.
>
>         Subject: [PATCH] ASoC: dt-bindings: simple-card: care missing address #address-cells
>         Date: Thu, 21 May 2020 12:54:56 +0900

https://lore.kernel.org/linux-devicetree/20200528223916.GA804926@bogus/

>
> and am sending question mail accordingly
>
>         Subject: Question about "xxx,yyy" style property
>         Date: Fri, 29 May 2020 11:41:53 +0900
>
> Nothing happen until now...

Sorry, if it's not a patch queued in patchwork, I may or may not see it.

Rob
