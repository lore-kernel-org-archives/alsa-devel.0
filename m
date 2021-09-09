Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F2C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 17:17:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B69A610CE
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 17:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B69A610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D254C16A5;
	Thu,  9 Sep 2021 19:16:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D254C16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631207818;
	bh=6MPSHzZT+wdjZOpnQ7K70UGKNWNw78Qt+uaALoiNHzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AS/T7R4uZ+utp+afT6bez3W58vPsjfplcK2zFEQPHJ1g5pcZv4K5RA5bPnBacX69k
	 X0lutEPIKT1ehyurFXGfwhjz1xg8aCunploLpwAxjf4EOyXM4XZsKpPyXDjrEsuLyS
	 JvP/jgTfBo10pFiQGE0LtCtAvARKbBvjVg6oXrJo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5935BF80166;
	Thu,  9 Sep 2021 19:16:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C669F80224; Thu,  9 Sep 2021 19:16:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18C64F80166
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 19:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18C64F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ur2rhy1G"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4283A61104
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631207758;
 bh=6MPSHzZT+wdjZOpnQ7K70UGKNWNw78Qt+uaALoiNHzs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ur2rhy1GxLjo187czO/UhbKA71WUYOuDssPXJbRQzb9xWT3LfpTZ3XwCFqaKDqm21
 4vwEfcqbHjO+0SEwiwon8XkmM12vYOYvFu/WVOwLz40QfscvgnJCyIjEyCEs7Q/g9K
 gnLnvGikDuTbyDA8V+H5Dvk9oMHLyeRTPifrwfd4xyx9Y3LRDvx9rPpCWbLyu7xPaE
 nQKp9uyAJy4hZL4ovU+mbbwvd6SYbqeJOMrwhfx5Qm7WVk9rFYhZ7xOJliTXAgYAwX
 0GCZjXlnfeRsVxcgvNJrMULFHMCtH/UqvYqSYGaiOfYlbq2HaVZdPOKaeEwZ7yISo1
 FsT0I6dGJtk2A==
Received: by mail-ed1-f47.google.com with SMTP id 9so3623962edx.11
 for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2021 10:15:58 -0700 (PDT)
X-Gm-Message-State: AOAM531hS+6+Gir0WN3WLAyWBoex2EmQgTDNFjSiqhI+CaSF2rAWOXJd
 9b/qr/zcuJUGCc4RSNkgI5j/ektubDsS7NYGkQ==
X-Google-Smtp-Source: ABdhPJyM7KZ4cekZmGbkuYORGG988NU14THUy9AbIjOQ+isB8C7xXq78QJxJ1PLPFyvKtKN/u+ZYoeTozdmbIK+obJQ=
X-Received: by 2002:a05:6402:1703:: with SMTP id
 y3mr4266246edu.355.1631207756787; 
 Thu, 09 Sep 2021 10:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com>
 <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
 <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com>
 <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com>
 <CAEnQRZBmruc8GNfJTm99=0K7PyGrEiB1CxY3c2RSZhLFLR-nhQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBmruc8GNfJTm99=0K7PyGrEiB1CxY3c2RSZhLFLR-nhQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 9 Sep 2021 12:15:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJd2AvBxRjHj=VZV2DH26tSNSX=5eEpc-HoFrc=dLxEFQ@mail.gmail.com>
Message-ID: <CAL_JsqJd2AvBxRjHj=VZV2DH26tSNSX=5eEpc-HoFrc=dLxEFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks
 documentation
To: Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Sep 9, 2021 at 6:21 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> > > The H/W block is controlled by the DSP firmware. So, we don't want
> > > to use the Linux kernel driver (thus the H/W block device tree node).
> >
> > 'status' is how you disable a device to not be used by the OS.
> >
> > The information about that device's resources are already in DT, we
> > don't need to duplicate that here. If you want a list of devices
> > assigned to the DSP here, that would be okay.
>
> Thanks! This is a very good idea. I was thinking at a totally different thing.
>
> So having something like this:
>
> dsp {
>
>
> hw-block-list = <&sai1>, <&sai2>;
>
> }

Yes.

> And then inside the DSP driver we can get access to sai1 clocks. Do
> you know of any standard property name?

There isn't. So it needs a vendor prefix.

There's been some discussions around 'system devicetree' where all
processors (like the DSP) view of the system get represented. Device
assignment is one of the issues to solve with that, but it's not
anywhere close to having something to help here.

Rob
