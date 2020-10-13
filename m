Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD7C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:32:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA4420678
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZamiYhWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA4420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BDDB167F;
	Tue, 13 Oct 2020 03:31:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BDDB167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602552756;
	bh=TY1H+V3Cq2boj8RZgyGGHqoAJpi/cP3Kwqn2fxYnh2Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZamiYhWYEH4G4HpLvC3TIyYLhrtwIS6kDigP5pgXtsfXuJK04gVoyOcm3YbLJ3Lc+
	 c6B18oLmxhKKGP1nPqD2J30NRE90OejGXU35umPg7WN23P0sOq388YGPN1dqQK746E
	 N6WkIYA/FHPb2SkChKseL+bIBIeJPOopacSxqhrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE2BDF8020D;
	Tue, 13 Oct 2020 03:31:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D3D0F80217; Tue, 13 Oct 2020 03:31:44 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F292F80141
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 03:31:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F292F80141
IronPort-SDR: aJ6gUkdSchvxBrDSNNXD0HswPhGwP0OZurrBxEVTbu6oMcLm03VJYtXBAJ9swwewHfow8ove65
 bcLsDG9YSLZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165889362"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="165889362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 18:31:35 -0700
IronPort-SDR: 8nverdQOerGDbZhsc1/oEWJGEfLJUjNpq/i4L3ZAYsgubzJc4pxXNrG/QJbXuOrwt1r48p2ymn
 sWGwO5uAlxHA==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="530189997"
Received: from krlocke-mobl.amr.corp.intel.com (HELO [10.209.8.93])
 ([10.209.8.93])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 18:31:33 -0700
Subject: Re: [PATCH v2 2/6] ASoC: SOF: Introduce descriptors for SOF client
To: Randy Dunlap <rdunlap@infradead.org>,
 Dave Ertman <david.m.ertman@intel.com>, alsa-devel@alsa-project.org
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-3-david.m.ertman@intel.com>
 <076a0c53-0738-270e-845f-0ac968a4ea78@infradead.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d9f062ee-a5f0-b41c-c8f6-b81b374754fa@linux.intel.com>
Date: Mon, 12 Oct 2020 20:31:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <076a0c53-0738-270e-845f-0ac968a4ea78@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: parav@mellanox.com, tiwai@suse.de, netdev@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, broonie@kernel.org,
 jgg@nvidia.com, gregkh@linuxfoundation.org, kuba@kernel.org,
 dan.j.williams@intel.com, shiraz.saleem@intel.com, davem@davemloft.net,
 kiran.patil@intel.com
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


>> +config SND_SOC_SOF_CLIENT
>> +	tristate
>> +	select ANCILLARY_BUS
>> +	help
>> +	  This option is not user-selectable but automagically handled by
>> +	  'select' statements at a higher level
>> +
>> +config SND_SOC_SOF_CLIENT_SUPPORT
>> +	bool "SOF enable clients"
> 
> Tell users what "SOF" means.

This option can only be reached if the user already selected the 
topic-level option. From there on the SOF acronym is used. Is this not 
enough?

config SND_SOC_SOF_TOPLEVEL
	bool "Sound Open Firmware Support"
	help
	  This adds support for Sound Open Firmware (SOF). SOF is a free and
	  generic open source audio DSP firmware for multiple devices.
	  Say Y if you have such a device that is supported by SOF.

> 
>> +	depends on SND_SOC_SOF
>> +	help
>> +	  This adds support for ancillary client devices to separate out the debug
>> +	  functionality for IPC tests, probes etc. into separate devices. This
>> +	  option would also allow adding client devices based on DSP FW
> 
> spell out firmware

agree on this one.

> 
>> +	  capabilities and ACPI/OF device information.
>> +	  Say Y if you want to enable clients with SOF.
>> +	  If unsure select "N".
>> +
> 
> 
