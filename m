From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SMDK64XX I2S: Added machine driver for
 WM8580
Date: Sat, 19 Sep 2009 17:08:56 +0100
Message-ID: <20090919160855.GA4858@sirena.org.uk>
References: <1253321166-10463-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 826E11037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Sep 2009 18:09:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253321166-10463-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben@trinity.fluff.org, Jassi <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 19, 2009 at 09:46:06AM +0900, jassi brar wrote:
> New machine driver for WM8580 I2S i/f on SMDK64XX.
> By default SoC-Slave is set and WM8580 is configured to use it's
> PLLA to generate clocks from a 12MHz crystal attached to WM8580.

> Signed-off-by: Jassi <jassi.brar@samsung.com>

I've applied this with a couple of additional fixups below.  I've added
a dependency on BROKEN since the IISv4 support is not yet present so
there's no chance of it working yet.

> +
> +#define S3C64XX_I2S_V4 2

This should be defined by the DAI driver, every user is going to need
it.

> +static int smdk64xx_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +
> +	/* disable the PLL */
> +	return snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0, 0);
> +}

Doing this will break simultaneous playback and record - whichever of
them stops first will stop the PLL, removing the clock from the other.
I've removed the hw_free() function as a result.

I also note that you're not submitting and testing against the latest
ASoC code since the PLL API has been updated so that this won't build.
I've fixed it up this time but please do try to ensure you're working
with the latest code when submitting patches.
