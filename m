Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A67C54EE9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 08:54:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C477B1607;
	Mon, 19 Sep 2022 10:53:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C477B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663577641;
	bh=7QxS/3b+jv8oLEkVkI5TSPtcKOSVhNxh6zUhyAW+1bM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEVOjBR+FftQfeobhDc3fmmt3gkPGmiFxdonzksmZYc6437FAHrMFHJqLgsmsOlKq
	 mWjz479XGB2gIpeYFdZgpScjnBIsrVCObu5k6QUn3uO27pvqbj3pszWwiVwksxbHCE
	 PE3901mBBuFd5SY/VxlA4UzR5oNiNPM6rHzFTRRA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4D0BF80539;
	Mon, 19 Sep 2022 10:52:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE8B1F8053A; Mon, 19 Sep 2022 10:52:24 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5708FF800C9
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 10:52:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5708FF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Kr5SQv9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663577539; x=1695113539;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7QxS/3b+jv8oLEkVkI5TSPtcKOSVhNxh6zUhyAW+1bM=;
 b=Kr5SQv9hS27UHukqwmMDiOkhLlQOFOqEqmj2urKgvx5EWiHWkffK0KsY
 bdz7FGCq7J6xkJXexCgpH5cYj8O/TWrdl2aPlRAI79n2t0I0t/m2mHxjD
 kcIMpCMiTl2fV083vIQy/FTfsC+qVrY3JUEMutlNrB39WcPhQ0YiOCzAO
 u6LqRdAUhLIvXI1XmIdL+5v2NJUuPpSUx5Vg8V+k00etv3Gn7geHzdmEf
 rOHTjTSJRCy5NiriEpysiP1OHNA/s7ZuXDexkhb2dhnIoUq4Dz5OlS0PB
 tPvURtrMnZa42vJTTaS86cwgI97W/5mf84HPYS+wpHRlxse1a8xq4tiSk w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="296937553"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="296937553"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 01:52:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="707485757"
Received: from ilick-mobl1.ger.corp.intel.com (HELO [10.252.59.91])
 ([10.252.59.91])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 01:52:12 -0700
Message-ID: <e20acd52-a501-713c-c0c3-f5d76670ecf6@linux.intel.com>
Date: Mon, 19 Sep 2022 10:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] soundwire: cadence: Fix error check in cdns_xfer_msg()
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220917154822.690472-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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



On 9/17/22 17:48, Richard Fitzgerald wrote:
> _cdns_xfer_msg() returns an sdw_command_response value, not a
> negative error code.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

we've got other issues like this such as

enum sdw_command_response
cdns_xfer_msg_defer(struct sdw_bus *bus,
		    struct sdw_msg *msg, struct sdw_defer *defer)
{
	struct sdw_cdns *cdns = bus_to_cdns(bus);
	int cmd = 0, ret;

	/* for defer only 1 message is supported */
	if (msg->len > 1)
		return -ENOTSUPP; <<< that's not right


We should probably double-check that all functions return enums don't
return negative values.

> ---
>  drivers/soundwire/cadence_master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index ca241bbeadd9..3543a923ee6b 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -708,7 +708,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
>  	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
>  		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
>  				     CDNS_MCP_CMD_LEN, false);
> -		if (ret < 0)
> +		if (ret != SDW_CMD_OK)
>  			goto exit;
>  	}
>  
