Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD214C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:13:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F2F65215
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F2F65215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1426192B;
	Mon,  8 Mar 2021 17:12:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1426192B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615220004;
	bh=BewYzfgWOCaYSMEmS/+eHSDsou/YIUX06sDOKws87io=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=biHQTTiiTFSUVgu2gP9U9oj569w44cjltrvIaMSiW9/jaL4/zRS37H8geX1pquCqq
	 E33CmRPsEWVPuG5JNBHsjYBoMKJlz0qOY8EI+ThBY3Hv6/4nek9BBkoeZv8prQdRtP
	 4Q1K0tdrFnNittQSjpDvxTU1J9tVK/n55AyqUj4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DD0FF804F3;
	Mon,  8 Mar 2021 17:08:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0677F804E6; Mon,  8 Mar 2021 17:08:49 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8A1DF804AD
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8A1DF804AD
IronPort-SDR: 9NbFKXOF3Z6LQ3z+6qnN4Wy3uVim+gkGhS5yak18gAk5/bUXn0St12pHz0NDMsnuPZVZOrXOEA
 m6vm00JtZokA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273083311"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="273083311"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:37 -0800
IronPort-SDR: IMEqcAKyZuVXmkA9OvMZCbl2TvS/vdpGXEbx3aY+XFV/gJ2NX2tZKeONc1Y48Ma+RYaDHcqY1I
 UmmwjljYlFVg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="430419043"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206])
 ([10.212.234.206])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:36 -0800
Subject: Re: [PATCH] soundwire: bus: Fix device found flag correctly
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210308113752.19661-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e7cadc4-7da8-712a-7ebb-b977254d496f@linux.intel.com>
Date: Mon, 8 Mar 2021 09:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308113752.19661-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
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



On 3/8/21 5:37 AM, Srinivas Kandagatla wrote:
> found flag that is used to indicate SoundWire device on the bus is
> not reset correctly after one iteration, this could miss adding devices
> that are enumerated on the bus but on in device list.

typo? did you mean "enumerated on the bus but not on device list"?

if yes, the first part is ambiguous in its wording, the enumeration 
completes by programming a device number. At this point the device is 
only 'attached'.

The fix is correct otherwise, please add my tag if you change the commit 
message in a v2.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> 
> Fixes: d52d7a1be02c ("soundwire: Add Slave status handling helpers")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/bus.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index a9ab4a6264e0..188e391c5a83 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -712,7 +712,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   	struct sdw_slave *slave, *_s;
>   	struct sdw_slave_id id;
>   	struct sdw_msg msg;
> -	bool found = false;
> +	bool found;
>   	int count = 0, ret;
>   	u64 addr;
>   
> @@ -744,6 +744,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   
>   		sdw_extract_slave_id(bus, addr, &id);
>   
> +		found = false;
>   		/* Now compare with entries */
>   		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>   			if (sdw_compare_devid(slave, id) == 0) {
> 
