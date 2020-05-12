Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6DBC47255
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 02:50:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1212070B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 02:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OuwobBvN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXTFgedf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1212070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68329950;
	Tue, 12 May 2020 04:49:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68329950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589251835;
	bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OuwobBvNaZzJYw3geWcORtz4VODcGgSyAyTkyaqlUtscHJbZMTHHji8/rKgqYjzlo
	 lmXaZ8ViDBEJ90//Oc5JY/4xLWFObUacoTFvIV0S/d4s0pHSQSToYpYVTj6mdz4y1Z
	 PRxdLlemS+lYLBIaNIVe8PQebzHEP8049O6xcTsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D61FBF80112;
	Tue, 12 May 2020 04:49:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3577AF8014C; Tue, 12 May 2020 04:49:19 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F482F800E3
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 04:48:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F482F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="uXTFgedf"
Received: by mail-qt1-x843.google.com with SMTP id g16so9146455qtp.11
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
 b=uXTFgedfKAJw/mdH+r2ogZwZQTp/ZTIBRyakuBwLSXaz9PWFl3s45PRztLUO7H5FBP
 TFYtbn1ZzJ8znyq1exL44gJ+IKnPayj/ne3+XdrgqoDlhm+JXc+fHRnDRZSCC1iZcULu
 yhJjq9wd8k0JUQ5xuOSqJk7LCa34c2BTbb+fpES1GQHxSzMKez4IXl6KXXc2J0kHCym9
 ikeiYA+UxdiiLcFWazU/ZZWHH2jqHQh+MyNod6nD4dNcLGcAZqgtnSBzUJkrg0cVhUou
 AEcbyFUk/TIHzd/EwmZjEKhx+oQIh3IVZ/2yfe+rvjvi/yqZqN2j8s7+DeSsAmIJ2JGc
 PA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
 b=d7QwhnBUI7+gOCwqiaTTPYndBNTqxit95hS671umELblLjzgO4yvqLyZU0wfqmwd/2
 qgl5Y45jsjAGXvDG+e8LZc4IHf7ksD4sOOl42EzvHt54V9KxSxvfzH0h39o24y0PFYhh
 rVNwbtmDnPQaH8Exm7U+NJd+5H2MAIirhiwo//2jFmCmSo5+iQ+fQkI315QwL8LvVe2r
 32FXruKJErLXbDwfdLrp59A8gB8AqFitULRlVz5Fqq/Jnqg2vMUf/8RaZJiynETzxn93
 fyT2us/2SQNstRTQWy6OMG1ySQIOKknKH9jy2r1ZYx9Vby4+WPNkCU6CVbiE6ZhU79s0
 vSJQ==
X-Gm-Message-State: AGi0PuZJceSWS/cukqUVRQFArwdTPRpF5RaX1Wxxo44M57z+40jYCFJB
 mFQbG3HR52qa/tcJUYKNuq/R6052XiIYBkbI1I0=
X-Google-Smtp-Source: APiQypId7oxhT26ItzjC8bMXwsSFBjnYZNmv7Cgv/UndRHY6NfhZPgW4iFgXhDPKhepQCP0rcyNz85IZmAz5rBwh+Hs=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr19665595qtw.204.1589251733739; 
 Mon, 11 May 2020 19:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk>
 <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
In-Reply-To: <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 12 May 2020 10:48:41 +0800
Message-ID: <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Mark, Nicolin

On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi
>
> On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, May 01, 2020 at 04:12:05PM +0800, Shengjiu Wang wrote:
> > > The difference for esai on imx8qm is that DMA device is EDMA.
> > >
> > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > the remaining bytes are not transferred and thus noise is produced.
> >
> > If this constraint comes from the DMA controller then normally you'd
> > expect the DMA controller integration to be enforcing this - is there no
> > information in the DMA API that lets us know that this constraint is
> > there?
>
> No, I can't find one API for this.
> Do you have a recommendation?
>
could you please recommend which DMA API can I use?

best regards
wang shengjiu
