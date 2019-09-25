Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4345BC432C1
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:39:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CEF21D7F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I4l70bBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CEF21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79E2416EE;
	Wed, 25 Sep 2019 13:39:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79E2416EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569411594;
	bh=MbGIuQ33KkvFtfUyWQ9xZwdM/rMc0No65L2hDgkGFm8=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4l70bBNEj1nzMG02Rhxtf5zM4XRRr7fY/Yc+VXhpl+TUA/zwZ/Io8ckcIkXw3i8j
	 hB0MP80wb7Zj2PTPI9e5WLjD73aDTQqN61iUJV2uvarP/rxXH6Cijb04hWPt/wS8wk
	 VweHeGxKmZHxrCtR205O5XVBeRP61d44fBypKLbI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5341F80323;
	Wed, 25 Sep 2019 13:39:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23522F8044C; Wed, 25 Sep 2019 13:39:02 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F278FF80138
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 13:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F278FF80138
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 04:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; d="scan'208";a="191312951"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga003.jf.intel.com with ESMTP; 25 Sep 2019 04:38:51 -0700
Date: Wed, 25 Sep 2019 14:38:50 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: tiwai@suse.de, alsa-devel@alsa-project.org
In-Reply-To: <20190925112409.1762-3-kai.vehmanen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1909251424570.16459@zeliteleevi>
References: <20190925112409.1762-1-kai.vehmanen@linux.intel.com>
 <20190925112409.1762-3-kai.vehmanen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com
Subject: Re: [alsa-devel] [PATCH v5 2/9] ASoC: hdac_hda: add support for
 HDMI/DP as a HDA codec
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

Hello,

Takashi, please check whether this is ok. I'll highlight the changed 
section below:

On Wed, 25 Sep 2019, Kai Vehmanen wrote:

>  static int hdac_hda_codec_probe(struct snd_soc_component *component)
>  {
>  	struct hdac_hda_priv *hda_pvt =
> @@ -322,6 +392,15 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
>  
>  	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
>  
> +	/*
> +	 * Ensure any HDA display is powered at codec probe.
> +	 * After snd_hda_codec_device_new(), display power is
> +	 * managed by runtime PM.
> +	 */
> +	if (hda_pvt->need_display_power)
> +		snd_hdac_display_power(hdev->bus, HDA_CODEC_IDX_CONTROLLER,
> +				       true);
> +

This is the new bit (and matching logic in patch 5).The bug required a 
very specific timing sequence to trigger, but a clear bug nevertheless. I 
tried to fix it in spirit of your refactoring patch of to this area 
029d92c289bd, "ALSA: hda: Refactor display power management". I.e. just 
like snd_hda_intel's controller code, display power is enabled before 
probe and later managed by codec using common code.

Additional SOF specific twist is that I need to pass the 
"need_display_power" info from SOF code (where the initial codec probe is 
done and we detect a HDMI HDA codec)), to soc/codecs/hdac_hda.c where the 
actual driver probe is run for the codec. In snd_hda_intel this is all in 
one place, so somewhat more straighforward, but logic is the same.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
