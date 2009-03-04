From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 6/9] S3C64XX: Add s3c64xx-i2s support
Date: Wed, 4 Mar 2009 19:56:27 +0000
Message-ID: <20090304195626.GC7680@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005139.012781244@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 661F9103880
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 20:56:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005139.012781244@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:31AM +0000, Ben Dooks wrote:
> From: Ben Dooks <ben@simtec.co.uk>

> Add the initial code to support the S3C64XX I2S hardware using the
> s3c-i2s-v2 core code.

> Signed-off-by: Ben Dooks <ben@simtec.co.uk>

I'll apply this, just one little comment for future reference:

> +#define S3C64XX_I2S_RATES \
> +	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
> +	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

Could do SNDDRV_PCM_RATE_8000_96000 here.
