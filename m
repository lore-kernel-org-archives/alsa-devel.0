Return-Path: <SRS0=bYd2=4Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54759C10F00
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 03:25:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3272206CC
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 03:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CSx+Cvoe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6CTG2Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3272206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23DE8950;
	Sat,  7 Mar 2020 04:24:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23DE8950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583551542;
	bh=AYmIZ6yWbTSwf+4PbwAZ8oAN35zAuuhjNmzv/5LF0OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CSx+CvoeSZ7ULOZjx9YFXndnTGf5MCJ7S3jzj3t8QW1ETUJaL7uGOwlYh8Fe1Tb+o
	 cAH9g3WF+Qf+vSlgQaDkbFvIzpqT+9m/pbnrcX76LLbncjLXlwEVL7lUYUA9p/byBX
	 j0nkpWMmQRNf39jWgyHT4qOeFoEsDM2bj+VpDAfU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F3B6F80245;
	Sat,  7 Mar 2020 04:24:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 107C3F8025F; Sat,  7 Mar 2020 04:24:49 +0100 (CET)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 759C5F80130
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2020 04:24:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 759C5F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="V6CTG2Bc"
Received: by mail-qk1-x744.google.com with SMTP id e11so4301444qkg.9
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2020 19:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xx47FJX+QZbsjpJJ8x5FoZzQPuJdzEkyLKKPH7vo5sk=;
 b=V6CTG2BcTle4ax3VW2GMHUYNQikRPHCX4W8GrQB30I7oTu+yciihautJPRVRVjQ/Fc
 4kw1eamGfYWI+0JA2+f4WTC0j66nFLcnd99j+u/JabWCi3MKzZqlGYpUGHSL2uG7mtIF
 BfhUwv1spkZ3ujZfrr3fUBm8ngmoJQzhDuiHuJu/QP0GKueGBjshtLXt46XuOmZgKx/k
 JuhzFIkghSF56z6430kkDS6XYJ9RA+oqlafgd4aUUnS5t52RLf0rttvgMrL1JBERiRYX
 RpwRRbLrCwoL2EWUcYPnjqPBEq6rHC9UTbskZJ/gSdsjmpVPKgwIbE0mfl05KL3hJagt
 G8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xx47FJX+QZbsjpJJ8x5FoZzQPuJdzEkyLKKPH7vo5sk=;
 b=KaiZ1wlvy8oWv4Rsix6E9Wc1e06HJWWLdkgqypvxY8H08/+sAMLEp0lbHICSszOXIn
 6opdTAUkulUI+9wKGQLYrxq19GVtS+aEefFvJ0cumtgJHtnEa7P1wUFPMeihwGwgPvOL
 11jsZLVoHq+ZvfSm23eOjuqmExVoGrLehI76FDodYwSV4VUjoVboss6QbLoeFqMEm6a+
 8S31twrB2lnMtgM+DTk2lVnJ5NRdAdIpD4R0jE0n5BMfJiAS761d8muLS9abUQJnARcX
 By4t3SlUacxbvlnQu5+CYNTlhM79afNYAqjRF+3t2zTyRDbdgEuQs2KjQ14cKhTg8d8N
 tZmw==
X-Gm-Message-State: ANhLgQ3eTb3Z+SvB83dVvj/kYLyklmEP65zC9kotxQeaJDgS4pNk48Yy
 /2iW9Q2yVWzcuZ27Swg6B/Nyg+paa0mhHI9JGKw=
X-Google-Smtp-Source: ADFU+vsrgn/I7/3yq0U87aezc5EPcL/v/ioSyi8uCEcZqO8JoZIjCstooShLZGMYvgHn2vn/uc1R6Au9Gus47NWljDo=
X-Received: by 2002:a37:a50d:: with SMTP id o13mr5736750qke.37.1583551482955; 
 Fri, 06 Mar 2020 19:24:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
 <20200303014133.GA24596@bogus>
 <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
 <20200303124739.GE3866@sirena.org.uk>
In-Reply-To: <20200303124739.GE3866@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sat, 7 Mar 2020 11:24:32 +0800
Message-ID: <CAA+D8AMkmHZoZ7Oa0_OGfgRAC+H-117e1bNJgzyiWGTueyxDzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to
 asrc-format
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, shawnguo@kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, s.hauer@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
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

Hi

On Tue, Mar 3, 2020 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 11:59:30AM +0800, Shengjiu Wang wrote:
> > On Tue, Mar 3, 2020 at 9:43 AM Rob Herring <robh@kernel.org> wrote:
>
> > > > -   - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> > > > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > > > +                       Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> > > > +                       "include/uapi/sound/asound.h"
>
> > > You can't just change properties. They are an ABI.
>
> > I have updated all the things related with this ABI in this patch series.
> > What else should I do?
>
> Like Nicolin says you should continue to support the old stuff.  The
> kernel should work with people's out of tree DTs too so simply updating
> everything in the tree isn't enough.

Thanks for review, I will update patch in next version.

best regards
wang shengjiu
