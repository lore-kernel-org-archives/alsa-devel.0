Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4672C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:03:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679CC20848
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="deOaMKUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679CC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C25B51666;
	Mon,  9 Mar 2020 15:02:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C25B51666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583762606;
	bh=CRSMGvCcXY8WP8pDkj8s8+Np+w2JoIMFlF3OZ67OKMo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=deOaMKUFoBiZDfSQN1L5pbiD1QUvrx08c37P2D1M24pOUox6qrYWredkWY1PohqWC
	 OFGeGzAZNJ/czal/2OkXt2zEUrRUTVhQwc+/T556Bxh6K65gt0KVaoBXCObiqqf+Oo
	 hsFbRBYxL/ZLLUtA2fiRhDw3dCacuQMbx+lwVUGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A489F801A3;
	Mon,  9 Mar 2020 15:02:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF809F801EB; Mon,  9 Mar 2020 15:02:33 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6959F800B5
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 15:02:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6959F800B5
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 07:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; d="scan'208";a="234020274"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 07:02:26 -0700
Subject: Re: [PATCH 0/7] ASoC: Intel: Skylake: Fix HDaudio and Dmic
To: Mark Brown <broonie@kernel.org>
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <9d53337b-b02b-efd7-790e-c3db18562346@linux.intel.com>
 <20200309113844.GA4101@sirena.org.uk>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e50a52eb-ea7a-4528-cfdb-1dd9210b5779@intel.com>
Date: Mon, 9 Mar 2020 15:02:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309113844.GA4101@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 lgirdwood@gmail.com
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

On 2020-03-09 12:38, Mark Brown wrote:
> On Fri, Mar 06, 2020 at 02:48:39PM -0600, Pierre-Louis Bossart wrote:
> 
>> There's been a couple of accidental regressions already on stable, now
>> fixed, and my understanding is that the bar for inclusion is higher, so
>> let's assume this counts as a new feature: it never worked before with an
> 
> There's been no change in the requirements for stable, those regressions
> have come from patches that have been pulled in automatically by the bot
> Sasha runs which doesn't pay attention to the requirements but tries to
> identify patches automatically.
> 

Mark, what's your take on backporting these to 4.19 LTS? Do we abandon 
the subject and "just" merge (once reviewed/ approved) into 5.5? I 
believe addressing all the issues mentioned on 4.19 is important.
