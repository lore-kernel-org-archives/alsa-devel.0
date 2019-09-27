Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E2C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:32:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728C7217D7
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LYqtaPYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728C7217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4218315E4;
	Fri, 27 Sep 2019 17:31:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4218315E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569598350;
	bh=du7rQElwgmbwmMUZab+26LCzV9KbFzfMZQ4D3V52H8c=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYqtaPYrLEKtgF4a9cbRT68C52VewxpVXQE3vSteq3cLx5wqo2daHvuRuCsmfRzeY
	 mmghae13dbJtXsWAqr6f8m+TPI3tSNuHujFkZ8q70NdzPTAjlrSmZSb8VQwSKRn+ve
	 8PNgyDr/+LHDI1FflSrDcU9ZcWYXl9P4B2mRzSQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9DF1F8044C;
	Fri, 27 Sep 2019 17:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F109F8049A; Fri, 27 Sep 2019 17:31:37 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 815FFF800B3
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 17:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 815FFF800B3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2019 08:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; d="scan'208";a="219816264"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.6.245])
 ([10.252.6.245])
 by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2019 08:31:27 -0700
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20190923165739.3975-1-perex@perex.cz>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <746f82e2-0752-7476-85d7-9cabdd966caa@intel.com>
Date: Fri, 27 Sep 2019 17:31:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923165739.3975-1-perex@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Skylake SST driver - blacklist the
 PCI device IDs for the auto probe
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2019-09-23 18:57, Jaroslav Kysela wrote:
> There are basically three drivers for the PCI devices for
> the recent Intel hardware with the build-in DSPs. The legacy HDA
> driver has dmic_detect module option for the auto detection
> of the platforms with the digital microphone. Because the SOF
> driver is preferred, just skip PCI probe in the Skylake SST
> driver when the PCI device ID clashes by default. The user
> can override the auto behaviour with the pci_binding
> module parameter.
> 

Honestly, the SKL/ SOF/ legacy enumeration is complicated enough and I 
don't think it needs yet enough if or else.

On top of that, some of platforms listed here are shared by both and you 
cannot just enable SOF interface by default there.

> Boot log from Lenovo Carbon X1 (7th gen) with the default settings:
> 
>    snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, aborting probe
>    snd_soc_skl 0000:00:1f.3: SOF driver is preferred on this platform, aborting probe
>    sof-audio-pci 0000:00:1f.3: warning: No matching ASoC machine driver found
>    sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
>    ....

> 
> Perhaps, it may be more wise to create one shared module and all
> three drivers should call the driver detection routine(s) from one
> place.
> 

This.
It is the only right path to follow.

-

In general there are greater plans ahead as cAVS interface is actually 
the preferred one. That has been already committed by Intel. The details 
of actual merge of both drivers to solve the enumeration-and-other 
issues are still being worked on as that is quite a task : )

Czarek
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
