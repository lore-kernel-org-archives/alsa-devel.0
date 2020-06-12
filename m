Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B155AC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:25:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329062081A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q+zmMLl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329062081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACFBE167A;
	Fri, 12 Jun 2020 14:24:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACFBE167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591964734;
	bh=ECye2I2/rLW2Shzl1CQE4KRz28c2zuAX8PVcwj6UPrI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q+zmMLl0k9Tu7mODUza5/8bJ29Eirk6CD2cD/5BRfXCztygtezmMx6HK6CMRHFWSL
	 jazFTU3v/rGKFPSRS8yvI2x11XnX7k6MiRhUcaK6AId/9QtzustRAoWKvWeoUwoBmq
	 XBj7tqK0aC7MpqHS083lfyvjLxw/Mng80DsgzMEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B1D1F8021C;
	Fri, 12 Jun 2020 14:24:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC04FF8021C; Fri, 12 Jun 2020 14:24:39 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C31CF80058;
 Fri, 12 Jun 2020 14:24:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C31CF80058
IronPort-SDR: uFn3b2Pg8gZCzpZFpaN1+V5WkNfHDt7Hssaq+KMIvRoxx0ChtEzWAqgdOwnmHi0HdJQuVvopET
 2YDfmjGfLq2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 05:24:28 -0700
IronPort-SDR: edLFrEi3NxAR9f/XA/1Zqf2TSrMrqLLxGG9+oW3Pj01oUUVl1GpOl4VEm+mPHVW72NRVd1LsNk
 +Q7rY9jBsIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; d="scan'208";a="448284655"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 12 Jun 2020 05:24:24 -0700
Date: Fri, 12 Jun 2020 15:24:16 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3] ASoC: SOF: Intel: hda: Clear RIRB status before
 reading WP
In-Reply-To: <s5h5zbwczuk.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2006121522440.3186@eliteleevi.tm.intel.com>
References: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
 <s5h5zbwczuk.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Keyon Jie <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Brent Lu <brent.lu@intel.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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

Hey Brent,

On Fri, 12 Jun 2020, Takashi Iwai wrote:

> On Fri, 12 Jun 2020 12:50:48 +0200, Brent Lu wrote:
> > 
> > Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> > WP") from legacy HDA driver to fix the get response timeout issue.
> > Current SOF driver does not suffer from this issue because sync write
> > is enabled in hda_init. The issue will come back if the sync write is
> > disabled for some reason.
> > 
> > Signed-off-by: Brent Lu <brent.lu@intel.com>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

thanks, looks good now:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
