Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B7C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Nov 2022 16:18:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 582081691;
	Mon, 14 Nov 2022 17:17:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 582081691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668442716;
	bh=4xdTAPskJ9KY571YA+uOu9WW5TOZgcfRAB7ZQZa82Ac=;
	h=Date:From:Subject:To:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qajq75/Yn6geLgr3jIxCX8rO/4LcFr7A5XVAd39+oUKWKrb6BgW7+aL3niPjQfS6Z
	 iYFRhn5ivDfY79SRL6FaqnJ4Wq9ZXNZiIkR+nWw8/snBZaGnXoO56t3twpPE17vAGt
	 mbDIVClw+Ok4cMbqTuICo0dqlt/sReb6UvlxnQG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 159E9F80566;
	Mon, 14 Nov 2022 17:16:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9671DF800AA; Mon, 14 Nov 2022 17:16:54 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EF95F800AA
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2022 17:16:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EF95F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Kkjd6xwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668442606; x=1699978606;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=4xdTAPskJ9KY571YA+uOu9WW5TOZgcfRAB7ZQZa82Ac=;
 b=Kkjd6xwL/c6mVtDRYbJ3f4R9++CrFLceQzhI0U1YIwhlRhSuoyB7uA4m
 +srEk26eqymR1lUxiBHLWDBswyDvwrE/WFBrR0i7tA2X9TZLYxnkFQg2z
 jNDMSE6lnP8lcRpDmLwWO21tnyMcqlbrr5oyXO0PV/+4ASdBN1xgZA1oL
 ELUA97idHWGBzDQnG7A/BfHRAI6N5tN8oWGCMAcUI9EdFAkFaT1wc/cPZ
 WqiDf9fy9DqrDbIZWr2IWnQvLqpt4buOKofxExNtvKmMbJ/Jh/mAUJjbp
 VRMICp4Mig+WJ6k6nX+F2NWDMbTIcMKY+GzdwtRPgJSZsgpiBaCoXPRYg w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398301419"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; d="scan'208";a="398301419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2022 08:16:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638542600"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; d="scan'208";a="638542600"
Received: from scewbso01.amr.corp.intel.com (HELO [10.212.76.77])
 ([10.212.76.77])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2022 08:16:41 -0800
Message-ID: <bbc432e7-c52f-7e35-03d1-401cb68501cb@linux.intel.com>
Date: Mon, 14 Nov 2022 10:14:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
To: Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 11/14/22 04:29, Charles Keepax wrote:
> It is rather inefficient to be constantly enabling/disabling the PM
> runtime as we print out each individual register, switch to holding a PM
> runtime reference across the whole register output.

the change is good, but technically the pm_runtime resume happens for
the first read and suspend with a delay if use_autosuspend() is enabled,
so presumably we'll see the same number of resume/suspend with the
existing code and the suggested change.

Maybe update the commit message to mention that we constantly change
reference counts, as you did in the next patch?

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/debugfs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 49900cd207bc7..0718e9cda138a 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/debugfs.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> @@ -35,7 +36,7 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
>  {
>  	int value;
>  
> -	value = sdw_read(slave, reg);
> +	value = sdw_read_no_pm(slave, reg);
>  
>  	if (value < 0)
>  		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
> @@ -55,6 +56,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = pm_runtime_resume_and_get(&slave->dev);
> +	if (ret < 0 && ret != -EACCES)
> +		return ret;
> +
>  	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>  
>  	/* DP0 non-banked registers */
> @@ -112,6 +117,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	}
>  
>  	seq_printf(s_file, "%s", buf);
> +
> +	pm_runtime_mark_last_busy(&slave->dev);
> +	pm_runtime_put(&slave->dev);
> +
>  	kfree(buf);
>  
>  	return 0;
