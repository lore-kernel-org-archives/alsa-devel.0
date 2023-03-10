Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E32C64EC4
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 16:59:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC57918F8;
	Fri, 10 Mar 2023 17:58:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC57918F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678467550;
	bh=phAQxECz9h5GFTGGI6zm8n8rcaLt3pRdq9MXEww5Xvw=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gqSWn9SVotPYH60Di64gNLvYjOS2NBnvDDek1zag2m0NJKSOkmVXzd7/vDQty9sNt
	 kPuHlRHeggEfdJvEe/uKTfIzFkhb9MAq0YK5MCrcuYxWW2Amcnx8ZSKrr2DON9YGKE
	 Oo//q4BDaVmFBJgsSPGZMpW3tlT90g2IkFmcbKHw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07EF6F80529;
	Fri, 10 Mar 2023 17:57:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A04D9F8042F; Fri, 10 Mar 2023 17:57:19 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63BF9F80093
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 17:57:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63BF9F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VxcLvxi0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467437; x=1710003437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=phAQxECz9h5GFTGGI6zm8n8rcaLt3pRdq9MXEww5Xvw=;
  b=VxcLvxi0ePzw9bcmdqA5jN3OQMq1nd88n+V9vMiR4dAQCHeFfq6LvAWw
   V5aTecHjVInfTZJInN3bQM4s5Io6h09M+FKO7yEeQ1atJAHrislOzOFgT
   NCzOq+5FsgJTYbePpvvuZpjWUtTO/dpCO0DEIGaf3Q4hkFspkYD/6nACX
   jhrfjVv6O02VU5Rwl4MXQg98vZwXKCCZ+XDbW65Ilsa2z0q8UbFsZFCBj
   zgnnspjTp8RxZ6jRdUewD8Tr/APDdA7dfX/TFxIldTo4AzsQ7t7n0SNJj
   vr721JgCuMJyXodA3VGKpaOyOjQgr6ZfCQ9YFF6JI2dCdMOHsMbdPHVXi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334249289"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="334249289"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 08:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="801660837"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="801660837"
Received: from ikably-mobl.amr.corp.intel.com (HELO [10.255.33.96])
 ([10.255.33.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 08:54:59 -0800
Message-ID: <33f6df8a-2ccc-838a-64f0-5ba5daffec11@linux.intel.com>
Date: Fri, 10 Mar 2023 10:46:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V7 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
 <20230310162554.699766-9-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230310162554.699766-9-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: PW6NEVOO4SEJ6DNHYQN74DWM2ABM27BF
X-Message-ID-Hash: PW6NEVOO4SEJ6DNHYQN74DWM2ABM27BF
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
 Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PW6NEVOO4SEJ6DNHYQN74DWM2ABM27BF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/10/23 10:25, Vijendar Mukunda wrote:
> Add pm_prepare callback and System level pm ops support for
> AMD SoundWire manager driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
