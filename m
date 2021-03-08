Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 02:54:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DA36514D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 02:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DA36514D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E5FC18E0;
	Mon,  8 Mar 2021 03:53:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E5FC18E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615172040;
	bh=7LJzvyM0iG8S+Zbi2tAEBne+IX+2fOipKvbwElT9Kf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+SwikXqozYd1RzNIOeK6gLizIoVlo/SHOlNVawhP0so++4RZm4BQ22mqCi3jFtnL
	 CK8cEdxYLJCzHFcSEyY+tej53O3NbBRHLJCTzaaggOh6U/sJKHn4W3iLMAHyH4TAiC
	 GLsbIWTadMLfQ4F6GMBQ87yUzV9Tinsa7kig/pE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0ECFF8016C;
	Mon,  8 Mar 2021 03:53:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 237A4F801D8; Mon,  8 Mar 2021 03:53:08 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D97C8F800ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 03:53:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D97C8F800ED
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lJ60x-0002M6-UN
 for alsa-devel@alsa-project.org; Mon, 08 Mar 2021 02:53:00 +0000
Received: by mail-lf1-f70.google.com with SMTP id w21so2996245lfk.0
 for <alsa-devel@alsa-project.org>; Sun, 07 Mar 2021 18:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LJzvyM0iG8S+Zbi2tAEBne+IX+2fOipKvbwElT9Kf0=;
 b=KmkwN0QEI9gMTJqRMFB2Xwn5crI9oSA7iLmxo6gPiNmmt/8hLnILkW/paSec6pIo/i
 fPEp83sJc3GgcE8n/crnWRPPPsCwC0ioQH4qh6qyh34DX8AAHna9dFiA/Hzf/TlkkiI0
 V3JguOsFx+MRgx784oir0wmEEEeEQ4uNXRmxVbS2lDacwSA0t9nb50C0vGCmdfnGAtfS
 NIfn+C2vgPx7vaIFA26XJoRm6HT7yvrs2kExc71TjRU3OQ9Bwnqu43J6uTLe23KJ5ypE
 EwhjpZenRjY7gja+PMj/9uU2PShRqZqmBhVxsfdzspSWMIQ89pjEyeLHKnvt9xyf3qGV
 ayUw==
X-Gm-Message-State: AOAM530HtD+iqy2o/YNMh+d8i9bz+YIlliThyFiZDSmULLvkeIMxzJlY
 RJrvFpJNisaoh/+i/xByqaNDWBokrzo7JuDMvm0SB7jRy6isGqG5fW/GfTdm7UGIQTwHJeuD0xM
 Gvo0WnztJMrgwwSuV1V8pDkfH13p62FkTGkDIzEhkKuWqczAANd4XVfu5
X-Received: by 2002:a2e:5753:: with SMTP id r19mr12495080ljd.126.1615171979404; 
 Sun, 07 Mar 2021 18:52:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEjITmJmS/wy4vZ+7yht6kBnzVu7eo1SaP2wxes4owMbz/ewjv5dAGJDSblGk7Ib1eR/6Z036BlVKLqH5IWf4=
X-Received: by 2002:a2e:5753:: with SMTP id r19mr12495069ljd.126.1615171979146; 
 Sun, 07 Mar 2021 18:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20210125115441.10383-1-cezary.rojewski@intel.com>
 <CAAd53p4fycxLn6y0WpaMWvWkN8EwmT216b40DavttfshN_GMRg@mail.gmail.com>
 <324dc8a5-c4d3-6ebf-c8e9-6321d6c93dab@intel.com>
 <CAAd53p4gqyuFPWX55fnPGHORXXf58++ZRMH9WFYp+QwS1=xDJQ@mail.gmail.com>
 <181c989f-7a4d-3cdd-11be-7378dbc9502c@intel.com>
 <5e970d19-9544-50fe-f140-b66245418c6e@intel.com>
 <CAAd53p4srH6NFwcyUCBnLj=MS8-YBvA9CPjMbcryGgi5CmUUHw@mail.gmail.com>
 <2c93bf65-4996-08c6-5be1-da4b9966e168@intel.com>
 <f20e5e2b-3761-5e13-3166-5f026d088aa1@intel.com>
 <CAAd53p6ZyuAzNJWLyONkbFndSRF2HBLn=6HLzb5RUShCmNWdVQ@mail.gmail.com>
 <46f88397-dd4e-ffb4-3bd3-8f64c4827b66@intel.com>
In-Reply-To: <46f88397-dd4e-ffb4-3bd3-8f64c4827b66@intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 8 Mar 2021 10:52:47 +0800
Message-ID: <CAAd53p6atLtgP-nrDm+CCLuBq=NNga8xcTW-7wNRQamduhzuOA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Compile when any configuration is
 selected
To: Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
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

On Mon, Mar 1, 2021 at 8:37 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2021-02-22 4:04 PM, Kai-Heng Feng wrote:
> > Hi Cezary,
> >
>
> ...
>
> >>
> >> I'd like to close the compilation issue which this patch is addressing.
> >> Could you confirm that the presented change fixes the issue on your end?
> >
> > No, the SST regression is not fixed.
> > However, it's not the scope of this patch, which is to fix a different issue.
> >
> > So please proceed to merge the patch. We can discuss the SST
> > regression in other thread.
> >
>
> Thanks for the reply Kai-Heng.
> Could you elaborate on the SST regression subject though?

I think it's easier for us if you can involve in the bug report directly:
https://bugs.launchpad.net/bugs/1902457
https://bugs.launchpad.net/bugs/1915117

Kai-Heng

>
> Mark, do you want me to re-send the patch?
>
> Regards,
> Czarek
