Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63FDC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 15:09:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092FF61056
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 15:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 092FF61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54A3E17DB;
	Fri, 15 Oct 2021 17:08:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54A3E17DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634310540;
	bh=BQGxTeQeJN5SKV/yCyuaoBFDCTsTlegZ5xmCXEx60Mo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IMw5Zs7Z40KmYu8qrd+i5dAgT15efud5mO0LOgA9a5b3NBdfWreD1tYaRJCD5OoD8
	 8cfCrGcViU5l2tXxJKCPBXxdo4pg02L5fF79WcuyxYPmD66DwK4p/ccFRfERWNRtGN
	 1xDOS0h7BPAOSNu+ayVf/erEuVM3FvChHVkdQKUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3A95F80167;
	Fri, 15 Oct 2021 17:08:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D984BF80269; Fri, 15 Oct 2021 17:08:07 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 420F4F8016C
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 17:08:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 420F4F8016C
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="228209247"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="228209247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 08:07:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="492593233"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213])
 ([10.212.23.213])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 08:07:56 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with
 RT711_JD_NULL
To: Chris Chiu <chris.chiu@canonical.com>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, tiwai@suse.com
References: <20211015133424.494463-1-chris.chiu@canonical.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
Date: Fri, 15 Oct 2021 10:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015133424.494463-1-chris.chiu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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



On 10/15/21 8:34 AM, Chris Chiu wrote:
> The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
> will be overridden by rt711/rt711_sdca_add_codec_device_props when
> the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
> to RT711_JD1 and cause confusion while debugging the JD mode of
> the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
> to honor the jd_src value in rt711/rt711_sdca init.

Not able to follow what the "confusion while debugging the JD mode of
the boards without quirk" is. You need a DMI quirk or need to override
the default quirk with the kernel module parameter.

This also has the side effect of breaking ALL existing DMI quirks
implicitly using JD1...


> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> index 6b06248a9327..d05c0565e09c 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -15,7 +15,7 @@
>  #include "sof_sdw_common.h"
>  #include "../../codecs/rt711.h"
>  
> -unsigned long sof_sdw_quirk = RT711_JD1;
> +unsigned long sof_sdw_quirk = RT711_JD_NULL;
>  static int quirk_override = -1;
>  module_param_named(quirk, quirk_override, int, 0444);
>  MODULE_PARM_DESC(quirk, "Board-specific quirk override");
> 
