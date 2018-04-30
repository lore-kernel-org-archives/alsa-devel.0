From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [alsa-devel] [PATCH RFC] ASoC: dai playback_active and
 capture_active may be greater than 1
Date: Mon, 30 Apr 2018 16:10:04 +0100
Message-ID: <20180430151004.edal7xei4okf7hao@localhost.localdomain>
References: <20180419140612.11049-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419140612.11049-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 04:06:12PM +0200, Jerome Brunet wrote:
> At the moment playback_active and capture_active are using only 1 bit so
> the maximum active count is 1.
> 
> However, snd_soc_runtime_activate() may be called several time on the
> same dai. This happens when a dai is part of several dai_links. It is
> often the case for "snd-soc-dummy-dai".
> 
> This is a problem if snd_soc_runtime_activate() is called an even number
> of times on a dai. In this case the active count overflow back to 0. As
> consequence, ASoC functions, such as soc_dpcm_runtime_update(), won't run
> correctly.
> 
> Storing these usage counts on plain 'unsigned int' solves the problem.
> 
> Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
