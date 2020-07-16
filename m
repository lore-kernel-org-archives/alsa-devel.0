Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E654C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:33:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0CF2076A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JweAxt0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0CF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 769271660;
	Thu, 16 Jul 2020 20:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 769271660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594924436;
	bh=0Lolpcwb048ct19EoXd9+YJZGkn5TTjMsvLwHwbVZ/E=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JweAxt0VP9b1KTGgoGXyp9NhnAtdWCXync3FeveCkfCGJxIoD0NU205IizpdRVESc
	 Q2ev6KWlT2XP2cVREUI1bggds7rmpmdturrAa3ZapXbAvQzZMYpae/f3LMapzbeb62
	 2h4yIqD4sYt+B1/8AvsM/HCh5B1XA2L1cOm8XE+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD2B6F802BC;
	Thu, 16 Jul 2020 20:32:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E9D5F802BD; Thu, 16 Jul 2020 20:32:30 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E30FBF8014C
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 20:32:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E30FBF8014C
IronPort-SDR: 23MkS7MYAEU/htNsP2qxlcEMaaFmFgknnBeRVQd8V/X/2iswOg5yH6mwCcVGc1RHsa5T0f5mBB
 uy6MSFB784UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="149455762"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; d="scan'208";a="149455762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 11:32:16 -0700
IronPort-SDR: +IW1KEsx7NZ6onBPKpo+2/IjR93jR9PXg+ju1lJCw9vKs9ZP7reW1wh9vXOaL+wMc9o+lBmUXc
 w32UuHz+VfWg==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; d="scan'208";a="460570615"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2020 11:32:13 -0700
Date: Thu, 16 Jul 2020 21:31:36 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 0/2] ALSA: hda: export snd_hda_codec_cleanup()
In-Reply-To: <s5heepcpmdr.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2007162130480.3186@eliteleevi.tm.intel.com>
References: <20200715174551.3730165-1-kai.vehmanen@linux.intel.com>
 <s5heepcpmdr.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Wed, 15 Jul 2020, Takashi Iwai wrote:

> For this kind of small changes, it's fine to merge directly into ASoC
> tree.  So feel free to take my ack for both:

ack thanks, I'll send the full series via ASoC tree!

Br, Kai
