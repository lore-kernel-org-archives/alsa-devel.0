Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F61C7EE23
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Feb 2023 17:15:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73DF020C;
	Mon, 27 Feb 2023 18:14:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73DF020C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677518122;
	bh=heJxswUr8eAn1KOvEZyHmciQ28qADJo0M3WNsxy8kk4=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IDm+FtD6qRdyLcMhPsNKcc75r4ASNQgmjZF4XU+AsWb5IT6Dzfu9QFTfM8RnwSt6e
	 kTv2ClPb2U2K2HwPOiuDXa48B56HZCtmf5SVKnmawCp+DgV0l3A2+pgUqWOD+D1kZ9
	 /a6/gZwcIIS3nAzdFij2Ikukp/9vWHfZsKx6qFVM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38BACF8052E;
	Mon, 27 Feb 2023 18:13:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A13AEF804FE; Mon, 27 Feb 2023 18:13:14 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBFCBF802BE
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2023 18:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBFCBF802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Mopr8mbm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677517986; x=1709053986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=heJxswUr8eAn1KOvEZyHmciQ28qADJo0M3WNsxy8kk4=;
  b=Mopr8mbmqaFRMWwzueXnVwZMD/uk1ycDNhEgEZaFBiJ3gI1Wn81ZW1BZ
   peKvltXe2repU+B+sej/wJ+vgAC9eedwWHC/x6/1Ng38EAYfD0HoskNvJ
   sOx1BWECj007bg81Dyt8RivF2lJwFxjFim8xDa6Lmavq7aQ1dZEWXdIxg
   OQQNdAYjL5tWcS2siNL3cbNrUavaFdsEqLeoWwcyXZRnxYKOVcD/lxrW9
   Q9EnUU00qquiMmlMvXylIx7cQh1MhgTgm0CwcWcYgG4fmVBbZTzeqMb0L
   MFsGTYRHpwk7HO54hzlWszNDPvA6hxuj37YekYjF5qq8laujJPauk7HyJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313583668"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400";
   d="scan'208";a="313583668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 09:08:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651302245"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400";
   d="scan'208";a="651302245"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4])
 ([10.212.85.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 09:08:26 -0800
Message-ID: <73b2a130-98a4-d0c5-8cb1-488edd925de2@linux.intel.com>
Date: Mon, 27 Feb 2023 11:37:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V4 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-4-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230227154801.50319-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: XGA46CPRR4L7AAWW7SURIVT352ZGBQGZ
X-Message-ID-Hash: XGA46CPRR4L7AAWW7SURIVT352ZGBQGZ
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
 amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
 Arungopal.kondaveeti@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XGA46CPRR4L7AAWW7SURIVT352ZGBQGZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 2/27/23 10:47, Vijendar Mukunda wrote:
> Register dai ops for SoundWire manager instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

