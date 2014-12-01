From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 3/9] ASOC: wm8971: modify the control of
	deemphasis
Date: Mon, 1 Dec 2014 10:04:59 +0000
Message-ID: <20141201100459.GA18129@opensource.wolfsonmicro.com>
References: <1417416721-17271-1-git-send-email-xavier.hsu@linaro.org>
 <1417416721-17271-3-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C62D26007E
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 11:05:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1417416721-17271-3-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lars@metafoo.de, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 01, 2014 at 02:51:55PM +0800, Xavier Hsu wrote:
> We add a switch for automatic updating
> the frequency of wm8971.
> 
> Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  sound/soc/codecs/wm8971.c |   75 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 sound/soc/codecs/wm8971.c
> 
> diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> old mode 100644
> new mode 100755
> index 60c90c6..b5cb636
> --- a/sound/soc/codecs/wm8971.c
> +++ b/sound/soc/codecs/wm8971.c
> @@ -40,6 +40,11 @@ static struct workqueue_struct *wm8971_workq;
>  /* codec private data */
>  struct wm8971_priv {
>  	unsigned int sysclk;
> +
> +	/* De-emphasis */
> +	struct mutex deemph_mutex;
> +	int playback_fs;
> +	bool deemph;
>  };
>  
>  /*
> @@ -104,7 +109,6 @@ static const char const *wm8971_alc_func[] = {"Off", "Right",
>  					      "Left", "Stereo"};
>  static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
>  					     "Mute ADC Output"};
> -static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz"};
>  static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
>  					      "Mono (Right)", "Digital Mono"};
>  static const char const *wm8971_dac_phase[] = {"Non Inverted", "Inverted"};
> @@ -118,6 +122,66 @@ static const char const *wm8971_rpga_sel[] = {"Line", "Mic", "NC",
>  					      "Differential"};
>  static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
>  					    "R Invert", "L + R Invert"};
> +static const char const *wm8971_deemp[] = {"None", "32kHz",
> +					   "44.1kHz", "48kHz"};

This is the same as the original version of the array that you've deleted.
I'm guess from the code below that you intended to change this to an
array of integers, messed up, and didn't bother to test that your patch
compiled before posting it up here.

> +
> +static int wm8971_set_deemph(struct snd_soc_codec *codec)
> +{
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +	int val = 0, i, best = 0;
> +
> +	/* If we're using deemphasis select the nearest available sample
> +	 * rate.
> +	*/
> +	if (wm8971->deemph) {
> +		best = 1;
> +		for (i = 2; i < ARRAY_SIZE(wm8971_deemp); i++) {
> +			if (abs(wm8971_deemp[i] - wm8971->playback_fs) <
> +			    abs(wm8971_deemp[best] - wm8971->playback_fs))

wm8971_deemp[i] is a string and then you try to subtract a value from it.
I wouldn't expect that to even compile (at least not without warnings), and
if it does compile I can't imagine what the result would be and I doubt it
is what you wanted.
I'm not even sure what you were trying to do here.

> +				best = i;
> +		}
> +		val = best << 1;
> +	}
> +
> +	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
> +		best, wm8971_deemp[best]);
> +

wm_8971_deemp[best] is a string
