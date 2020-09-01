Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C9C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:32:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6A02071B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b9zv11Uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6A02071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C33317B6;
	Tue,  1 Sep 2020 22:31:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C33317B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598992352;
	bh=Wfn9TQwat/jpQvtBjUEFpNpEt4eW7A/A1IMkX3ajVJk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9zv11Uj9v1eiJt7lfEMYvp2j+96ZgnmCngzVHQifu6YO6LmWQR3QCQ3R6afLv+jp
	 cclW2p5BVNQ5a+BIx5C+OG95VCX7JirzctQo3IYdK9x9lsoGj2naj0MTFz5Dg/Fiih
	 xaiZIHudnsoUexxIh0eqL/Ftj5QjHSTZyByTFX08=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9F29F801EB;
	Tue,  1 Sep 2020 22:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B80FF801EB; Tue,  1 Sep 2020 22:31:39 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAA96F801EB
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 22:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAA96F801EB
IronPort-SDR: 1hPiu46RSbIDPGpKprE9YztONCcROmZ6LShMoJtriRiUQbLqaXjG5PZ93jWhfSwEeZ6MWU2HFD
 TZg1Aryht1Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="157270621"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; d="scan'208";a="157270621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 13:31:22 -0700
IronPort-SDR: i/eMaE4lWqrzdateVE5/zG/0DrvGbbrNZRBtC9vv/8MdhKmu8vL5iFLTBu4dSz8wuS/aZTumqw
 E91uU0hk5jUA==
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; d="scan'208";a="446273226"
Received: from irinav-mobl2.ger.corp.intel.com ([10.214.227.58])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 13:31:17 -0700
Message-ID: <a4b2783c7ae274c752c8d2322e535006f6c46c1f.camel@linux.intel.com>
Subject: Re: [bug report] 'ASoC: Intel: haswell: Power transition refactor'
 and PulseAudio
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Tue, 01 Sep 2020 21:31:13 +0100
In-Reply-To: <c93c0522-d8b7-e4c4-b11b-80646cfd0432@intel.com>
References: <9bc5b3ac-87a0-4d7c-abfd-2407db90d310@www.fastmail.com>
 <28ee99bc-fe27-9111-893b-1cb000067a7c@intel.com>
 <026aa0fd558b8b91a67a868a25eb84d8749101b7.camel@linux.intel.com>
 <c93c0522-d8b7-e4c4-b11b-80646cfd0432@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Christian Bundy <christianbundy@fraction.io>,
 yang.jie@linux.intel.com, zwisler@google.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org
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

On Tue, 2020-09-01 at 17:37 +0200, Cezary Rojewski wrote:
> > > Thank you for report! Issue is a known one to us and has already
> > > been
> > > addressed by:
> > >       [PATCH v4 00/13] ASoC: Intel: Catpt - Lynx and Wildcat
> > > point
> > >       https://www.spinics.net/lists/alsa-devel/msg113762.html
> > > waiting for final dependency to be merged (Andy's resource-API
> > > changes,
> > > as Mark already added the SPI ones) so v5 with review changes can
> > > be
> > > provided. Shouldn't be long before this gets merged. As
> > > consequence,
> > > /haswell/ ceases to exist.
> > Please also don't forget that the new BDW HW register programming
> > flows
> > need to be shared as common code with the SOF BDW driver.
> > Thanks
> > Liam
> 
> 
> I don't believe this is related to Christian's report.

To be clear, it's related to v5 readiness statement and not this
report.

Thanks

Liam

