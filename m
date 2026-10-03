Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CBACA5FDD
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2026 07:57:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61FF0602A8;
	Sat,  3 Oct 2026 09:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61FF0602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791014234;
	bh=MfUVCVTVyqAyWWMciWYVlMIITc7gEW1gx50qars9mvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eMuskjvbeAwDWBNd9uGqBHeHzUxirEHUKeFWPASMalL8bBUCmTR1mhw8oH9efYK/x
	 F6R9aDCluHKo/dzxHyiH4+7MgF0B4LT5x209c4KLND6JMVbK0OfdCEYTSUeP9U7qk4
	 60A4HZXf3ERAgNUPWHOygvGY25tLBqACQg7WNxCM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 536E8F805FE; Sat,  3 Oct 2026 09:56:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B750F805EF;
	Sat,  3 Oct 2026 09:56:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E95D3F80548; Sat,  3 Oct 2026 09:56:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791014192;
	b=k5yQaPilCcBotH0AnecdenHrhUeKxu3avSlJqJJz3CajwYH3rgwViDvXVck09si9cWtZ
	 Uo8b0Ht/Wiud4NhqVAZmQ+gfmJvVFbetv/zan8Dfq4ia1UxEyUJTJjVtQ2tCQXdwmca+D
	 arjOn+qtoqLGlN8fGoOfsP2HOj5xw7eTJ/1Q6oesDoKUs/NSbx2OCAXua75hMVUS2g4QK
	 Nr4cu4dFjjIEAUFTulEXftY0f3hEjUnuRz2AMAzKujWKiFg8QLherBL2dJ1fUS0TVt2YX
	 QYPvtXYpWNHCr6x17xhrLINdSTQdcdE7rNPnX1U+BHVn4tfGpSJb6YaN3XmV9JlLiLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791014192;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=MfUVCVTVyqAyWWMciWYVlMIITc7gEW1gx50qars9mvI=;
	b=c+c2uD7DMNCW8VEwwL08N92jJf+OMhr9Y7baLVMSPr6iNRLc6GuAt83DWFVKw7cVzQ3n
	 A+2yih0Rw795ZWJG2gJucFD+O9uslLIqBDCtA8tnAtQN1vCP/zVLOU5QYhKoa83d8gG7K
	 sMOXcjI6mf6RCs1BgmuQN1Nc30+9D9QV+7Q7ZWQjVUF1KkLqIpiXgFghqavWc94eop5He
	 I3zxhOa9bPHsR5bzvrPemi5ULm3YlTBw9tOkRLKy8KlREE67X6xji3HEhQdVGA71N/PSw
	 dKYxYQLLxgGOa3i4FFytKg5VUCidEvD7yWBgYCl9YMhGlzO3bXnVY4slxB+9CzWpz7g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RSDO3b1W;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A15D0F80246
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 09:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A15D0F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RSDO3b1W
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4471641A22;
	Sat,  3 Oct 2026 07:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED021F0089B;
	Sat,  3 Oct 2026 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014186;
	bh=ekxDdhOJckVynJQYk+c3362Q9E9XNDxkI9BNBdgVOuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSDO3b1WehYIXguH/T1Bm0GIc6mzcRHjxW14VlSyV2rxXtE1ZdOq8SsKYci4PFmL0
	 76WiiuBQG4qcUYbnUOQh/kK/MxYxqfr2Lg/Q3L7cR11yHa43dSACvA7teGaQ9QzCQC
	 Ff77V2i99iHR3RTLBx7MnIqP0JaALXEetFnEBwdlptjrCaBU2JJm6Q5OxLuyFQpNZ1
	 t0BtN8zgplfOY3QY2puCn0FYFGVcwmMcsiDHYivxGELqkWIYYfE8MN0I/oIu0pKyeu
	 0XdAEr26yJiuNhvAl2g4upxHLfLYaZlupScDphpMfkiDhTtqpVEJCJC9uzkQqOL33S
	 zboeJwCuYnqFA==
Date: Sat, 3 Oct 2026 09:56:23 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] soundwire: amd: introduce struct amd_sdw_hw_ops
 dispatch framework
Message-ID: <asC1JwByZaJ8B2Pr@parshuram>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
 <20260917090407.3828816-7-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917090407.3828816-7-Vijendar.Mukunda@amd.com>
Message-ID-Hash: WQAUE2PKURYQYXSSGLQBPWONR3N56IW3
X-Message-ID-Hash: WQAUE2PKURYQYXSSGLQBPWONR3N56IW3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQAUE2PKURYQYXSSGLQBPWONR3N56IW3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 17-09-26, 14:32, Vijendar Mukunda wrote:
> Add struct amd_sdw_hw_ops, a function-pointer dispatch table for
> hardware-revision-specific SoundWire manager operations. Add inline
> dispatch helpers for each callback and a const hw_ops pointer in
> struct amd_sdw_manager.
> 
> The irq_thread and update_slave_status_work slots take
> struct amd_sdw_manager * so that different ACP revisions can register
> different handler logic. hw_ops is populated and call sites are wired
> through the dispatch helpers in subsequent patches.

Lets solve with one more level! Do you really need this...

> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_manager.h   | 193 ++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw_amd.h |   4 +
>  2 files changed, 197 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 63fecff62079..2d08c6edd018 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -274,4 +274,197 @@ static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
>  		AMD_SDW0_EXT_INTR_MASK,
>  		AMD_SDW1_EXT_INTR_MASK
>  };
> +
> +#define AMD_SDW_HW_OPS(amd_manager, cb)	((amd_manager)->hw_ops->cb)
> +
> +/**
> + * struct amd_sdw_hw_ops - hardware-revision-specific SoundWire manager ops
> + *
> + * @init_sdw_manager: enable the SoundWire manager hardware and perform bus reset
> + * @enable_sdw_manager: set the manager enable bit and wait for it to assert
> + * @disable_sdw_manager: clear the manager enable bit and wait for it to deassert
> + * @enable_sdw_interrupts: unmask ACP-level and per-manager interrupt bits
> + * @disable_sdw_interrupts: mask ACP-level and per-manager interrupt bits
> + * @set_frameshape: write the row/column frame-shape register
> + * @send_cmd_get_resp: issue an immediate command and return the response;
> + *   returns 0 on success with the raw u64 response in @response,
> + *   or negative on hardware timeout
> + * @wake_enable: enable or disable the in-band SoundWire wake interrupt
> + * @host_wake_enable: enable or disable the host-side wake interrupt
> + * @set_device_state: write the D0/D3 device power state for the manager instance
> + * @read_and_process_ping_status: issue a PING command and process the slave
> + *   attach/detach status; called from the IRQ work path
> + * @process_wake_event: handle an in-band wake notification from a slave
> + * @irq_thread: hw_ops callback invoked by the thin work_struct wrapper on
> + *   each interrupt; reads status registers and dispatches slave events
> + * @update_slave_status_work: hw_ops callback invoked by the status-update
> + *   work item; reads slave status and updates the SoundWire core
> + * @clk_init_ctrl: set the clock divider and update the frame shape registers
> + *   based on the current bus clock frequency
> + * @clock_stop_exit: restart the SoundWire bus clock after a CLK_STOP_MODE
> + *   suspend; implementation differs across ACP revisions
> + * @suspend: system-suspend hook; stops the bus and powers down the manager
> + * @suspend_runtime: runtime-suspend hook; same sequence as @suspend
> + * @resume_runtime: runtime-resume hook; reinitialises the manager and restarts
> + *   the bus after a POWER_OFF_MODE or CLK_STOP_MODE suspend
> + */
> +struct amd_sdw_hw_ops {
> +	int (*init_sdw_manager)(struct amd_sdw_manager *amd_manager);
> +	int (*enable_sdw_manager)(struct amd_sdw_manager *amd_manager);
> +	int (*disable_sdw_manager)(struct amd_sdw_manager *amd_manager);
> +	void (*enable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
> +	void (*disable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
> +	void (*set_frameshape)(struct amd_sdw_manager *amd_manager);
> +	int (*send_cmd_get_resp)(struct amd_sdw_manager *amd_manager, u32 lower_data,
> +				 u32 upper_data, u64 *response);
> +	void (*wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
> +	int (*host_wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
> +	int (*set_device_state)(struct amd_sdw_manager *amd_manager, u32 target_device_state);
> +	void (*read_and_process_ping_status)(struct amd_sdw_manager *amd_manager);
> +	void (*process_wake_event)(struct amd_sdw_manager *amd_manager);
> +	void (*irq_thread)(struct amd_sdw_manager *amd_manager);
> +	void (*update_slave_status_work)(struct amd_sdw_manager *amd_manager);
> +	int (*clk_init_ctrl)(struct amd_sdw_manager *amd_manager);
> +	int (*clock_stop_exit)(struct amd_sdw_manager *amd_manager);
> +	int (*suspend)(struct amd_sdw_manager *amd_manager);
> +	int (*suspend_runtime)(struct amd_sdw_manager *amd_manager);
> +	int (*resume_runtime)(struct amd_sdw_manager *amd_manager);

I would suggest splitting the driver and add common code to a lib and
have specific drivers for older and new gen platforms...

-- 
~Vinod
