From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 08/13] ASoC: Add SoundWire stream
 programming interface
Date: Sat, 21 Apr 2018 06:59:49 -0700
Message-ID: <79c978d0-0ded-ddcb-5405-18b657c062d7@linux.intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A4302267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 17:02:42 +0200 (CEST)
In-Reply-To: <1524049146-8725-9-git-send-email-vinod.koul@intel.com>
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
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


> +/**
> + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> + * @dai: DAI
> + * @stream: STREAM
> + * @direction: Stream direction(Playback/Capture)
> + * SoundWire subsystem doesn't have a notion of direction and we reuse
> + * the ASoC stream direction to configure sink/source ports.
> + * Playback maps to source on the TX and sink on Rx. Vice-versa for Capture.

this is just confusing...

This should be something like
"use Playback for source ports and Capture for sink ports".
