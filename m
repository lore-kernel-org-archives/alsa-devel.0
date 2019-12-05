Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2CDC43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:19:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA23824670
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PXSdhott"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA23824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FD67165F;
	Thu,  5 Dec 2019 22:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FD67165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575580746;
	bh=YdKEeFcq14Sv4mm3JSRJXVaae/yt6MWnw1NX0Jyqui0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PXSdhott4IuHU0PenzWIu5oMgujhWY2mxaBgjq+WNbDP4tQLGwl93dwxkruotUW+I
	 SX0Bkuc0nSSgKTr2HEt+UJuA5Zz5JjvB2koq5pTdtLGOCDmILqMzwZkTQl1yAMaob/
	 L00HoQwFucgXzn71+I89XyRB4XYNoHhHYeN1uTSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEEB7F8015A;
	Thu,  5 Dec 2019 22:18:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBDD3F801F8; Thu,  5 Dec 2019 22:18:13 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95E96F800F6
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 22:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95E96F800F6
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 13:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; d="scan'208";a="205906730"
Received: from dylanlu-mobl.amr.corp.intel.com ([10.255.92.202])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2019 13:18:04 -0800
Message-ID: <863c54b81b74b977d2ea243fea9727a897c4df37.camel@linux.intel.com>
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 05 Dec 2019 13:18:04 -0800
In-Reply-To: <CAOReqxh8y=o+y5Z=KJ1qm4uehwTpdR37OJxNsLON2LiTfiq9qQ@mail.gmail.com>
References: <20191205001605.229405-1-cujomalainey@chromium.org>
 <7205cec0f9d6082b0f3c1b9922f28b23696246f6.camel@linux.intel.com>
 <CAOReqxh8y=o+y5Z=KJ1qm4uehwTpdR37OJxNsLON2LiTfiq9qQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Bard Liao <bardliao@realtek.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Hui Wang <hui.wang@canonical.com>,
 Jon Flatley <jflat@chromium.org>, Ben Zhang <benzh@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Naveen Manohar <naveen.m@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Allison Randal <allison@lohutok.net>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: intel: Add Broadwell rt5650
 machine driver
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

On Thu, 2019-12-05 at 11:03 -0800, Curtis Malainey wrote:
> > > +
> > > +static struct platform_driver bdw_rt5650_audio = {
> > > +     .probe = bdw_rt5650_probe,
> > > +     .driver = {
> > > +             .name = "bdw-rt5650",
> > > +             .owner = THIS_MODULE,
> > 
> > Hi Curtis,
> > 
> > Do you need to set the pm_ops?
> > 
> > Thanks,
> > Ranjani
> 
> Hi Ranjani,
> 
> Not that I am aware of. Are you aware of any additional callbacks
> that
> need to be installed for this platform?
I meant ".pm = .pm = &snd_soc_pm_ops"
Without this, the card device wont be properly power managed?

Thanks,
Ranjani

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
