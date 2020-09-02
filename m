Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FAC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:12:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0C120767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ML1wCXYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0C120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFF131800;
	Wed,  2 Sep 2020 15:11:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFF131800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599052364;
	bh=PPwlHlVBZ0UNE5iTrTX04Ku/ZiD3BLN1g7sfR17Nh4I=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ML1wCXYG1UnuPW8nLW3TwpWZ6tQcVGTD2cvF6CWCvo81YPxgCE0SA7Dr/CC+YNn3j
	 HKAorYDKtwUfb/CuzEqAzUqW/jMCASuHQ70kbp3nYvJ/I19SAbR1vdfHSolxmcYnVz
	 O5b4tfeCcIo88+pZJWUPff9bxLBDe6UughNNoiEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 705C9F800BA;
	Wed,  2 Sep 2020 15:11:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B760CF80212; Wed,  2 Sep 2020 15:11:51 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE4C5F800BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 15:11:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE4C5F800BA
IronPort-SDR: aG0iTbAiNl19GjcwheqVzNkFnx2/PF3ztFlaGuMbzb4NFtr/rFsF99RMGPJcGIQ3H+Zb+ZgjHA
 hMxoWEtjJvTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="175429781"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="175429781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 06:11:41 -0700
IronPort-SDR: yq3/0isfLYJ9qTMHVw2S5kiGnVlQkby6ppw2nAUvd3nsk7U0Ap/p/2CZb0/qxuY3qPBE+dFlpk
 ePZlCUxgS8UQ==
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="502668857"
Received: from ntishkev-mobl.ger.corp.intel.com ([10.254.144.112])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 06:11:38 -0700
Message-ID: <5acf3d02b1705ee4be362d0bd57a62fd3b133667.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "ASoC: Intel: haswell: Power transition refactor"
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Date: Wed, 02 Sep 2020 14:11:33 +0100
In-Reply-To: <20200901153041.14771-1-cezary.rojewski@intel.com>
References: <20200901153041.14771-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
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

On Tue, 2020-09-01 at 17:30 +0200, Cezary Rojewski wrote:
> This reverts commit 8ec7d6043263ecf250b9b7c0dd8ade899487538a.
> 
> 
> 
> While addressing existing power-cycle limitations for
> 
> sound/soc/intel/haswell solution, change brings regression for standard
> 
> audio userspace flows e.g.: when using PulseAudio.
> 
> 
> 
> Occasional sound-card initialization fail is still better than
> 
> pernament audio distortions, so revert the change.
> 
> 
> 
> Fixes: 8ec7d6043263 ("ASoC: Intel: haswell: Power transition refactor")
> 
> Reported-by: Christian Bundy <christianbundy@fraction.io>
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

