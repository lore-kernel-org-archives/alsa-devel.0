Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF389C35242
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:38:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B52C206D6
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qYMIWf+4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JV9M/KoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B52C206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6DDC844;
	Tue, 11 Feb 2020 22:37:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6DDC844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581457125;
	bh=gWPK1+efQ0LibeCT4NXMdf/M68mClkuRdkYmQ9vA7oY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYMIWf+42TDy9FggmTMRwXQe1tFYSIFDX5e8YAbXGNJhHwqbE4RqbxRxbZ2/39W2B
	 +9PWvLxr4PP6s8spCKZyd/hqIUPmSbT91cMigae1Qr9nh7UndFT5Z9zVV7Y0LX/mA+
	 S3nyGh9qgfI8lcJML3ijjNr2MYWnjKOO+NahxXac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35E0DF8013E;
	Tue, 11 Feb 2020 22:37:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D3C2F80145; Tue, 11 Feb 2020 22:37:53 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC20CF800F0
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 22:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC20CF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="JV9M/KoY"
Received: by mail-il1-x12f.google.com with SMTP id t17so4757328ilm.13
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 13:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bAH3TSvbO/mRB4povWYngWtELy+C2A0do8CLEb7AtwI=;
 b=JV9M/KoYJGhLcTAUHzonZ0GH0v+qBRL06m0KmFWqM0m2I3pUM7V2q9CD+7tCZbnQ+A
 WdIr+5L5ykzpRuGQ97uSeOn5ah0l7AjITCAJ4N9R0u/UGqlj1vJ4izJt33OTJwyN4Jc9
 ZZoT66CABuZPIs8pUTQdMP34njpd4uMKWGaBxDjD4TbbByZMsra8iUqeJH6K7/QqN3Fv
 bMYsgVeBwrwU8A3KC4TZslUbEOWVZQaUMzK2os4DneZ6htqXJzAzztmLBiOKpij8OwDb
 FmBM2R7hMQ3MDPshKjHUjQ7Er+VQoLxjtkqLgLQDvnnEbGIFFcJaOBzTl0VkFIAu30QF
 uwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bAH3TSvbO/mRB4povWYngWtELy+C2A0do8CLEb7AtwI=;
 b=kCnK3TM+gNEg9geDbaiXwDb1c/tj5Wmv4Ckw7FQCWKB2VfBMMaf9HYuWaG0sDZf2EC
 vFs+MpmfyLoUzUXSFuWVchdBwryiuNckHrpG2SU0vD8XpkTAm5DUx3R82Q6n8XL9p28x
 SsgjC0IN6F9xr4xbKh0tMiAh7f7MJKvbK4pAi+IPfIgV3bT8mAchPQ3e0tT7a+rJoUqV
 gCYeoWu2ZpJfX1kJZ/fMvXdgLuzvSfQe+DG7a4KMwgJH23wSzcKdg4EXRTiAHbPRk33A
 iP2IY6euNlgq8Htypou1tWAKCuPVbstooY1fXtP7tOT5cSg5Sz/pau0yL/0bHOXbn9yI
 zk+g==
X-Gm-Message-State: APjAAAWnmN60lpiv6YOiPQO8W3VMso7R/9Ny1Kavvp2nerOwgOA7pfdO
 RbXkNaB/0nJOlntNrVIzLlBvRbKRMfLrZSck+bLjiQ==
X-Google-Smtp-Source: APXvYqyDZz14jgRKDEFo3Xy14FVb7U/wDl2jXbDZKL2OJ/X9Ao/KIhl+C2rE1AqiSrcii+fA21d9eCOkRfew+RhOvlg=
X-Received: by 2002:a05:6e02:685:: with SMTP id
 o5mr8025699ils.209.1581457066204; 
 Tue, 11 Feb 2020 13:37:46 -0800 (PST)
MIME-Version: 1.0
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
In-Reply-To: <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Tue, 11 Feb 2020 13:37:35 -0800
Message-ID: <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Support Opensource <Support.Opensource@diasemi.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chiang,
 Mac" <mac.chiang@intel.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "Lu,
 Brent" <brent.lu@intel.com>, "cychiang@google.com" <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
	callback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

>
>
> >
> > Hi Pierre,
> >
> > Are you talking about the change in this commit acbf27746ecfa96b
> > "ASoC: pcm: update FE/BE trigger order based on the command"?
> >
> > We made this change to handle xruns during pause/release particularly on
> > the Intel HDA platforms.
>
> this change was just to mirror the behavior between start/stop, I
> thought there was a patch where we moved to TRIGGER_POST by default?
>
> What I am trying to figure out if whether using TRIGGER_PRE is ok or not
> for the SOF firmware.
>

Ahh yes, it was part of the same series as this one. fd274c2b7267b  "ASoC:
SOF: topology: set trigger order for FE DAI link"

TRIGGER_PRE won't really work in the case of SOF. We need the BE DAI to be
triggered before the FE DAI during start to prevent the xruns during
pause/release.

Thanks,
Ranjani
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
