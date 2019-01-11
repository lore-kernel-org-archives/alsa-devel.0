From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/5] ALSA: hda: Add api to program
 stripe control bits
Date: Fri, 11 Jan 2019 11:55:41 -0600
Message-ID: <13164ff6-1ea0-9e28-b3b2-a590949a7200@linux.intel.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
 <1547227328-32558-3-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F6C267979
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 18:55:44 +0100 (CET)
In-Reply-To: <1547227328-32558-3-git-send-email-spujar@nvidia.com>
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
To: Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> +
> +	/* following is from HD audio spec */
> +	for (sdo_line = max_sdo_lines; sdo_line > 0; sdo_line >>= 1) {
> +		if (rate > 48000)
> +			value = (channels * bits_per_sample *
> +					(rate / 48000)) / sdo_line;
> +		else
> +			value = channels * bits_per_sample / sdo_line;
(channels * bit_per_sample) / sdo_line as in the spec?
