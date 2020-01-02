Return-Path: <SRS0=fcCl=2X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0FC2D0DC
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:22:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87C20848
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qmi/VCsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC32C16E0;
	Thu,  2 Jan 2020 22:21:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC32C16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578000136;
	bh=n8zYfdJqoZkpGsyZbyoA7kCuZjsV4cqI2CVcfQ3WvxM=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qmi/VCsg9/9dMx8CfOMgXf1ol/MTfo/5Pc51ZpxgXWuN29BReyA3KyoPQq5bj6F4M
	 zMsUtReBOo9yRtBApVr7TSI1ewPmKXOMlzui2dwEH7VRincoHExE9rg1aTThBIro6o
	 FZz9GuMF0kk2k4AHdyMgUzGzEYL+tsOgpO2lWAgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C50ABF8028C;
	Thu,  2 Jan 2020 22:18:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D49BBF8026A; Thu,  2 Jan 2020 22:18:39 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9BF0F8021C
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2020 22:18:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9BF0F8021C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jan 2020 13:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; d="scan'208";a="224819862"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105])
 ([10.252.139.105])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:34 -0800
To: Arnd Bergmann <arnd@arndb.de>, Cezary Rojewski
 <cezary.rojewski@intel.com>, Liam Girdwood
 <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20200102135322.1841053-1-arnd@arndb.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <96bf1ce8-0f96-0c81-130b-970427b82fab@linux.intel.com>
Date: Thu, 2 Jan 2020 12:50:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102135322.1841053-1-arnd@arndb.de>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Naveen Manohar <naveen.m@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: boards: Fix compile-testing
 RT1011/RT5682
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/2/20 7:52 AM, Arnd Bergmann wrote:
> On non-x86, the new driver results in a build failure:
> 
> sound/soc/intel/boards/cml_rt1011_rt5682.c:14:10: fatal error: asm/cpu_device_id.h: No such file or directory
> 
> The asm/cpu_device_id.h header is not actually needed here,
> so don't include it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Indeed it's not needed, thanks for spotting this.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> I found this last week, but the patch still seems to be needed
> as I could not find a fix in mainline or -next.
> 
> Please ignore if there is already a fix in some other tree.
> 
> 
>   sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> index a22f97234201..5f1bf6d3800c 100644
> --- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
> +++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> @@ -11,7 +11,6 @@
>   #include <linux/clk.h>
>   #include <linux/dmi.h>
>   #include <linux/slab.h>
> -#include <asm/cpu_device_id.h>
>   #include <linux/acpi.h>
>   #include <sound/core.h>
>   #include <sound/jack.h>
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
