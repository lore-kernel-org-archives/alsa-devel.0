Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C849C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:47:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42542071F
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cETQ/20L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42542071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99880847;
	Thu, 14 Nov 2019 11:46:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99880847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573728454;
	bh=JiFq3JLm0rWhLkITOTeCYWHIfrJXYR0zKrgFbDr8gwU=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cETQ/20Lqpl1CMPM96xiFOI+xNWfu18H88vCntqI2DkFvu89wcF3jQ/cvKWzi4fwH
	 JIVPo0tA7uBEHsFXv9uHYU+b6AqavFGWKxkfWEbDxecLCU+oNNbZ8PfzDXAU4mVRrQ
	 zu/zZ1WsLDFWmJ5heup9NSHI3D2u5Vm+nLxFTzJ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22EE0F800CD;
	Thu, 14 Nov 2019 11:46:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E0C7F800CF; Thu, 14 Nov 2019 11:46:42 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C00C3F8007E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 11:46:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C00C3F8007E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 02:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="207753787"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 02:46:35 -0800
Date: Thu, 14 Nov 2019 12:46:34 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Nikhil Mahale <nmahale@nvidia.com>
In-Reply-To: <20191114033704.18171-3-nmahale@nvidia.com>
Message-ID: <alpine.DEB.2.21.1911141241280.16459@zeliteleevi>
References: <20191114033704.18171-1-nmahale@nvidia.com>
 <20191114033704.18171-3-nmahale@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, aplattner@nvidia.com
Subject: Re: [alsa-devel] [PATCH v1 2/5] ALSA: hda - Add DP-MST jack support
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

Hi Nikhil,

On Thu, 14 Nov 2019, Nikhil Mahale wrote:

> This patch adds DP-MST jack support which will be used on NVIDIA
> platforms. Today, DP-MST audio is supported only if the codec has
> acomp support. This patch makes it possible to add DP-MST support
> for non-acomp codecs.
[...]
> +++ b/sound/pci/hda/hda_generic.c
> @@ -4203,7 +4203,7 @@ static bool detect_pin_state(struct hda_codec *codec, hda_nid_t pin)
>  {
>  	if (!is_jack_detectable(codec, pin))
>  		return true;
> -	return snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
> +	return snd_hda_jack_detect_state(codec, pin, 0) != HDA_JACK_NOT_PRESENT;
>  }

the patch adds quite a few checkpatch warnings. E.g. this line over 
80 character limit. Run checkpatch yourself or take a look at e.g.
https://travis-ci.org/thesofproject/linux/jobs/611787177?utm_medium=notification&utm_source=github_status

I'll queued the series to SOF CI to do some testing against regressions 
on our platforms. I'll report later if anything major found.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
