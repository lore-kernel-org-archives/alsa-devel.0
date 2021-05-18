Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C1C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 19:31:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C786112F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 19:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C786112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D00D416C6;
	Tue, 18 May 2021 21:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D00D416C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621366306;
	bh=8oXQQgWLxylKWtOSWu84sl6wPCsM4IjU1PCETxGkU4A=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXmooYjrmmParWO6SL5bGh4da5MpOsW9TUBA3iO6BRiEhHYWCUJk3GMCpdxvLiRtg
	 jrmAVcSBLbLOaC9Y02BrhO7DB3sWGe4GfvBF8xtdwZCrEBqqEOnuk5xQ1v3tWXBjVC
	 QMQhApWM0K9livSE8EkSVXGDQWy6Y23eKu8jSQCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C689F801DB;
	Tue, 18 May 2021 21:30:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5472DF80217; Tue, 18 May 2021 21:30:55 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96BC6F8014C
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 21:30:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96BC6F8014C
IronPort-SDR: wXZ3Or+0QI16e2PZ1kcyyO3MPRbg40MqWShkizW/KxLKsX2DkSWj231PgC0RSjFCbaGuREXx+C
 y1fPa2FtcsHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262027180"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; d="scan'208";a="262027180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2021 12:30:45 -0700
IronPort-SDR: JikIc2rGYNNNSrFMCHCDedtNck2dvPKYf1gi/CVMbIwlbanfhgIBq8gUHVLd6x4fSII481De0B
 3SIbqacgQQ4Q==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; d="scan'208";a="473962593"
Received: from dmallapu-mobl1.amr.corp.intel.com ([10.212.20.100])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2021 12:30:44 -0700
Message-ID: <d08b46c33ce7ce3d5f91a0dfeeebcf2d9f9e0f10.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: don't send DAI_CONFIG IPC for
 older firmware
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 18 May 2021 12:30:44 -0700
In-Reply-To: <20210518190125.GH4358@sirena.org.uk>
References: <20210518174121.151601-1-ranjani.sridharan@linux.intel.com>
 <20210518190125.GH4358@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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

On Tue, 2021-05-18 at 20:01 +0100, Mark Brown wrote:
> On Tue, May 18, 2021 at 10:41:21AM -0700, Ranjani Sridharan wrote:
> 
> > BE hw_params op was recently added for SSP type DAIs.
> > But sending the DAI_CONFIG IPC during hw_params
> > is not supported with older firmware. So add an ABI check
> > to avoid sending the IPC if the firmware ABI is older than
> > 3.18.
> 
> Should we warn if we were trying to configure something but weren't
> able
> to?  Seems like something has got out of sync if we're trying to do
> so.
Hi Mark,

A warning would be a bit misleading here. We added the BE hw_params for
the SSP DAIs to be able to choose the right config based on runtime
hw_params. But this is relevant only if there are multiple configs in
the topology.

With the older firmware, we do not support multiple config in topology,
so what this would really end up doing is sending the same DAI config
that was sent to the DSP during topology parsing again during BE
hw_params. So it is safe to simply ignore it here.

Thanks,
Ranjani

