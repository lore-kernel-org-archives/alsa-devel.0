Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD5C433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:01:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BE8208D5
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jq3QnKka";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVOC2aTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE8208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8769A167C;
	Tue, 13 Oct 2020 13:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8769A167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602586873;
	bh=9WA80PNkrI5C0OQNWClQ/raYkEl8VgDyVTNL1YpNDBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jq3QnKkaNvfSqNF2f+7FOAYS5IPL6rVjuUnv5z27FwKSDLgiuPkTThRfRfzjREjEl
	 XLd1JdPy2PncK2/j+ijqNK/nOdeaupkXNG2u1PxU/oMEhF76Q0uw3wYWAtLNvzem3E
	 HI1LXA/vTSvTG88QivZCcotH9jNJCoz6f/lE/Pw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F0FF8016F;
	Tue, 13 Oct 2020 13:00:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9B84F801A3; Tue, 13 Oct 2020 13:00:20 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58363F800CE
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 13:00:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58363F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WVOC2aTp"
Received: by mail-wm1-x343.google.com with SMTP id k18so21297421wmj.5
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9WA80PNkrI5C0OQNWClQ/raYkEl8VgDyVTNL1YpNDBQ=;
 b=WVOC2aTpPMXchRQn3hfbZminS4eshLiFulE0QKi7EhDNBaEJkX+sKXPuhyKYHL5elw
 9xDVhp9goIz4QeQm/DU7mWbkwLD99EQdpdO17AhjEw2FGJFQ7+HudYN2goj7L7PDWqNK
 DrFAj3g9FgdvxqnncZQhYTUIdq0YMfnmedSYCKyvZqaYNEE46JKiAIq/bsUYvHoe71xK
 RbWrf7ZwUWhZe3mqD0eYeM6ZCmpqfmGWg9oCQ2cmp0DCEKt2Ny2JKldng4yOSu+hdFuE
 u2+45lmoGfn5WES58TOmR/71j80KhwPvECg54YrSkAzQ+7lk9xfbAqgAshx+qHuiqE4/
 fSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9WA80PNkrI5C0OQNWClQ/raYkEl8VgDyVTNL1YpNDBQ=;
 b=A4d8enzsYyv/j10tWKfc1Hue2+3rgqkg1ZV0+qeBW3NMOXPTfRGWSIKZPqdCxMM/S7
 9dvygMDRFrQkFxjqFBn2onnMjFgtVdyRFfPtdre9aEC7PV9agEgKqehO7lNzIVMh8DWO
 AGRoHGcHzDdCuamJtUB02LkJW6EHCUUNu5oWgmCGa9/lKyUhwqWR6vSKjkn2zHIzcLFr
 iszbQxOy9hQMVSpP/W3zg2VUAPvU4zW1dx7UbZroZGfMXTFQyxvoXoF3P2L7XZ0yXjAB
 Kz+JpHvo65fqbX0urV2brQ4GxJdVQ9buGlM6ahnXtSfW7ELyRR+Fv+EgYmeQPsFs0wuE
 Ii+Q==
X-Gm-Message-State: AOAM533Vv0ICo/eRSFUbehSw7DuhUDKCuKujDampWoA+f2ESJOeOhj9e
 qGt0g1Hyr2wcqB8GqufSp3pSqO4xZqC8DfMtJa0=
X-Google-Smtp-Source: ABdhPJz2Emc612AGRQCJLTyQrTiQtni6Jj8EdvwE6fdWKKt9ZMRSVNmj7ycQo+5/Z3iP7aLNrwJCaI38aCViU8RMat4=
X-Received: by 2002:a7b:c317:: with SMTP id k23mr14424626wmj.44.1602586815306; 
 Tue, 13 Oct 2020 04:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
 <20201012190037.GB17643@Asurada-Nvidia>
 <CAEnQRZBrXNgMDNgQ=dMJfZQpZvdq6sUx2y21_fuk9teRd5UM0Q@mail.gmail.com>
 <CAA+D8AOCR+Hvq9K=LjbaPW0jJB+00nFORahErWyJJJr0LVUq4g@mail.gmail.com>
In-Reply-To: <CAA+D8AOCR+Hvq9K=LjbaPW0jJB+00nFORahErWyJJJr0LVUq4g@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 13 Oct 2020 14:00:03 +0300
Message-ID: <CAEnQRZBbTBtJDLy9XNAFHa0hcuoU3c66kQVKsQR7MTo40NJF7A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Oct 13, 2020 at 1:49 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> On Tue, Oct 13, 2020 at 6:42 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 12:29 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > Hi Shengjiu,
> > >
> > > On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > > > Add 88200Hz and 176400Hz sample rates support for TX.
> > > > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > >
> > > Probably should put your own Signed-off at the bottom?
> >
> > Hi Shengjiu,
> >
> > Also please keep the original author of the patch. You can change that
> > using git commit --amend --author="Viorel Suman <viorel.suman@nxp.com>".
>
> Actually I combined my commit with viorel suman's commit to one commit,
> not only viorel suman's.

I see. Ok then :)

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
