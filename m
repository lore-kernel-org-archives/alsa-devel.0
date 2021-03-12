Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B90C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:47:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F37B65021
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F37B65021
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B8A116F2;
	Fri, 12 Mar 2021 11:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B8A116F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615546038;
	bh=0kUh2/45yRo8jKguhknXtwIEM8vZFnfxC+Vyr58llqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJKuqZOnfJZ7Rn8SRyPE1Lx12QF7mJlZgsHTFUnH7Tg6AB1jYGMKiSMG2opT4zm3t
	 avDspTC8QYvz6iX4EC5WqtmcT2PGEUZ377ql4z+s1VNLeZjh37WeIoAsXONMZd3mNU
	 +Dy4T3V5/NAzO518gVlsjB8J6/lmB5uFPGW+pVE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B74A8F80217;
	Fri, 12 Mar 2021 11:45:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18487F801D8; Fri, 12 Mar 2021 09:33:21 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59E30F800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 09:33:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59E30F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Yb2CA3Uv"
Received: by mail-wm1-x32c.google.com with SMTP id
 c76-20020a1c9a4f0000b029010c94499aedso15258771wme.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vAtjNiJI1qKKGx5S42wVjbuS4/WPVdr+MZcPW8+RobY=;
 b=Yb2CA3Uvk4FTp1X0XSzcIlRiSLJrML0hKWk9vYGVtCigmOAot2S16a+V+92DSIDFFp
 XcRdIPhrmvpNIp/pgahzoTyhzqa4hNimV8VcSwDqJkU1Od+yqFHOO+Gi21w9n8heloqW
 7EcgmLxQW8uPWfRWR2NxqagdA8jYYJBPh/pWt7iiRX7MkBski7DnArKy9oLWC4xq/DAl
 Z7eBgydDG9gy2be5Wa1PpV1aZdQcahl80HXuEQ1gB8IQ5EjeM76e4VrboFMJ5P9PuRS4
 4HzGd/87j29OB9po8J/EKfcScdXcOPD59K6oNBWA2qiXgNo1l9sKLzEyR+9MwK+B4xih
 3+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vAtjNiJI1qKKGx5S42wVjbuS4/WPVdr+MZcPW8+RobY=;
 b=tY090g5VM4v9LtOVjaHoRe3HM0HJktRSlefIXOE0POCEwhio+ErIILvrkemcHklWO+
 CFURwT+wpELN/oAFdQM0CVx6od48xK6gRnrPsQFGjSge9h6wJ25f2RGO42WxCSWpZgn6
 daXXuOOwzBVNFC59gTJZDrlYd5K7EQKcKGf05Zp32ruJ8xU0SHtiVVwGxPJ33dLhYGBk
 O02l2F3KZ6vfOuX9T0cEeJaYreB5OB0uKmdbV3e5blhY9F7fVDumQlomy+NFMRSVQiHc
 tQf4ciHadv0CvWRxosowpBld0IjvV/G5gOMubwQtumnRTTv4WenHIW97RFSGwT4keTeE
 Biyw==
X-Gm-Message-State: AOAM533y3nEP+k+gd+SyDXgwmmqnbLB+VrN0saCHuvAcYdjGHjvhICDs
 eM2HAUr3yn6vaDUpBfTIyTBFM8m5adxatVsHfDE=
X-Google-Smtp-Source: ABdhPJyKZ0nMvRCdLUBbGOrKqHKyK3qzoA5pK9cwadvVMavLaFfap4/egdikXhfiZirr/3x+J4LMJaZTm4o697jfWd4=
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr11906684wml.44.1615537987205; 
 Fri, 12 Mar 2021 00:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20210309082328.38388-1-daniel.baluta@oss.nxp.com>
 <20210309153455.GB4878@sirena.org.uk>
In-Reply-To: <20210309153455.GB4878@sirena.org.uk>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 12 Mar 2021 10:32:54 +0200
Message-ID: <CAEnQRZB_VgsEPYgxtWQWUgs2+noRt1AMMHf2crJ_9Hg7s7NJ0Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: core: Don't set platform name when of_node is set
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 12 Mar 2021 11:45:35 +0100
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, dl-linux-imx <linux-imx@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

On Tue, Mar 9, 2021 at 5:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 09, 2021 at 10:23:28AM +0200, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Platform may be specified by either name or OF node but not
> > both.
> >
> > For OF node platforms (e.g i.MX) we end up with both platform name
> > and of_node set and sound card registration will fail with the error:
> >
> >   asoc-simple-card sof-sound-wm8960: ASoC: Neither/both
> >   platform name/of_node are set for sai1-wm8960-hifi
>
> This doesn't actually say what the change does.

Will send v2 with a better explanation.

>
> > -                     dai_link->platforms->name = component->name;
> > +
> > +                     if (!dai_link->platforms->of_node)
> > +                             dai_link->platforms->name = component->name;
>
> Why would we prefer the node name over something explicitly configured?

Not sure I follow your question. I think the difference stands in the
way we treat OF vs non-OF platforms.

With OF-platforms, dai_link->platforms->of_node is always set! So we
no longer need
to set dai->platforms->name.

Actually setting both of_node and name will make sound card
registration fail! In this is the case I'm trying
to fix here.
