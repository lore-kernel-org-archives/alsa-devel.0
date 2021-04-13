Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115D3C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 12:21:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA8A61242
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 12:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA8A61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31F0D15F2;
	Tue, 13 Apr 2021 14:20:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31F0D15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618316506;
	bh=9s6P9kXHuH/HMAwMeiT2oQ/kwuzX2LzunW+nAhU5wVM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n9Cxq6Nh9NOvjlO+MgNsxSTWy8Ksqex50cj+HQMsPDoiZahU3Dgh7uji+GGWtKOk3
	 2Uog2eFEvpvqAIES6IQBiVLZVFzwNTL8t6VkxcG4grcRnRaCA+A0GDtc0SgHkSi5tN
	 oOiL+kDXpYE5JTWZ3MSCMTahGEGVbMebI/rYeWZk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90E31F8021D;
	Tue, 13 Apr 2021 14:20:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A36BF8022B; Tue, 13 Apr 2021 14:20:53 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C7ACF800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 14:20:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C7ACF800EB
IronPort-SDR: DX5qBjiNl8ia/QD1mRW+ydZ4Fht3lB+CXfYJLla5J/Qi/6vazGu+YH4ZUmfflDPsmwMMPgsvUX
 q9/5UA32UWHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="214877387"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; d="scan'208";a="214877387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2021 05:20:45 -0700
IronPort-SDR: Z7bA1j7jkyVDLB8y+D1HMUEnWYRwrRWxYQ3a2xSzv5qVl/Ztlwvao5G5bfXwrTg2vzcO7KnNHD
 /GOjmhdXbBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; d="scan'208";a="521581070"
Received: from kuha.fi.intel.com ([10.237.72.162])
 by fmsmga001.fm.intel.com with SMTP; 13 Apr 2021 05:20:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation);
 Tue, 13 Apr 2021 15:20:41 +0300
Date: Tue, 13 Apr 2021 15:20:41 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
Message-ID: <YHWMmR5gBvlpd7rl@kuha.fi.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
 <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
 <YFm0u9k/DNy5URsR@kuha.fi.intel.com>
 <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Mon, Apr 12, 2021 at 03:36:20PM -0500, Pierre-Louis Bossart wrote:
> I took the code and split it in two for BYT/CHT (modified to remove devm_)
> and SoundWire parts (added as is).
> 
> https://github.com/thesofproject/linux/pull/2810
> 
> Both cases result in a refcount error on device_remove_sof when removing the
> platform device. I don't understand the code well enough to figure out what
> happens, but it's likely a case of the software node being removed twice?

Right. Because you are injecting the node to an already existing
device, the node does not get linked with the device in sysfs. That
would increment the reference count in a normal case. It all happens
in the function software_node_notify(). Driver core calls it when a
device is added and also when it's removed. In this case it is only
called when it's removed.

I think the best way to handle this now is to simply not decrementing
the ref count when you add the properties, so don't call
fwnode_handle_put() there (but add a comment explaining why you are
not calling it).

For a better solution you would call device_reprobe() after you have
injected the software node, but before that you need to modify
device_reprobe() so it calls device_platform_notify() (which it really
should call in any case). But this should probable be done later,
separately.

thanks,

P.S.

Have you guys considered the possibility of describing the connections
between all these components by using one of the methods that we now
have for that in kernel, for example device graph? It can now be
used also with software nodes (OF graph and ACPI device graph are of
course already fully supported).

-- 
heikki
