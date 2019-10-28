Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE1CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:56:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B1C21744
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ONw1bZG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B1C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AF4420A2;
	Mon, 28 Oct 2019 18:55:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AF4420A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572285381;
	bh=tTUnPPQi6tpIba2ueWXwzoxu9rd4GihS+ZrN8htevVM=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ONw1bZG4n4W7frRq3vAinTtTAYX3klvEbC6BYxAvWFejTFYNgmyjxjLj8nh+l7vmy
	 VDiq4uZ1oD6wSKM4q+cv9H9cxaFbGNc5bHiRQpHCFONNEeDDeK8MsBJ5aZaHlwr8+7
	 UTuZkNb9aF3Y7/Z0NMKMwTpzrkXGbTORjidLHcIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D51AF80145;
	Mon, 28 Oct 2019 18:55:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E61CF80361; Mon, 28 Oct 2019 18:55:28 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9C5BF80145
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 18:55:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9C5BF80145
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 10:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; d="scan'208";a="400882734"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2019 10:55:20 -0700
Date: Mon, 28 Oct 2019 19:55:19 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e84f1b69-3d62-e708-1f28-c7c62b50435f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1910281943260.16459@zeliteleevi>
References: <20191023090331.10531-1-kai.vehmanen@linux.intel.com>
 <20191023090331.10531-7-kai.vehmanen@linux.intel.com>
 <s5hpnigu7rs.wl-tiwai@suse.de>
 <e84f1b69-3d62-e708-1f28-c7c62b50435f@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, libin.yang@intel.com,
 alsa-devel@alsa-project.org, broonie@kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v7 6/9] ASoC: Intel: bxt-da7219-max98357a:
 common hdmi codec support
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

Hey,

On Mon, 28 Oct 2019, Pierre-Louis Bossart wrote:
> > But I'm not entirely sure whether this is true on the recent kernel
> > build.  At least it *was* a problem in the past.
> > 
> > In anyway, please try to load the two modules on your system and check
> > whether the module loading works.
> 
> along the same lines, we have a Kconfig issue that I didn't see earlier.
> These bxt parts will only compile with the Skylake driver with the upstream
> code, the following test applies:
> 
> if SND_SOC_INTEL_APL
[...]
> I kept this change back on purpose since we can only use APL+SOF on
> chromebooks with an experimental CoreBoot and only on pre-production hardware,
> but what this means is that GLK devices wouldn't work with SOF...I'll add this
> fix to my Kconfig update series.

ack, that's a good catch. I'll keep this machine driver change in
the series anyways (I want to include all machine drivers that are in 
upstream kernel and have the HDMI setup code).

> Also I wonder if anyone tested bxt_rt298 with SOF? I see a topology for it but
> I've never seen any test results from anyone.

No info about this. The patch in my series for bxt_rt298 is a mechanical 
update (it has the HDMI code for hdac-hdmi and it can be used with SOF/GLK 
-> driver updated in the series).

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
