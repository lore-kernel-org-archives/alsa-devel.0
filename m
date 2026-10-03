Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5841CCA5FDD
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2026 07:53:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A07896029F;
	Sat,  3 Oct 2026 09:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A07896029F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791014021;
	bh=yVcORQ/SI+eD6i2oz/HrJ6jHEXxTk376wKhfDONYQCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bZszlN71pWcW/Ji6t3HgLxVEGHlCVIy70SWWJooH0A7UYuEyas4Ipq1kaEVX1KQHz
	 Li97fGCpdaterB9TGdCX41JWPAI30KP1l7LfB4jEbfBvCsVDd7zHU24e53agpwDIXn
	 5b1HHcJJ0IdgbveCXvBsxE23HF1LPDrLG2Va+Awg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D6FBF805F3; Sat,  3 Oct 2026 09:53:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 856A3F805FB;
	Sat,  3 Oct 2026 09:53:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6AB3F80548; Sat,  3 Oct 2026 09:53:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791013979;
	b=lJBKDl0dpK5YCzD/bZ5BLdB5crg8w8HEECRD6R/065tnCQvO+/T5FHf+Zy5QV1Dsqnsr
	 n59ZEkw04GPEggQ8UJr/QL1VZScdvUaweGr+E7bUNLwNmW/WUaj3UXO5RbgJVd5KHsJhe
	 CniD1UUNbBAYAylwmIWi7rRowAoMGri0F6cRZFT6PE6ohX9uAZtmSK+6NCgLQbqqCXptg
	 scQqUt8Fv/R1L9UEGvsZxbqjn/RziEbkEiMn4koTYyYWqo2RcC/SHQi7kQ10PvCp24YzF
	 gafWqG16/QVLQ4F1Ql2SGhmUodRP/Z1tWi8JOi6AXw9BKZTcTJUaUAcYi77HTSuM+rA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791013979;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=yVcORQ/SI+eD6i2oz/HrJ6jHEXxTk376wKhfDONYQCI=;
	b=fyOIKWeycybm/PcXZrKg878Zgyzz/6SpYb7tWs8WV1ypT+HCjWyY6zvCagRu9VPeYOye
	 BHmKJI68W+0iKruhmZPcy460Nnc5yj3V2fd3PVKgQUSr2Qw5AZd80dkpnBqckIC8OXm52
	 mQjnwlLH3hHDJPVMztErfUh6Ewt6rhvKILgBi0/E4Zx/gHFpOOMGNvNxRFsWMzAry5bjV
	 AYEc4uo9YJ51DuHizQvrLy0GrcrqhPq2gaYiKgLoPuc2AYLywHF6QGNBKH7L0zebx6oP7
	 D3lFjm0r5SmF+FnScChzXb+bjyo3DDwFWzxqAfYm/Y7ZSDqhw1fc+iqYbXkZeqzbKcw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="jDF/V3yi";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B542F800E4
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 09:52:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B542F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jDF/V3yi
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EC2560D8E;
	Sat,  3 Oct 2026 07:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF231F0089C;
	Sat,  3 Oct 2026 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013975;
	bh=SsZuLX1m5zBOGB/eTfR7O04naF7e4Rh6urcz2t1OfiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jDF/V3yiAeZqLJ+4mM5sdB7kaKvqMGPe6A/ImYmXxZOrgRDv8QMiZBdRhZpDltKtx
	 jiVRJ4RszghdYNtE53sc4ScaSg54p3HdXfKyWldFehfLC3IULNt4la9zWSVhee6dgF
	 jG8TlcLPKLHkg8OuKdNMRIq0uuB7WT/1AtZvCX9XktZjAIW72JfOGCMSmq/He36Yjj
	 FQ3NuM4epnWm+pUuH5YRUrG4dpmjwldOC42i01Qz+/E4wg/5vB7JSnC73tNy5STWGN
	 z2xx4WWpDgclVDjQ0Pul9CoXRPLgM8LFpHGdo0k8wgAm8ivd7ftbV99qnP39b/iWVo
	 QoLi16kLuEdHQ==
Date: Sat, 3 Oct 2026 09:52:52 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] soundwire: amd: allocate sdw_amd_ctx pdev array
 dynamically
Message-ID: <asC0VC--CaFMJ_ow@parshuram>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
 <20260917090407.3828816-4-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917090407.3828816-4-Vijendar.Mukunda@amd.com>
Message-ID-Hash: QELIAFPDULUQMAHGWHTPLJDHKQ7REI2M
X-Message-ID-Hash: QELIAFPDULUQMAHGWHTPLJDHKQ7REI2M
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QELIAFPDULUQMAHGWHTPLJDHKQ7REI2M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 17-09-26, 14:32, Vijendar Mukunda wrote:
> Replace the fixed-size pdev[AMD_ACP63_SDW_MAX_MANAGER_COUNT] member of
> struct sdw_amd_ctx with a dynamically allocated pointer array. The array
> is sized by max_manager_count via kcalloc() in sdw_amd_probe_controller()
> and freed on all error paths and in sdw_amd_cleanup().
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_init.c      | 12 ++++++++++++
>  include/linux/soundwire/sdw_amd.h |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
> index 15d117172bdb..94d766b3f8af 100644
> --- a/drivers/soundwire/amd_init.c
> +++ b/drivers/soundwire/amd_init.c
> @@ -62,6 +62,7 @@ static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
>  			continue;
>  		platform_device_unregister(ctx->pdev[i]);
>  	}
> +	kfree(ctx->pdev);
>  
>  	return 0;
>  }
> @@ -116,8 +117,16 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>  
>  	ctx->count = count;
>  	ctx->link_mask = res->link_mask;
> +
> +	ctx->pdev = kcalloc(max_manager_count, sizeof(*ctx->pdev), GFP_KERNEL);

why not use managed api for this?

> +	if (!ctx->pdev) {
> +		kfree(ctx);
> +		return NULL;
> +	}
> +
>  	struct resource *sdw_res __free(kfree) = kzalloc_obj(*sdw_res);
>  	if (!sdw_res) {
> +		kfree(ctx->pdev);
>  		kfree(ctx);
>  		return NULL;
>  	}
> @@ -127,6 +136,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>  
>  	sdw_pdata = kcalloc(max_manager_count, sizeof(*sdw_pdata), GFP_KERNEL);
>  	if (!sdw_pdata) {
> +		kfree(ctx->pdev);
>  		kfree(ctx);
>  		return NULL;
>  	}
> @@ -134,6 +144,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>  	pdevinfo = kcalloc(max_manager_count, sizeof(*pdevinfo), GFP_KERNEL);
>  	if (!pdevinfo) {
>  		kfree(sdw_pdata);
> +		kfree(ctx->pdev);
>  		kfree(ctx);
>  		return NULL;
>  	}
> @@ -171,6 +182,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>  
>  	kfree(pdevinfo);
>  	kfree(sdw_pdata);
> +	kfree(ctx->pdev);
>  	kfree(ctx);
>  	return NULL;
>  }
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index 40ba84c3b2cc..476de2c30389 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -139,7 +139,7 @@ struct sdw_amd_acpi_info {
>  struct sdw_amd_ctx {
>  	int count;
>  	u32 link_mask;
> -	struct platform_device *pdev[AMD_ACP63_SDW_MAX_MANAGER_COUNT];
> +	struct platform_device **pdev;
>  	struct sdw_peripherals *peripherals;
>  };
>  
> -- 
> 2.48.1

-- 
~Vinod
