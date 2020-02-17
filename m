Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6EC33FE0
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:20:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B32206E2
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZDCgERhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B32206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E689783D;
	Mon, 17 Feb 2020 14:19:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E689783D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581945608;
	bh=IMjHiKRJfdwNmaD87hdfJXPxx9pUcuBBBQWTKkgoBdE=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZDCgERhhNoogu2hs+nAnyPEQQyFjIkPhRwLVv7jr04POhzvvP0aNU8DXlqGbAD+Cl
	 NmkLi78sdeXHxHigTTQzlWsNhfvJEZ9Zjpxq1FY5UopQz9VoX+GQuAmForKUcSSL0A
	 53+3mlNc96+K55Jppzgwdyzg+qcZvYD7greYzX2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 616A5F8015E;
	Mon, 17 Feb 2020 14:19:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0D36F80172; Mon, 17 Feb 2020 14:18:07 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D1F4F8015E
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 14:17:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D1F4F8015E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Feb 2020 05:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; d="scan'208";a="433791068"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2020 05:17:55 -0800
Date: Mon, 17 Feb 2020 15:17:54 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20200216203516.10869-1-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2002171506330.2957@eliteleevi.tm.intel.com>
References: <20200216203516.10869-1-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: intel: Fix probe error without
 i915 graphics
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

On Sun, 16 Feb 2020, Takashi Iwai wrote:

> @@ -200,6 +202,9 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
>  	struct hdac_bus *bus = sof_to_bus(sdev);
>  	int ret;
>  
> +	if (!bus->audio_component) /* not bound with i915 */
> +		return 0;
> +
>  	hda_codec_i915_display_power(sdev, false);
>  
>  	ret = snd_hdac_i915_exit(bus);

hmm, actually found the issue in my patch. It turned out to be a bit 
suprising issue with acomp&devres.

 snd_hdac_i915_exit() calls
   -> snd_hdac_acomp_exit(), which again calls
   -> component.c:component_master_del(dev, &hdac_component_master_ops);
   -> component.c:take_down_master()
   -> devres.c:devres_release_group(master->dev, NULL);

...  now that is somewhat suprising. Basicly that goes on to release all 
devres resources for the hdac_bus device (not just those related to 
acomp!).

I can fix my immediate problem by not calling snd_hdac_i915_exit() if 
hdac_bus contineus to be used, but I'm a bit worried we could hit this in 
other flows.

Anyways, FYI at least for the list archives.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
