Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69499C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E820723711
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aGYMe6+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820723711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C14321680;
	Tue,  3 Sep 2019 18:16:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C14321680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567527424;
	bh=aaGllOi/HYSiv1oaaeephFHSPfHuhSNc1W62bZpacKs=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGYMe6+FpIyuTghFoMVIe3lATA9fCzKUyc1LItNBZ6FgpraGA9ojZrL60XbCe/wMp
	 FBoda/dFLKGBK09c30Zc1Lt7O84ETC3/Ry4jHVtHcsYjdcJRgvG0oKTj0ZutsiAXyv
	 0TO62LCFcQbrghlKYQwxBItA4wRCCSKb8y725l8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 242D0F803D7;
	Tue,  3 Sep 2019 18:16:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E32E4F8045F; Tue,  3 Sep 2019 18:16:10 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 094F7F80228
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 18:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 094F7F80228
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 09:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; d="scan'208";a="207139582"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2019 09:16:03 -0700
Date: Tue, 3 Sep 2019 19:16:02 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hv9u9tnxa.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1909031909220.16459@zeliteleevi>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
 <s5h7e6w2h10.wl-tiwai@suse.de>
 <alpine.DEB.2.21.1909031656490.16459@zeliteleevi>
 <s5hv9u9tnxa.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/7] adapt SOF to use snd-hda-codec-hdmi
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

On Tue, 3 Sep 2019, Takashi Iwai wrote:

> On Tue, 03 Sep 2019 16:18:11 +0200, Kai Vehmanen wrote:
> > On some systems this is manageable as e.g. pulseaudio will fallback to 
> > legacy non-UCM path and e.g. HDMI/DP audio keeps working. But, but, this 
> > may be problematic if UCM is needed for other functionality on these 
> > systems.
> 
> Just out of curiosity: which systems are with such UCM profiles?
> Chromebooks?

I believe this year's XPS 13 Developer edition is one such device. I'll 
try to confirm if there are more cases.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
