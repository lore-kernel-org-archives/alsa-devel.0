Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78029C6FD1F
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 16:58:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 760C218D8;
	Fri, 10 Mar 2023 17:57:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 760C218D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678467513;
	bh=IA4zuP+bKfooR9mUBU/eAyMOWobrklSkXVBeUeoKr/Y=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WFsYwvhBtLXIXSp7tK4jrUZrzroWTqEQBMTrYVeS0EIF5idCwiHvgRKpaDD0bL/6a
	 pzBciZ54P/iUfHQ8SPhh+tpIOGYcB1pmUi+xLyrwh0Gu+JtM8vO3J0gp0hNyuqFVC6
	 POGcyHbpj0l3uraN8l++EswM+icLSIWO6yNaDHwM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECA80F80093;
	Fri, 10 Mar 2023 17:57:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60825F80431; Fri, 10 Mar 2023 17:57:17 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1A0CAF80093
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 17:57:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A0CAF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SQGTXJbU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467435; x=1710003435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IA4zuP+bKfooR9mUBU/eAyMOWobrklSkXVBeUeoKr/Y=;
  b=SQGTXJbUyEQB5i2ermsCUv6JbRAGYSh7ZW81bZt+Qq+dnHzhs3pbfu+p
   kYHjRcW68BsKdR/D+mJmJv918d6KB4SICOdcI9tQ3tDhc10qi3zQZU4Y/
   sV4yDbt9PICtm/8GInUO3Et5zbbPK/pbsSwqgEHadmYtoldd4UFbDNqhF
   e2H+Ko+TRxGKC7D4sKbQ5ds3OISwXdxqFyf9J8t2gjexidkKOPqIZzS3+
   LlfGX3vTVyK0qNT6wGvKRAtglXBzwUDVw6mJmRL2QjMqn0t96yPQHMSh3
   3i9dd382+SENOukvctoJLWwknfqQkbogLdCUdRVIrfVJc2X5kz8i1PAPk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334249299"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="334249299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 08:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="801660833"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="801660833"
Received: from ikably-mobl.amr.corp.intel.com (HELO [10.255.33.96])
 ([10.255.33.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 08:55:01 -0800
Message-ID: <462d1c55-dc74-dbe0-b705-e5705631484b@linux.intel.com>
Date: Fri, 10 Mar 2023 10:54:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/8] Add SoundWire support for AMD platforms
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VURVSSD7TENW2P5OUE32C7TSGE4I3JC4
X-Message-ID-Hash: VURVSSD7TENW2P5OUE32C7TSGE4I3JC4
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
 Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VURVSSD7TENW2P5OUE32C7TSGE4I3JC4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/10/23 10:25, Vijendar Mukunda wrote:
> ACP IP(v6.x) block has two SoundWire manager instance support.
> This patchset adds support for AMD SoundWire manager driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

I provided my Reviewed-by tag for all 8 patches, all feedback was taken
into account and the code looks good to me at this point. This was a
productive interaction, much appreciated.

