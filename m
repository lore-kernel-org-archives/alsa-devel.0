From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: No need to call
 wm8962_configure_bclk() multiple times
Date: Fri, 19 Jul 2013 14:00:31 +0800
Message-ID: <20130719060030.GA8334@MrMyself>
References: <1374213508-25617-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D3C426522E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 08:18:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1374213508-25617-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Fri, Jul 19, 2013 at 02:58:28AM -0300, Fabio Estevam wrote:
> -
> -		wm8962_configure_bclk(codec);
>  		break;
>  
>  	case SND_SOC_BIAS_STANDBY:
> @@ -2621,8 +2619,6 @@ static int wm8962_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  
>  	wm8962->sysclk_rate = freq;
>  
> -	wm8962_configure_bclk(codec);
> -

Although I know this modification should be okay on i.MX SabreSD,
yet I'm not sure if won't break other usage on other platforms.

And the problem here is because wm8962->bclk and wm8962->lrclk
are updated in hw_params() but be remained after playback's done.
So there might be a least risky way to fix it just by adding this:

+static int wm8962_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+
+	wm8962->lrclk = 0;
+	wm8962->bclk = 0;
+
+	return 0;
+}


Surely If Mark say okay to Fabio's patch, I'll be totally okay
with it too. I just want to this wm8962 driver can work perfectly
on all the platforms.
