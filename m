Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838BBC54FD0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:32:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E120781
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kMVx6EYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F6C81688;
	Thu, 23 Apr 2020 17:31:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F6C81688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587655935;
	bh=OotyEi7IsfwVPWYgnU/BE1+qaiYT5JqefbuhlxjWar4=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMVx6EYuXKzBvhPRi8GsB8VVgiwHiHETvN54VuiSIOCWeWSxbJm3mvsyoCyJdzEBK
	 D7uYgpwUpDyqdseKPMgjIReblaZrEZUwQ1gwM8owktsyK4aJS/PvxS4jO19IxUpSxJ
	 4uSN5hydmbzCG5EFEPbQ8ueY6YcYTigWmkvoKM1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D24DDF8014A;
	Thu, 23 Apr 2020 17:31:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F8C5F801EC; Thu, 23 Apr 2020 17:31:24 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D46D3F800F2
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 17:31:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D46D3F800F2
IronPort-SDR: bIFUmDmryy0Fx5TwdJfIGZrF0rnO9R0t8jYajmfxQTlxiL2X3GXwFazAf4eOqNa7rE8/CP5RGV
 TrTnZI7N2POw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 08:31:14 -0700
IronPort-SDR: /GFKe82XVmh4+0BRn8SZTtvwp+0urUa1LNzYA81wW4ZorQZKkqcLM/YAsj+z0JsywQAuhavM1S
 QNjLFpn+IVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="457539017"
Received: from monjedli-mobl2.amr.corp.intel.com ([10.254.190.100])
 by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2020 08:31:14 -0700
Message-ID: <6d04d1bdff164a31d41757948cb3dd76144c0b66.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC:: don't use snd_soc_rtdcom_lookup()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 23 Apr 2020 08:31:14 -0700
In-Reply-To: <20200423105317.GE4808@sirena.org.uk>
References: <87d080unyx.wl-kuninori.morimoto.gx@renesas.com>
 <d20cc18d0fa10b52437e0ac29ea98792e0a3d45d.camel@linux.intel.com>
 <874ktbuq4j.wl-kuninori.morimoto.gx@renesas.com>
 <ebe305743178c4548b779f25e6400863094ef5a9.camel@linux.intel.com>
 <20200423105317.GE4808@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Richard Fontana <rfontana@redhat.com>, Shunli Wang <shunli.wang@mediatek.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-mediatek@lists.infradead.org,
 Eason Yen <eason.yen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>,
 Takashi Iwai <tiwai@suse.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Colin Ian King <colin.king@canonical.com>
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

On Thu, 2020-04-23 at 11:53 +0100, Mark Brown wrote:
> On Wed, Apr 22, 2020 at 03:39:58PM -0700, Ranjani Sridharan wrote:
> > On Thu, 2020-04-23 at 07:12 +0900, Kuninori Morimoto wrote:
> > > I'm thinking removing lookup function is nice idea,
> > > but don't feel pressure to it.
> > > "Now you know it" is very enough for me.
> > I am having a hard time visualizing a scenario where we would have
> > more
> > than one platform component. And even if we did, I'd think that the
> > driver registering these components would make sure to not
> > duplicate
> > the driver names. Of course, we dont really check if thats really
> > the
> > case. 
> 
> The only use case I can think of is a link where there's a CPU on
> both
> ends for some reason.
> 
> > Do you think it makes sense to add that check when registering a
> > component? If we do that, then keeping snd_soc_rtdcom_lookup()
> > might
> > not be such a bad idea. 
> 
> Yeah.
Thanks, Mark. Let me send a patch to handle this check in the core.

Thanks,
Ranjani

