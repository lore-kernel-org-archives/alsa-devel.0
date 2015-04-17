From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 7/7] ASoC: hda - added Skylake I2S
 machine driver
Date: Fri, 17 Apr 2015 11:44:50 +0200
Message-ID: <5530D612.4000109@metafoo.de>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-063.synserver.de (smtp-out-063.synserver.de
 [212.40.185.63])
 by alsa0.perex.cz (Postfix) with ESMTP id BD91826053E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:44:48 +0200 (CEST)
In-Reply-To: <1429262000-21517-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Omair M Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2015 11:13 AM, Vinod Koul wrote:
[...]
> +	/* always connected - check HP for jack detect */
> +	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> +	snd_soc_dapm_enable_pin(dapm, "Speaker");
> +	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> +	snd_soc_dapm_enable_pin(dapm, "DMIC2");

There is no need to do this, all pins are enabled by default.
