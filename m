Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A8C54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1220736
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="olvrELy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1220736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2835916CD;
	Fri, 24 Apr 2020 14:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2835916CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587731573;
	bh=n7tFeo7iOi2Ky2skFJonGxuFyaG7JohqA2opAAEbZ9s=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=olvrELy1YB3z/fi2/XNbYV6LHIpd+2+67fbfO6OXGYB1L5t3QE+DvlCjmdhePt0vm
	 KsSTSVyPFW4cCpLla+P+Spp9Ycas1/zWIYP61IS76/mNrLnYxopdjk4Gop8QoxzH/N
	 gVfYA6kOefYfDEhec2jfSlFCzP3RH77Ky4ehQpQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29D36F8021C;
	Fri, 24 Apr 2020 14:24:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21DC1F8023F; Fri, 24 Apr 2020 14:24:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C52F2F801D9
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 14:24:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C52F2F801D9
IronPort-SDR: E1w6mI0t1szkcSO1l2A/yq/rqMPlAJCshZrV7UEzKbcYi2GXQnC8Ge/iw5WUFLa0Z2nLqSkwVk
 L3oBMF8ex0Sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2020 05:24:32 -0700
IronPort-SDR: 3nItee1V31gG7MxACnzR9EGq9Gz9AI+IlMvBrPHW5u1wXSAlWYHErDemK2fYAmxyhvYn1MUiVQ
 ao7oDkKRQyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; d="scan'208";a="403284100"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 05:24:30 -0700
Date: Fri, 24 Apr 2020 15:24:30 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: snd-sof-intel-hda-common - add hda_model parameter
 and pass it to HDA codec driver
In-Reply-To: <20200424092520.23989-1-perex@perex.cz>
Message-ID: <alpine.DEB.2.21.2004241517530.2957@eliteleevi.tm.intel.com>
References: <20200424092520.23989-1-perex@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Hey,

On Fri, 24 Apr 2020, Jaroslav Kysela wrote:

> It may be useful to pass the specific model to the generic HDA codec
> routines like the legacy HDA driver (snd-hda-intel) allows.
[...]
> Original proposal: https://lore.kernel.org/alsa-devel/20191203161908.7496-1-perex@perex.cz/

not sure why this got stuck last year, but seems like a welcome
addition:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

> The model name "sofbus" is tricky anyway.

Hmm, I wonder is this now doing more harm than good. Based on browsing 
through the related code in hda-codec.c and friends, it would seem 
"sofbus" as the default is mostly harmless, but I could have missed
something.

Br, Kai

