Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD93C05027
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 19:24:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 460E3DEF;
	Tue, 14 Feb 2023 20:23:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 460E3DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676402660;
	bh=mN730GcofAZx7UQtH9cNk0SirtgsgD2Oln+LpGur4LI=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kF44/Qy+amaAfa6W80ZtUccAdz4sUBKffOxo+Xv20g/WMwLnCgzz3niHmRdX3eCn0
	 tWEZn+H70FehU0cT+m4BD9+tH5yBJFqnY//tzlohUrJAVrgYzMEUpceJhVa/oqND50
	 pZTtDhgVJPYw/Tg0KdI+NzfnL6H8H+ihvEfHwBfs=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 718DAF801C0;
	Tue, 14 Feb 2023 20:23:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B55AF8001E; Tue, 14 Feb 2023 20:23:01 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0172AF8001E
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 20:22:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0172AF8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cq8ddtXp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402577; x=1707938577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mN730GcofAZx7UQtH9cNk0SirtgsgD2Oln+LpGur4LI=;
  b=cq8ddtXpcYovP8EkrOIHTn1y1wnWHRV8w1tawvGYmC2NkQK6zJFpFz6L
   xyXm0AefXvTd3vGaSMXznZVNFaAIGTOXXOOTsb3sp1RJJZkq5Xs39qIwS
   oPezt6nNcx0w1CJ5Q+u/3FOWiS7P1XcGDb7hvYQ28ElLM0VpTyp6/IVmQ
   ld2XU/BN38vGXJnjU44KIQ8ymPjnIGzllsrTtk20v3PP+xA8FiP478k2A
   6FFTHw4HGu++YNrfZfU6jYeHk+PqBKIUodL2U+t2w7AxVTiZwt8lJFzxW
   7UPXt84DiykcQmwh+EtvUrdOWxFlZtn4zsiBQ6ySexwzc45C3V84XbJk6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314893705"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000";
   d="scan'208";a="314893705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 11:22:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778485232"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000";
   d="scan'208";a="778485232"
Received: from parthgup-mobl2.amr.corp.intel.com (HELO [10.209.175.23])
 ([10.209.175.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 11:22:49 -0800
Message-ID: <e79dae39-faec-b2a4-82e6-e11325904f3e@linux.intel.com>
Date: Tue, 14 Feb 2023 07:21:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-3-Vijendar.Mukunda@amd.com>
 <a3a75ead-5430-ae32-a6ae-78314bc637f1@linux.intel.com>
 <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: DESOX5D4IP5FKUYMGCK4WKMVXIRE4K7F
X-Message-ID-Hash: DESOX5D4IP5FKUYMGCK4WKMVXIRE4K7F
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
 Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
 Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DESOX5D4IP5FKUYMGCK4WKMVXIRE4K7F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


>>> +static void amd_sdw_probe_work(struct work_struct *work)
>>> +{
>>> +	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>>> +							   probe_work);
>>> +	struct sdw_master_prop *prop;
>>> +	int ret;
>>> +
>>> +	prop = &amd_manager->bus.prop;
>>> +	if (!prop->hw_disabled) {
>>> +		amd_enable_sdw_pads(amd_manager);
>>> +		ret = amd_init_sdw_manager(amd_manager);
>>> +		if (ret)
>>> +			return;
>>> +		amd_enable_sdw_interrupts(amd_manager);
>>> +		ret = amd_enable_sdw_manager(amd_manager);
>>> +		if (ret)
>>> +			return;
>>> +		amd_sdw_set_frameshape(amd_manager);
>>> +	}
>>> +}
>> There should be an explanation as to why you need a workqueue to
>> complete the probe.
> We want to separate the manager probe sequence and start up sequence.
> we will add the comment.

Do you need to split in two? For Intel, on some platforms we had a clear
power dependency, we had to wait until parts of the DSP were powered
before accessing SHIM registers, so we called the startup() when those
dependencies were resolved.

I am not sure you can count on the probe_work to enforce any kind of
delay, worst case the work function could be scheduled immediately.
