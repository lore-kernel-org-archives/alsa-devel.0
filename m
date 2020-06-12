Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BCAC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:31:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047B2081A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xk4fY6Fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C047B2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D3FB167A;
	Fri, 12 Jun 2020 12:30:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D3FB167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591957870;
	bh=QWwMhOpF1BqS38aSp/N6lVTJKMFuvsR3ZO+ozzOb+5A=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xk4fY6FcCqKqseewgSKRdqeYRK2KiZwz1RnqYVGPza6TZdHkMVqrInoQmsvUnADg7
	 ujGe/xuq2LOYeUms3B8SuvJI1zUCmNokF+rKp69vVwZMFtSfrcZ2N0QxifZJhmw7lU
	 BWeRfNv+HI31qxIiGEPfbrYPFNNaFBcpCh1X07Nw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6257F80228;
	Fri, 12 Jun 2020 12:30:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E43B2F8021C; Fri, 12 Jun 2020 12:30:15 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D266F80058;
 Fri, 12 Jun 2020 12:30:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D266F80058
IronPort-SDR: c+DdDtCx6QMa9r2b3gjbuV64mNCGh99kEZtBmJIV1nBcH+1LIxYkNxg6aiGxkqpPO2ApaYeLsy
 0Xy/lblWNgSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 03:30:05 -0700
IronPort-SDR: FB7TDU6toUsBW8rgmmhkVAjuNlzXccIiopAQ9bo5sN9VfuAVt0LvcsBhAlbL8R29lkBq7UN9Vh
 fvLdMhYVQ04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; d="scan'208";a="419425987"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 12 Jun 2020 03:30:00 -0700
Date: Fri, 12 Jun 2020 13:29:52 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: Intel: hda: unsolicited RIRB response
Message-ID: <alpine.DEB.2.22.394.2006121325470.3186@eliteleevi.tm.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Keyon Jie <yang.jie@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
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

Hi Brent,

On Fri, 12 Jun 2020, Brent Lu wrote:

> Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> WP") from legacy HDA driver to fix the get response timeout issue.
> Current SOF driver does not suffer from this issue because sync write
> is enabled in hda_init. The issue will come back if the sync write is
> disabled for some reason.

better to align the logic, so I'm ok to take this patch to SOF. 
Can you fix the summary though:

- ASoC: SOF: Intel: hda: unsolicited RIRB response
+ ASoC: SOF: Intel: hda: Clear RIRB status before reading WP

Br, Kai
