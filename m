Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF8C54FCC
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 22:02:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B497D206E9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 22:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fOwqRmFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01DE016B6;
	Wed, 22 Apr 2020 00:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01DE016B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587506557;
	bh=jezG8jIJrcRUz8ZI+cUx4uVeo5mIICz/cio3VM+MIfM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOwqRmFdhNdtnUI7ge2D52ZQIpVxZWbOfhJPd6GMFxLcJ9hVDx7+0oVCEG19R5lqL
	 //e+MvFqpuqSh+oaeG8i6SRpF3B6wVWfIhDieG8njq4FQ7+3p5/LZ5aNJYlNlAeiHZ
	 dGCe2vnVscQCbgp1AerjvzalBUq8DAY8OIdGsKh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85A2CF80143;
	Wed, 22 Apr 2020 00:01:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 240F2F801ED; Wed, 22 Apr 2020 00:01:38 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED817F800FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 00:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED817F800FF
IronPort-SDR: y0fPmGcpUtBbyoX3qJgKDnJIQN3uQoXhV2+bVyPcsRpBswFy5Dm5gdj20bFsR+AZhbH3TqSsm+
 zY5SKLv//BZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 15:01:27 -0700
IronPort-SDR: /IPInb68liflrj3aBrHS1R/CkZuyBJDZTCqMeYT6CZFyVUmDCBRWixOpHhfgDlZ8IzDUB6r1RS
 kSPbLmS9TC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; d="scan'208";a="456921723"
Received: from sabeliak-mobl.amr.corp.intel.com (HELO [10.254.24.98])
 ([10.254.24.98])
 by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2020 15:01:26 -0700
Subject: Re: [PATCH 1/4] ASoC: Intel: Skylake: Change the order of machine
 device and platform registration
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200421202519.4008-1-mateusz.gorski@linux.intel.com>
 <20200421202519.4008-2-mateusz.gorski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd0e8d65-74ea-8b17-9f92-ed980e265a1c@linux.intel.com>
Date: Tue, 21 Apr 2020 15:49:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421202519.4008-2-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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



On 4/21/20 3:25 PM, Mateusz Gorski wrote:
> Swap the order of machine device and platform device registration.
> This change ensures that even if the codec enumeration falls late - during
> the driver module or topology reload - i2s_dev field is always ready to
> be used.

Are you sure?

The platform device will register the DAIs that are used by the machine 
driver, don't you have a risk of missing dependencies during the card 
registration with this change?

Put differently, why do this now when the existing code has been 
'working' for a number of years without needing such a change?


> Follow-up patch uses data from this field to create alternative topology
> name based on used machine device.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/skl.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 63182bfd7941..8473eb13ea65 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -819,16 +819,16 @@ static void skl_probe_work(struct work_struct *work)
>   	/* create codec instances */
>   	skl_codec_create(bus);
>   
> -	/* register platform dai and controls */
> -	err = skl_platform_register(bus->dev);
> +	err = skl_machine_device_register(skl);
>   	if (err < 0) {
> -		dev_err(bus->dev, "platform register failed: %d\n", err);
> +		dev_err(bus->dev, "machine register failed: %d\n", err);
>   		goto out_err;
>   	}
>   
> -	err = skl_machine_device_register(skl);
> +	/* register platform dai and controls */
> +	err = skl_platform_register(bus->dev);
>   	if (err < 0) {
> -		dev_err(bus->dev, "machine register failed: %d\n", err);
> +		dev_err(bus->dev, "platform register failed: %d\n", err);
>   		goto out_err;
>   	}
>   
> 
