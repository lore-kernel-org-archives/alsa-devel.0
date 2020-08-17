Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1738EC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:38:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A0420657
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PP3iUCIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A0420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 061DB16D7;
	Mon, 17 Aug 2020 18:37:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 061DB16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597682291;
	bh=sA6MM8FoRxzilLPecCdj2PU7akUm0KlGcW7WS66iEzE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PP3iUCIsLx9iEPXIX4WMTwVy90HnvQtU+PJ+LPC/0WTGRDg5VJKyRpgZQHQ/M3nkM
	 vYWf6fYOJk8QpWVFHaCRSBzuBsh1acMobQG0cGSWpGiFqcVfmKYGPTx45sy2ivIKvd
	 JI7jif9ec6uiQkHIs2k4KCRFBYdS1hQNOqyT1C8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80166F80216;
	Mon, 17 Aug 2020 18:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8C43F80218; Mon, 17 Aug 2020 18:37:18 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6CEDF800F0
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 18:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6CEDF800F0
IronPort-SDR: IoqIS1WL59dIdYQpmmMiyTurh13+5/VtC10RVSGxliHKeCYL/kpD/1/MBEtAXZ/DPVlIgqEDzD
 9FGO5MeahuwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152152769"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="152152769"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 09:37:03 -0700
IronPort-SDR: YyBOKxZ9ZO/w6enb0ukp/ZYW2CPTjAhHAv5f/4xsmzoHJEq0bCpNspEB/UzBFW7QJjSUIUjRzo
 y2U24vjREMRQ==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="471484315"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 09:37:00 -0700
Date: Mon, 17 Aug 2020 19:35:56 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: skl_hda_dsp_generic: Fix NULLptr dereference
 in autosuspend delay
In-Reply-To: <5b3f05e6-873d-70b2-1ca7-d473a1a21210@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2008171901410.3186@eliteleevi.tm.intel.com>
References: <20200722173524.30161-1-mateusz.gorski@linux.intel.com>
 <2674621e-1546-3048-3ba2-f8fe1265d6e1@linux.intel.com>
 <014d8a2f-1ba7-1872-73b2-2384d908de79@intel.com>
 <edc0c832-c92b-ab95-c5e5-6bea2cf12973@linux.intel.com>
 <alpine.DEB.2.22.394.2008121627040.3186@eliteleevi.tm.intel.com>
 <5b3f05e6-873d-70b2-1ca7-d473a1a21210@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

Hi,

On Mon, 17 Aug 2020, Gorski, Mateusz wrote:

> W dniu 8/12/2020 o 3:48 PM, Kai Vehmanen pisze:
> > So what we really want to do is to confirm the codec driver is hdac_hda
> > (and not hdac_hdmi or any other drivers), and if yes, then call the
> > autosuspend function. I did spend some time trying to find a clean(er) way
> > to do this, but codec name seemed the best option. I'll test the hdmi-only
> > case, but I believe Mateusz patch will work in that case as well.
> 
> is there anything else I can do with this patch?

I today tested the patch on systems with only HDMI and it does the right 
thing as expected. I also took another look at ways to more cleanly 
separate between hdac-hdmi and hdac-hda here, but so far nothing cleaner. 
As this is fixing a clear regression, I'll give my:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
