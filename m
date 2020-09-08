Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C6C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:48:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516EE22B4B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fb2qGY37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516EE22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0F481788;
	Tue,  8 Sep 2020 16:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0F481788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599576498;
	bh=y4/Pa+n3xUEUAnWtG++kxSjz3o0wM1M1/dE2m8ghb3w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fb2qGY37c1hpvw/VZ8KFt8u93Wvcc6C5y53pBdvD2CnDLpmG0cP1I+90RfjBAh3+z
	 OBjZ74+N/QS3iNMJhai5xszqhQdwULOc2WjNo1E+iiMjo+hTuh0nqy/WFvaIBAUtQz
	 W/kLQ2ByZXMV/btdUrxn0I5zmqW3KO7cJdw9BA9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19A8AF8026F;
	Tue,  8 Sep 2020 16:47:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3B57F80272; Tue,  8 Sep 2020 16:47:26 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84D03F801F2
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 16:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84D03F801F2
IronPort-SDR: GizWbcKGZRN6uq8gO73YxxSUpHQFUV4LX1BSACb+lDIppn+lmc47KGtPjzE9SYatmlM2wUVmGV
 SAuv3drApUFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222350544"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="222350544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 07:47:16 -0700
IronPort-SDR: puPDPc9u2j1rpXBb9lkAFy9hUk9VxiuIy5q/f3cgrvaUGVA1uCpxSlgSAOXrarnxTE+c5vsTim
 B/lcp8Cq+Crw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="448812218"
Received: from mgarber-mobl1.amr.corp.intel.com (HELO [10.212.179.134])
 ([10.212.179.134])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 07:47:15 -0700
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
 <20200908143312.GC5551@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce68a159-de6d-2d8a-c8a2-3e527cb1239e@linux.intel.com>
Date: Tue, 8 Sep 2020 09:47:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908143312.GC5551@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, Vinod Koul <vkoul@kernel.org>,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



On 9/8/20 9:33 AM, Mark Brown wrote:
> On Tue, Sep 08, 2020 at 02:28:48PM +0200, Jaroslav Kysela wrote:
>> Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):
> 
>>> I don't have this patch and since I seem to get copied on quite a lot of
>>> soundwire only serieses I just delete them unread mostly.

We now try to use the ASoC/SoundWire prefix for cover letters to 
highlight that a patchset changes things across two trees, does this 
help or do we need a different way of flagging these patches?

>> It can be fetched from lore (mbox format):
> 
>> https://lore.kernel.org/alsa-devel/20200818140656.29014-2-yung-chuan.liao@linux.intel.com/raw
> 
> Sure, I can go get stuff from the list archives but my list of things to
> go through is in my inbox.
> 
