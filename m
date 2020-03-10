Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C955C10DCE
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:14:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57C4222C3
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d3ebuU7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C4222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7C43828;
	Tue, 10 Mar 2020 21:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7C43828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583871256;
	bh=Qin7XCrdp/kb4K3zbL/CxTvCvImw2kBM7gB0SV1Hul0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3ebuU7Ys7BjwF906Kp8fWm34QQTMlTIQJaTSCiONnF7p9ZS+3jt77NQKvVqvBt8I
	 z1ksLOkkZG3r8sRaEjcw8BVQNxD/lszqNVcJcBV1cOcEf/6vOAQ3OaC+1sH0AeU/zV
	 AkIAkNeAtj6m+8gShs+TAWC8vivwW8K7KJ3qweRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70524F800DA;
	Tue, 10 Mar 2020 21:13:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6044F80217; Tue, 10 Mar 2020 21:13:22 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D67AF800BC;
 Tue, 10 Mar 2020 21:13:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D67AF800BC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Mar 2020 13:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; d="scan'208";a="245809084"
Received: from agrana2x-mobl1.amr.corp.intel.com (HELO [10.251.131.149])
 ([10.251.131.149])
 by orsmga006.jf.intel.com with ESMTP; 10 Mar 2020 13:13:13 -0700
Subject: Re: [PATCH 0/3] [RESEND] ASoC: SOF: preparatory patches
To: Mark Brown <broonie@kernel.org>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <9cfc4182-1f22-9f28-52d8-f8aac1f7bc0b@linux.intel.com>
 <20200310125055.GF4106@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5cdea070-d8ad-9f23-c3f2-b3638e127f7d@linux.intel.com>
Date: Tue, 10 Mar 2020 15:13:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310125055.GF4106@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 sound-open-firmware@alsa-project.org
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



On 3/10/20 7:50 AM, Mark Brown wrote:
> On Mon, Mar 09, 2020 at 05:05:06PM -0500, Pierre-Louis Bossart wrote:
> 
>> To get a better picture of the directions, reviewers are invited to take a
>> look at the in-depth documentation written by Guennadi since the initial
>> patches were shared. This documentation was reviewed by Liam and me and is
>> really required to understand the concepts:
> 
>> https://thesofproject.github.io/latest/developer_guides/virtualization/virtualization.html
> 
> How does this relate to the virtio audio spec that's currently under
> review?  It looks to be doing something much lower level than that.

Mark, to avoid any ambiguity, what 'virtio audio spec that's currently 
under review' are you referring to?

> I am concerned that this looks to be exposing DPCM as a virtio ABI,
> we're trying to replace it as an internal API never mind ABI.

Valid point indeed.
