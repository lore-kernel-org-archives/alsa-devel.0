From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: DAPM: Allow multiple mixer
 sources to be routed via the same switch
Date: Fri, 12 Aug 2011 10:22:01 +0900
Message-ID: <1313112121.19990.33.camel@finisterre.wolfsonmicro.main>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	 <20110811093140.GB18454@opensource.wolfsonmicro.com>
	 <4E43A808.4050105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E43A808.4050105@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-08-11 at 11:59 +0200, Lars-Peter Clausen wrote:


> The dapm_is_shared_control() stuff is about sharing kcontrols between multiple
> muxes. This is about sharing the same kcontrol between multiple paths of the
> same mixer.

> i.e

> { "Mono Mixer", "DAC", "Left DAC" },
> { "Mono Mixer", "DAC", "Right DAC" },

> doesn't work without this patch.

OK, makes sense.
