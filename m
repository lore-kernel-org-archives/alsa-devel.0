From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 11/11] ASoC: SOF: Add Build support for SOF
 core
Date: Fri, 20 Jul 2018 09:11:08 -0500
Message-ID: <c64ef565-2e65-6e7d-7fdb-a4cd102149f2@linux.intel.com>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180719185335.30912-11-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F136267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 16:11:27 +0200 (CEST)
In-Reply-To: <20180719185335.30912-11-liam.r.girdwood@linux.intel.com>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

I doubled-checked the series and this is the only (minor) miss I could 
find. Maybe a doubt on the control sizes in patch 2.


> +config SND_SOC_SOF
> +	tristate "Sound Open Firmware Support"
> +	default m

we removed the default recently in topic/sof-dev, probably a miss while 
squashing the code and making it pretty.

> +	select SND_SOC_TOPOLOGY
> +	select SND_SOC_COMPRESS
> +	help
> +          This adds support for Sound Open Firmware (SOF). SOF is a free and
> +	  generic open source audio DSP firmware for multiple devices.
> +          Say Y if you have such a device that is supported by SOF.

Y or m?
