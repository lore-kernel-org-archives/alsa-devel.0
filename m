From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ASoc: hdmi-codec: remove HDMI device
	unregister
Date: Fri, 03 Feb 2017 11:14:08 +0100
Message-ID: <1486116848.2791.5.camel@pengutronix.de>
References: <1486116634-14930-1-git-send-email-vincent.abriou@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5B7862606F7
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 11:14:12 +0100 (CET)
In-Reply-To: <1486116634-14930-1-git-send-email-vincent.abriou@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vincent Abriou <vincent.abriou@st.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-02-03 at 11:10 +0100, Vincent Abriou wrote:
> While unregistering the hdmi-codec, the hdmi device list must be
> cleaned up. It avoids kernel page fault when registering again the
> hdmi-codec.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
> ---
>  sound/soc/codecs/hdmi-codec.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 90b5948..1ca405e 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -479,6 +479,18 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>  
>  static int hdmi_codec_remove(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;

Seems unnecessary for a single use.

> +	struct list_head *pos;
> +
> +	list_for_each(pos, &hdmi_device_list) {
> +		struct hdmi_device *tmp = pos_to_hdmi_device(pos);
> +
> +		if (tmp->dev == dev->parent) {
> +			list_del(pos);
> +			break;
> +		}
> +	}
> +
>  	snd_soc_unregister_codec(&pdev->dev);

Or, if dev was available, it should be used here, too.

>  	return 0;
>  }

regards
Philipp
