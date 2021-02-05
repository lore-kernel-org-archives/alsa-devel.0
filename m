Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0AC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:21:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F57C64D99
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F57C64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57F761682;
	Fri,  5 Feb 2021 17:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57F761682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612542065;
	bh=5z215FYPGA0T/F4vEL0tyqMt5NR1/Vd8z/qDIcut9X4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQUhvEgBeSXsMlIu3KQoW1eb5NgYOg2/i5uqgYMBU0LJgrU5rnPjGjdrzgwLpCN/6
	 IkA1vG9q34ZO1KJTbWnckbz+7i0Fi4dIIJvCQ7X3xGXmX1rEXYZyLtgxHspM7Kxlac
	 f8kBnr/IvRFKHWiANd8uS9QLFjwiv5mCgZySqGvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A558AF80264;
	Fri,  5 Feb 2021 17:19:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B0C7F8026B; Fri,  5 Feb 2021 17:19:26 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 861A5F80152
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 17:19:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 861A5F80152
IronPort-SDR: Z6v4k+p+xDGCg9yABnv8m8aVZPizC/UDo+yxN3LtLpMxoTbNDXcYWjTc0hdgCGQP5acvwslqID
 KGOdJt9Vjzuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168570503"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="168570503"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 08:19:12 -0800
IronPort-SDR: vI6yDYYoX55QmM8S4GOE9030RMWx8Va+4uopWh1v0W10+ipUMXOR9zWIixyR3MgA17VIG9KaiR
 eVgeFxlfACKQ==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="393923553"
Received: from gjcomber-mobl.amr.corp.intel.com (HELO [10.255.228.165])
 ([10.255.228.165])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 08:19:11 -0800
Subject: Re: [PATCH] soundwire: intel: fix possible crash when no device is
 detected (was Re: Crash in acpi_ns_validate_handle triggered by soundwire on
 Linux 5.10)
To: =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
 <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
 <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
 <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com>
 <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
 <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
 <CA+GA0_sOQeQsaa1JFO3+ySqdLU6BNxrJRrHjqtheEuj60ZmwhA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
Date: Fri, 5 Feb 2021 10:16:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+GA0_sOQeQsaa1JFO3+ySqdLU6BNxrJRrHjqtheEuj60ZmwhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Erik Kaneda <erik.kaneda@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, "Slusarz, Marcin" <marcin.slusarz@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Len Brown <lenb@kernel.org>
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

Thanks Marcin for the patch, much appreciated.

> acpi_walk_namespace can return success without executing our
> callback which initializes info->handle.
> If the random value in this structure is a valid address (which
> is on the stack, so it's quite possible), then nothing bad will
> happen, because:
> sdw_intel_scan_controller
>   -> acpi_bus_get_device
>   -> acpi_get_device_data
>   -> acpi_get_data_full
>   -> acpi_ns_validate_handle
> will reject this handle.
> 
> However, if the value from the stack doesn't point to a valid
> address, we get this:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000050

[...]

> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index cabdadb09a1b..bc8520eb385e 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -405,11 +405,12 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
>   {
>       acpi_status status;
> 
> +    info->handle = NULL;
>       status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                        parent_handle, 1,
>                        sdw_intel_acpi_cb,
>                        NULL, info, NULL);
> -    if (ACPI_FAILURE(status))
> +    if (ACPI_FAILURE(status) || info->handle == NULL)
>           return -ENODEV;
> 
>       return sdw_intel_scan_controller(info);

It does seem like a required code pattern if I look at I2C and SPI. I 
had no idea. Maybe worth documenting?

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
