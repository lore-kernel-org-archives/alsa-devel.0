Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A69C433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0ECC20702
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="beOYhpH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ECC20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62789165E;
	Mon,  6 Jul 2020 22:03:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62789165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594065833;
	bh=gOGv6XRf7Mwfd7yqQ95DV2jHEQe39qjqB8+w8g2utn8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=beOYhpH8Dzu67HHIgTVqeBfcJgfbQF53PMa5cYY+8/7y3m/vmrUXZsclRZryrq+GL
	 tQ5ELslPZwL80+2Z7pI8clmLCNcMQuHRqbOQ18L9b9RufIpsAAK3usGQg08z3m6Q/W
	 YzU+Uw1HnTjsOWmFPELQTQWEPYUlVq6ar1fDWRWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24091F8015C;
	Mon,  6 Jul 2020 22:02:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19076F801D8; Mon,  6 Jul 2020 22:02:13 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9F14F80161
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 22:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9F14F80161
IronPort-SDR: hn72gwMbJQ28UUO7SnRIFmiSvHnzLB9l4Pgfp0iTXyqBA3FsfV3tnzdhQMQJviW1yxrrQ/3CQf
 Q/Iu9nrFi4mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149010109"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="149010109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:02:01 -0700
IronPort-SDR: IGUpkTFFDAtVY4Fec5WAPwZg+NyNpNW2g0/bO4AQIEljMCdoe9v8sG9JUKjplqKzEh7zg07CPb
 0Hrn1sPrLSoQ==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="315276322"
Received: from mghaithx-mobl1.ger.corp.intel.com (HELO [10.254.110.83])
 ([10.254.110.83])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:02:00 -0700
Subject: Re: [PATCH v2 00/10] topology: decode: Various fixes
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe7b1707-d6f3-f8ad-e72d-f5840f298d6d@linux.intel.com>
Date: Mon, 6 Jul 2020 15:01:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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



On 7/6/20 4:05 AM, Piotr Maziarz wrote:
> This series fixes various problems with topology decoding mechanism.
> Some of the problems were critical like improper memory management or
> infinite loops that were causing undefined behaviour or program crashes,
> while other resulted in losing some data during conversion.
> 
> Bugs found while testing with Intel SST topologies.
> 
> Changelog:
> v2:
>    -Divide into more patches, critical fixes are in separate patches now
>    -More specific descriptions
>    -Fix a typo UML to UCM

That fix makes it even more confusing, I get that a UCM file can set 
values for controls defined in a topology file, but 'decoding to UCM' 
leaves me wondering what you are referring to.

Also you may want to remove all the Gerrit ChangeId before sending to 
the mailing list.

>    -Add error reporting in topology: decode: fix channel map memory
>     allocation
>    -Remove goto again in topology: Make buffer for saving dynamic size
>     for better readability
> 
> Piotr Maziarz (10):
>    topology: decode: Fix channel map memory allocation
>    topology: decode: Fix infinite loop in decoding enum control
>    topology: decode: Remove decoding  values for enum control
>    topology: decode: Add enum control texts as separate element
>    topology: decode: Fix printing texts section
>    topology: decode: Change declaration of enum decoding function
>    topology: decode: Fix decoding PCM formats and rates
>    topology: decode: Print sig_bits field in PCM capabilities section
>    topology: decode: Add DAI name printing
>    topology: Make buffer for saving dynamic size
> 
>   src/topology/ctl.c        | 51 ++++++++++++++++++++++-------------------------
>   src/topology/dapm.c       |  3 +--
>   src/topology/pcm.c        | 11 +++++++---
>   src/topology/save.c       | 34 ++++++++++++++++++++++++++-----
>   src/topology/text.c       |  2 +-
>   src/topology/tplg_local.h |  2 +-
>   6 files changed, 64 insertions(+), 39 deletions(-)
> 
