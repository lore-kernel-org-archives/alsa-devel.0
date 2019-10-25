Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE9CA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:45:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABE821929
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nUAIorm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABE821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1A1717A5;
	Fri, 25 Oct 2019 14:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1A1717A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572007549;
	bh=vTiPh9urP7BvOrKWtPoxSU1KQxyBgL7qahqW8Z8/4RU=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUAIorm3zlEGx+QtT/+MS+1JKjvy+ZaZ+FELvxvTX+n5hRr4P7wXyJXZk/QCGjBYG
	 eiicMOQibIbL3QNjYw+Ed8XEWydZ2qg0eHc5HXrS6nxi07IOTX4e1Mzv2H9odG2hHM
	 EgxX3V4LxWUEWsfnXQ2IevRCmhG2ss19rhsIYwq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6AA6F803A6;
	Fri, 25 Oct 2019 14:44:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF30BF8045D; Fri, 25 Oct 2019 14:44:34 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 983ADF8036F
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 14:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 983ADF8036F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 05:44:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="350017065"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 05:44:26 -0700
Date: Fri, 25 Oct 2019 15:44:26 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20191025123038.19728-1-perex@perex.cz>
Message-ID: <alpine.DEB.2.21.1910251542360.16459@zeliteleevi>
References: <20191025123038.19728-1-perex@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: change 'HDMI/DP, pcm=' to 'HDMI/DP,
 pcm=' Jack control names
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

Hi,

On Fri, 25 Oct 2019, Jaroslav Kysela wrote:

> There is an inconsistency in the names for the HDMI/DP Jack control
> names between some ASoC drivers and the HDA HDMI driver which
> introduced this naming in 2011.

this will break a lot of existing devices that are using out-of-tree UCM
files, so I'm not sure this is worth the effort.

When the common-hdmi patches go in (v7 sent earlier this week), SOF will 
switch to common-hdmi and the also the naming will be aligned. 

Br, Kai

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
