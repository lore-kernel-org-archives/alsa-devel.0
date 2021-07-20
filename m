Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5BC07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 15:30:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505D4610FB
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 15:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505D4610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C29D51679;
	Tue, 20 Jul 2021 17:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C29D51679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626795030;
	bh=oEp2K19JUWXnnTeBm2bAdgoFxFRM2L3ZcKWC/KJp+KI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPrBb+xfjyehuiJhSzXWisf/aqLT6zuPoZMHcAu/XzIwwROupMXttW5vnfuxuZx96
	 ROWtJ36p5VzGQNe/d34+C+lTW0Yfa0FguHB9JZbUC05mH8wnnwnmXv0mKyqLFABikU
	 nu8h+ymjpXk66G61mSfH66J2ecx8AafAvfCVre2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCFE7F80169;
	Tue, 20 Jul 2021 17:29:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE15EF8020D; Tue, 20 Jul 2021 17:29:23 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6C75F800DA
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 17:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6C75F800DA
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="198461045"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="198461045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 08:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="462083552"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10])
 ([10.209.130.10])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 08:28:59 -0700
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
To: Daniel Baluta <daniel.baluta@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
Date: Tue, 20 Jul 2021 10:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>
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




>>>> Introduce two DT properties in dsp node:
>>>>       * fw-filename, optional property giving the firmware filename
>>>>       (if this is missing fw filename is read from board description)
>>>>       * tplg-filename, mandatory giving the topology filename.
>>>
>>> These sound entirely like operating system configuration which I'd
>>> expect to be inferred from the machine identification.  What happens if
>>> a system has multiple options for firmware files, or if the OS ships the
>>> topology and firmware bundled up in a single image to avoid them getting
>>> out of sync?  What's the benefit of putting them in the DT?
> 
> Can you help me with this, specifically for selecting topology name.
> 
> I think I'm fine selecting a default value for SOF firmware name. It
> looks like even
> for Intel platforms there is no way of changing the firmware name.
> 
> But how about selecting topology name? We have lots of audio scenarios
> that can run on the exact same hardware:
> - e.g
>    - Audio PCM playback + Post Processing
>    - Audio Compress playback
>    - Keyword detection
> 
> 
> So, we need to use different topologies to select the scenario we want
> to demonstrate.
> 
> Would it be acceptable to add tplg_name as a module parameter?

we already have a "tplg_path" module parameter which was intended to differentiate between product skews/versions using the same hardware and firmware version. A typical example would be an OEM using 'public' firmware + topology for basic audio support, distributed through sof-bin and packaged by distros, and 3rd-party/closed sources firmware modules in more advanced packages distributed separately by the OEM. In the latter case you do want the same path for firmware and topology, otherwise you'd have a risk of using a topology making references to a library not bundled in the firmware.

There was an initial ask from Curtis to have the ability to override the firmware/topology names, but they've been able to work with the path parameters - set with udev rules for specific models.

If you wanted to demonstrate 'scenarios', you could use the same approach?

Two other points to reply to Mark:

- we currently don't support 'shipping the topology and firmware bundled up in a single image to avoid them getting out of sync'. No idea how that might work.

- if the machine driver is specified in DeviceTree, then the topology used is *required* to be aligned with the machine driver. The rules are that a topology may not make references to a BE dailink exposed in the machine driver, but conversely if the topology makes a reference to a BE dailink that is not exposed in the machine driver the topology parsing will fail. It's one of the current weaknesses of topology-based solutions, we have non-configurable hardware-related things that are described in topology but should really be described in platform firmware, be it ACPI or DT, and provided to the topology.



