Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AEFC4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:35:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CEF20856
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LuvnGu+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CEF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28B6A1674;
	Wed, 18 Sep 2019 15:34:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28B6A1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568813736;
	bh=lJmYlWPdYySC6n5JhPH3+0wyXNf/pDMHecIn7g4TAD8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LuvnGu+Sh1uS+KY8mqC+EDgITYVRhN8K40zWu4lb7c11F+NSxronAt7JpJM1Z/ZUX
	 RZCNvuyQasNRx+tz6JjUvSXMiCEV4n7KsPCS/8h4u8M9FAoAxFIuyooPfLJ9WmxXUl
	 jKRS+5Td9m3aGXSsCkI2k/FcXju+WNZvhug5SMZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4072F804FF;
	Wed, 18 Sep 2019 15:34:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F755F80506; Wed, 18 Sep 2019 15:34:44 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF40CF80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 15:34:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF40CF80146
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 06:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; d="scan'208";a="211856930"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2019 06:34:38 -0700
Received: from pbossart-mac01.local (unknown [10.251.11.91])
 by linux.intel.com (Postfix) with ESMTP id 947E45800D0;
 Wed, 18 Sep 2019 06:34:36 -0700 (PDT)
To: Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
References: <20190917181233.534-1-ben.dooks@codethink.co.uk>
 <20190917181233.534-2-ben.dooks@codethink.co.uk>
 <7b21823a-86e8-d3de-10b5-e047a5e025ef@nvidia.com>
 <72705cbf3b70934bdf8e7a6116f420b5@codethink.co.uk>
 <5b0044e1-b781-9fd8-b250-3d87fe3af855@nvidia.com>
 <20190918104827.GB2596@sirena.co.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <40d78f13-c1b9-3e2d-c144-2209a4c0d716@linux.intel.com>
Date: Wed, 18 Sep 2019 08:33:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918104827.GB2596@sirena.co.uk>
Content-Language: en-US
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org,
 linux-tegra-owner@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/8] ASoC: tegra: Add a TDM configuration
 callback
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

On 9/18/19 5:48 AM, Mark Brown wrote:
> On Wed, Sep 18, 2019 at 11:25:39AM +0100, Jon Hunter wrote:
> 
>> Why 2? From looking at various codecs that support dsp-a/b modes, it is
>> more common for the f-sync to be 1 regardless of the number of slots.
> 
> In DSP modes only one edge really matters anyway so it's not super
> important how long the pulse is.

There are exceptions to the rule.
In the early days of SOF, we had to provide support for amplifiers that 
did require a pulse larger than a bit. In the SOF IPC we added an 
'frame_pulse_width' field to pass the configuration all the way from 
topology to the firmware and Intel SSP driver.
The other quirk we added is the ability to control zero-padding per slot 
instead of at the end of the frame, e.g. 1 bit of padding after 24 bits 
when using 4 slots w/ 25 bits in a 100-bit frame.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
