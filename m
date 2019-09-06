Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE1C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:34:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041F620838
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ajeQl0Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041F620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34678826;
	Fri,  6 Sep 2019 17:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34678826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567784064;
	bh=RkwWwsF19S+ZafF1XjpYE0UqvR2s5X1S3kaUY+sqDbY=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajeQl0SxGWcgJGeMqNCK81X+UtNU88Rxm2XMArDk8snBCGENaNVHtknzBeSJkggZB
	 HPAHnQtkaGYdwXTgII3kSi9cIC7+nCarXi/89EKadk7ZzIunYlzzxwLc2IyPFFzVSy
	 ecM+wS0YAjfsBmqBSGe0t0PZZvNnA/4sPOqXv6bE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8A56F80390;
	Fri,  6 Sep 2019 17:33:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53C90F80394; Fri,  6 Sep 2019 17:33:32 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01F1CF802DF
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 17:33:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01F1CF802DF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Sep 2019 08:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; d="scan'208";a="174309690"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga007.jf.intel.com with ESMTP; 06 Sep 2019 08:33:23 -0700
Date: Fri, 6 Sep 2019 18:33:22 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <32939fda-9752-6f9e-2c7d-0a0cca2a6a08@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1909061829230.16459@zeliteleevi>
References: <20190906142909.770-1-kai.vehmanen@linux.intel.com>
 <20190906142909.770-3-kai.vehmanen@linux.intel.com>
 <32939fda-9752-6f9e-2c7d-0a0cca2a6a08@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH v2 2/6] ASoC: Intel:
 skl-hda-dsp-generic: use snd-hda-codec-hdmi
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

On Fri, 6 Sep 2019, Pierre-Louis Bossart wrote:
> > +	if (!strncmp(card->name, "sof-skl_hda_card", 16)) {
> > +		for_each_card_components(card, component) {
> > +			modname = module_name(component->dev->driver->owner);
> > +			if (!strncmp(component->name, "ehdaudio0D2", 11) &&
> > +			    !strncmp(modname, "snd_hda_codec_hdmi", 18))
> > +				use_common_codec = 1;
> > +		}
> > +	}
> 
> yuk. I am not a big fan of this...
> 
> It seems that we could pass information from the SOF side to the machine
> driver using the mach_params argument. we already pass the codec_mask and
> other fields, it wouldn't be too hard to reclaim a field or extend the
> structure to pass the information.

it is ugly, no question about it. :) My reasoning for this was to contain 
the ugliness within the machine drivers (especially these that are used 
with both SOF and SST). New machine drivers with no legacy to maintain 
could just skip it.

If the general concept of compiling both codec drivers in, and selecting 
at runtime, is acceptable, I'll check how this would look via mach_params.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
