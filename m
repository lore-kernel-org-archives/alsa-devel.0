From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 02/13] soundwire: Add support for
 SoundWire stream management
Date: Wed, 25 Apr 2018 18:46:25 -0500
Message-ID: <7cab8022-0883-1140-896f-79655c483295@linux.intel.com>
References: <1524649163-12088-1-git-send-email-vkoul@kernel.org>
 <1524649163-12088-3-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B66B267766
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 01:46:30 +0200 (CEST)
In-Reply-To: <1524649163-12088-3-git-send-email-vkoul@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


> +/**
> + * sdw_stream_state: Stream states
> + *
> + * @SDW_STREAM_RELEASED: Stream released
nit-pick: this should go last (not blocker, can be done in follow-up patch).
> + * @SDW_STREAM_ALLOCATED: New stream allocated.
> + * @SDW_STREAM_CONFIGURED: Stream configured
> + * @SDW_STREAM_PREPARED: Stream prepared
> + * @SDW_STREAM_ENABLED: Stream enabled
> + * @SDW_STREAM_DISABLED: Stream disabled
> + * @SDW_STREAM_DEPREPARED: Stream de-prepared
> + */
> +enum sdw_stream_state {
> +	SDW_STREAM_ALLOCATED = 0,
> +	SDW_STREAM_CONFIGURED = 1,
> +	SDW_STREAM_PREPARED = 2,
> +	SDW_STREAM_ENABLED = 3,
> +	SDW_STREAM_DISABLED = 4,
> +	SDW_STREAM_DEPREPARED = 5,
> +	SDW_STREAM_RELEASED = 6,
