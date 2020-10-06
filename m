Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D1C4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:24:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E966E206BE
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YfxZo19L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 427481754;
	Tue,  6 Oct 2020 14:23:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 427481754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601987038;
	bh=/zKrEJEZkXvqneuHedMpe+cYrAwIfHmWbj1TtREWOYE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YfxZo19L+trL9Ok3GYUInp2zMT4GTLQHOuLibmi9YGpWggRJGjP5L59VkCXH09eha
	 KYOOr23Q1G4Jva6XhvE9spZWTmCI0dBL98+yIW+UGWpSVuft4Sn/9GgruVhN81n6ST
	 614DQx+9mzMgUha5ckr0gOLKvaqu2TUwMddL1R0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2006F80129;
	Tue,  6 Oct 2020 14:23:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73EF5F8012A; Tue,  6 Oct 2020 14:23:06 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D69DF80053
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 14:22:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D69DF80053
IronPort-SDR: qPGadJ/x4acK04Ud08N+FG9H8R8sK/FFxNnPpi5k09jKkE0CbnUy4BdCSzrox2U0p8/Kiw+SXo
 YsyTlXR7Qd4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163697325"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="163697325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 05:22:55 -0700
IronPort-SDR: x0Z1125dYJ6sdjF2f9JTK/s8HMwFPhbvVPjx6zkOMGe2VKx0I1P9j5JtddUg4EwxdaDq5HctUl
 2Tot/sLDxQFw==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="297078264"
Received: from raystayl-mobl1.ger.corp.intel.com ([10.252.17.228])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 05:22:50 -0700
Message-ID: <86e6ae9814f9e9a9b558d81947adbcfb7e10019b.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/13] ASoC: Intel: Remove obsolete solutions and
 components
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Date: Tue, 06 Oct 2020 13:22:48 +0100
In-Reply-To: <20201006064907.16277-1-cezary.rojewski@intel.com>
References: <20201006064907.16277-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: krzysztof.hejmowski@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, ppapierkowski@habana.ai, marcin.barlik@intel.com,
 zwisler@google.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, michal.wasko@intel.com, tiwai@suse.com,
 andriy.shevchenko@linux.intel.com, cujomalainey@chromium.org,
 vamshi.krishna.gopal@intel.com
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

On Tue, 2020-10-06 at 08:48 +0200, Cezary Rojewski wrote:
> Follow up to catpt series as mentioned in:
> 
> [PATCH v10 00/14] ASoC: Intel: Catpt - Lynx and Wildcat point
> 
> https://www.spinics.net/lists/alsa-devel/msg116440.html
> 
> 
> 
> As catpt is a direct replacement to sound/soc/intel/haswell, it leaves a
> 
> lot of code redudant. The second legacy solution - baytrail - is
> 
> deprecated for a long time by sound/soc/intel/atom with SOF flavor
> 
> available too.
> 
> 
> 
> This series addresses the redudancy and removes obsolete code. Along
> 
> with the legacy solutions, all orphaned components are removed too.
> 
> 
> 
> As a consequence, further cleanups are unlocked: sound/soc/intel/skylake
> 
> becomes the sole user of processing code found in
> 
> sound/soc/intel/common. Those are not part of this series.

All 

Acked-by: Liam Girdwood <liam.r.girdwood@intel.com>

