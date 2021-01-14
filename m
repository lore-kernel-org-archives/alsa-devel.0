Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC9C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 21:20:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8133F23AA7
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8133F23AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2797616B4;
	Thu, 14 Jan 2021 22:19:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2797616B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610659235;
	bh=5+1WXwCIi3E1ZhON2TFeIjHtRiwChsqgI+Rn2pS5P34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLTEK9JAkMz8+s8kbxORuhsuLxcfMKfA0YPu6BgZlsdzzRKyQd6uxmUgGWRwwAZ35
	 NWHxodFLfnTY2bVQmml3KJqSEsFb4Hb14xcQ6WOxu1+Qjd5URsrIssQ/7H6J4TIRvH
	 A/4TOE3VWf2UY1jRTVlyzrJdp/pJUfDUtJJ/wQOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8C43F80134;
	Thu, 14 Jan 2021 22:19:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B260F8025E; Thu, 14 Jan 2021 22:19:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA90F80118;
 Thu, 14 Jan 2021 22:19:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EA90F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Epe3jAe/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B89723A5E;
 Thu, 14 Jan 2021 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610659163;
 bh=5+1WXwCIi3E1ZhON2TFeIjHtRiwChsqgI+Rn2pS5P34=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Epe3jAe/11FjBY0LHMOLO5rGCJJ2t6ELBW9fcE87+iz/SNp4zjrkCOIxJSYWtmNJB
 vHMipw2RCiZQrTdpP6sDReH7GoXcITiIqw2QCMa7yZMxFCEnPF+e4gdveEr5grWBfV
 KjfrOXqPvf8muH2zlFakJeSzDA/9wwhDOt5XNz6xGk1mM5Akxh3OebKTRskLIdz/Za
 xxJFJRzDgFgtpyM6skuxVtkgJuVmOkINVIlTxYGrItNdBwAGG7SxqVAZj9/Nfn1qMQ
 bdCJdkudIyK6pe39vyh43/tcwxwUjRV6WUMlNgij3kpg7oqGmEq5L+veRyRRnTjQwz
 3d72SGFBpvADA==
Received: by mail-oi1-f178.google.com with SMTP id l207so7453295oib.4;
 Thu, 14 Jan 2021 13:19:23 -0800 (PST)
X-Gm-Message-State: AOAM532JFOtk6X0l1YupYqhBnYhvHiLr9Antyb/puifgyJC4SkcmQB8F
 EmN8ebTORyohtJUbb8UAcudgmC15/bky7Sp7mGQ=
X-Google-Smtp-Source: ABdhPJxqnU7LWjnaGrNzlDTdj1wsHJs8b8gqDDmTpuHoHGEbXBS0P6btj/BhJ+hiWFjedt2LIni9g3mqXt8FQ17nwRY=
X-Received: by 2002:aca:e103:: with SMTP id y3mr3596800oig.11.1610659162777;
 Thu, 14 Jan 2021 13:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20210112203250.2576775-1-arnd@kernel.org>
 <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
 <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
In-Reply-To: <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 14 Jan 2021 22:19:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
Message-ID: <CAK8P3a0o3LVuVgLWYFHgdzWfi0MSa8MgggsP5RxApZgvxiJbwQ@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH 1/2] [v2] ALSA: hda: fix
 SND_INTEL_DSP_CONFIG dependency
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Rander Wang <rander.wang@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

On Thu, Jan 14, 2021 at 7:07 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/14/21 9:09 AM, Arnd Bergmann wrote:
> > On Tue, Jan 12, 2021 at 9:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> ---
> >> v2: fix various build issues in the first version, now passes
> >>      all randconfig builds I tried
> >
> > Please disregard this version, while I have a tree that passes
> > the randconfig builds now, this was not the patch from it that
> > I wanted to send...
>
> No worries, I reworked the PCI case completely. Still running tests to
> make sure there's no regression
> https://github.com/thesofproject/linux/pull/2683

Ok, I see. I had not realized that you already did the PCI bits as well,
and applied my original patch to your tree, as I had meant to
resend my "ASoC: SOF: ACPI: avoid reverse module dependency"
patch after fixing some additional build failures in it. I have
now applied the relevant commits from your branch to my
randconfig tree, and will let you know if that finds anything more.

From what I can tell so far, you already included the fixups that I had
locally, and more.

       Arnd
