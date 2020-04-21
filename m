Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F9C54FC9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 18:16:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE21920663
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e66EC+YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE21920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4970816BD;
	Tue, 21 Apr 2020 20:15:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4970816BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587492993;
	bh=izKNP1J1n+uhEVUjHNQVsA0Au1xYcUEBxMgLnvKqra0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e66EC+YO8AyDH01+5EMKKqLvZrkB7bvyAeDC1awOHZohCgZaqL036QViMuhKICQIs
	 lgUuBxBSIlY7zr71FfG5k5yuuVYgfEv4lmX9MntvlMWs3xoCqCTja0MnrUiSccqU6u
	 XXBJ42ooKc0rSM4ft3I6ng97K6DcfUHskJLqioG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8780F800E7;
	Tue, 21 Apr 2020 20:15:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9931F801EC; Tue, 21 Apr 2020 20:15:41 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 114CBF800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 20:15:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 114CBF800E7
IronPort-SDR: ntOJVwp4x8gZSrvuTW1usaiI7HCVOuZmRS9VACPRFfklP5qs8I0B3d6thJ/oQGAmxj7M+gqfLC
 U87QFjD5r1zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 11:15:32 -0700
IronPort-SDR: Ccm6WFMCwijRQVervPtfpFpKZct6QQT9tpUANf7hXAhxT0SiY5dnpxn6KhGWJEI5utIgMpVUD1
 so0VY8fXJVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; d="scan'208";a="279736873"
Received: from gonzale2-mobl.amr.corp.intel.com (HELO [10.254.30.29])
 ([10.254.30.29])
 by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2020 11:15:30 -0700
Subject: Re: [PATCH v2] ASoC: intel/skl/hda - fix oops on systems without i915
 audio codec
To: Mark Brown <broonie@kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20200420205431.13070-1-kai.vehmanen@linux.intel.com>
 <20200421180350.GA36150@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2396af30-f854-fbf2-8da3-7b92ae96eede@linux.intel.com>
Date: Tue, 21 Apr 2020 13:15:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421180350.GA36150@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 jaska.uimonen@linux.intel.com
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



On 4/21/20 1:03 PM, Mark Brown wrote:
> On Mon, Apr 20, 2020 at 11:54:31PM +0300, Kai Vehmanen wrote:
>> Recent fix for jack detection caused a regression on systems with HDA
>> audio codec but no HDMI/DP audio via i915 graphics, leading to a kernel
>> oops at device probe. On these systems, HDA bus instance lookup fails,
>> as the first ASoC runtime of the card is connected to a dummy codec
>> (as no HDMI codec is present).
> 
> This still doesn't apply against current code, please check and resend.

works for me with git am on the for-next and for-5.8 branches? The patch 
does not indeed apply on for-5.7 but not sure if this was the intended 
target?
