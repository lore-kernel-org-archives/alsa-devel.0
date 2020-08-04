Return-Path: <SRS0=lfZM=BO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A3DC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 02:12:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8423420792
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 02:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fqek1E7B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsaApM3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8423420792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB984165E;
	Tue,  4 Aug 2020 04:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB984165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596507145;
	bh=5zRtRj0pNcZ+FHTY4o3BK6NyIp07VSwAdBuWoV57yS0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fqek1E7BWIMlrse3ABoWUpOw7FP7xfvmbl44SS0QTf1IyOIkZE4Lu9GAxy3idz+w+
	 NtOb8T24uxcMY2KQ4I7spjfR30c2LqyAr9OKv8e7O3d07dc2VoZA9YnhDULb/wqMsN
	 /WdRp9PPO9jj1c6Eilqx/acefBt0iFshvb6O0pSI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72590F80124;
	Tue,  4 Aug 2020 04:11:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F5ADF80150; Tue,  4 Aug 2020 04:11:34 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4008DF80124
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2020 04:11:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4008DF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nsaApM3N"
Received: by mail-pl1-x641.google.com with SMTP id t11so2190083plr.5
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lbNLUcgcp61dwL2pAmmG5QRL/i/NBysb7/NHuyoqPLA=;
 b=nsaApM3NTHR6R2T7nNwk1CPtmRQNw6viH5XfJjq+O/bdtm2Q65KlN7iX7rf0eDE2qg
 5OLREwXWLFEHVv+VPMreRV8/KN++G49x7xksnDd35LSOkcVgys8ZxB77H0fAJj/3vZ/V
 yIiGurTTSdPHHAeQKYX4VU0LXG0Uka8AQiqD4fW5iPAxg06Oh8EH1XBGIPIhjZtHXcmb
 xdH6v3suapQPOEpFVl1imcrWg4X0iyxtm3wU9LHtRDST7W6+uMcVWuCBJbivdT34z0kd
 OAMK6zph824b2NMgpfzKgT1pRY/9HfGNHMgt4WrjYrfbsLt8Adr7dHzIcmOypE8599y+
 WfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lbNLUcgcp61dwL2pAmmG5QRL/i/NBysb7/NHuyoqPLA=;
 b=a1VSavnEHa77N5oZ26VyOtsQfdMVApBecY2u227IZewChYkNskExPLhdWl7jAyDiib
 qsodvxowrQG/XqOFeXLoisCO9Zmxjhc2H4eA78gACfv5/JOYFTc18HkN5lmKF6yqLSbT
 FNclRe53kJRsYsFF9fezTy1faYfnUb9EG6j8FmWb3eb2Dlad/V+cuqFke0rezdqHeIVq
 b//PbXoP0oU5tNq1q2fg03SCaz5P+80GZCS4ny8zyC2IOQcdmMrskliNpv8unpS/KdKu
 DxbEWPFDwYs4E8eq6PCTI25y5C2yFWPlSvpSydfE/h/xP6JL+RqzPEgFCzMa0EN5VEDQ
 T3bQ==
X-Gm-Message-State: AOAM5327cWsTCBe5qmqe1nmRTEM0eYLgKcJo51kH/HNaHe5+CdEn9NzJ
 O77+a+rlFU3FdVLK1AOJu7g=
X-Google-Smtp-Source: ABdhPJxXJgybVnO38/6iDmh+Vn8Q3oldCX79b37Cqy+zqFF47vMHsrWFuGMjDfgGwC4Ihu/GP11gEQ==
X-Received: by 2002:a17:90a:bc41:: with SMTP id
 t1mr2042798pjv.181.1596507088135; 
 Mon, 03 Aug 2020 19:11:28 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id j142sm20970462pfd.100.2020.08.03.19.11.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Aug 2020 19:11:27 -0700 (PDT)
Date: Mon, 3 Aug 2020 19:11:15 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
Message-ID: <20200804021114.GA15390@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
 <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
 <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> >
> > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > is enabled.
> > > >
> > > > You are correct if there's only RX running without TX joining.
> > > > However, that's something we can't guarantee. Then we'd enable
> > > > TE after RE is enabled, which is against what RM recommends:
> > > >
> > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > # If the receiver bit clock and frame sync are to be used by
> > > > # both the transmitter and receiver, it is recommended that
> > > > # the receiver is the last enabled and the first disabled.
> > > >
> > > > I remember I did this "ugly" design by strictly following what
> > > > RM says. If hardware team has updated the RM or removed this
> > > > limitation, please quote in the commit logs.
> > >
> > > There is no change in RM and same recommandation.
> > >
> > > My change does not violate the RM. The direction which generates
> > > the clock is still last enabled.
> >
> > Using Tx syncing with Rx clock for example,
> > T1: arecord (non-stop) => set RE
> > T2: aplay => set TE then RE (but RE is already set at T1)
> >
> > Anything that I am missing?
> 
> This is a good example.
> We have used this change locally for a long time, so I think it is
> safe to do this change, a little different with the recommandation.

Any reason for we have to go against the recommendation?
