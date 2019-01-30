From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2][RFC] ASoC: soc-core: allow no Platform
 on dai_link
Date: Wed, 30 Jan 2019 09:11:48 -0600
Message-ID: <e984c300-5732-17ca-212b-3954cbdf3765@linux.intel.com>
References: <8736paoqr5.wl-kuninori.morimoto.gx@renesas.com>
 <87zhrinc2y.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 0263B267439
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 16:11:50 +0100 (CET)
In-Reply-To: <87zhrinc2y.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> If sound card dirver is using "modern style", both codec/platform
> are using it. So this patch judges it as "modern style" if
> there is no settings for
> 	codec_name
> 	codec_of_node
> 	codec_dai_name
> 	platform_name
> 	platform_of_node

Doesn't this prevent a gradual dailink transition where e.g. the 
platform_name is removed first and then the codec_name/codec_dai_name is 
removed second?

I started doing the transition in steps changing all dailinks with 
platform and codec/codec_dai names at once is quite invasive and 
possibly error prone. Specifically for Intel machine drivers, the codec 
names are heavily tweaked to align with the actual ACPI name, not the 
hard-coded one, and that should be tested independently if possible. 
Same for codec_dai_names, they depend on quirks.

-Pierre
