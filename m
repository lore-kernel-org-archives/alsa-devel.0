From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ASoC: Blackfin: DMA Driver for AC97
	sound chip
Date: Thu, 4 Sep 2008 13:37:41 +0100
Message-ID: <20080904123741.GA13735@rakim.wolfsonmicro.main>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 560DE243ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 14:37:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220516528-20301-5-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 04, 2008 at 04:22:03PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

A couple of coding standards nits below but please fix these as an
incremental patch to save on reviewing.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		curr = sport_curr_offset_tx(sport) / sizeof(struct ac97_frame);
> +	else {
> +		curr = sport_curr_offset_rx(sport) / sizeof(struct ac97_frame);
> +
> +	}

Don't need the { }.

> +	ret = snd_pcm_hw_constraint_integer(runtime, \
> +			SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		goto out;

No need for the line continuation here.
