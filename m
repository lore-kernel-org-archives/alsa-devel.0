From: Cezary Rojewski <cezary.rojewski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
Date: Tue, 9 Jul 2019 13:47:10 +0200
Message-ID: <3d5755cf-34e9-44f7-3b03-6bdfca84ff95@intel.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190705042623.129541-2-cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cheng-Yi Chiang <cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, tzungbi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2019-07-05 06:26, Cheng-Yi Chiang wrote:
> +static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> +				   unsigned int jack_status)
> +{
> +	if (!hcp->jack)
> +		return;
> +
> +	if (jack_status != hcp->jack_status) {
> +		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
> +		hcp->jack_status = jack_status;
> +	}
> +}

Single "if" statement instead? The first "if" does not even cover all 
cases - if the secondary check fails, you'll "return;" too.

> +/**
> + * hdmi_codec_set_jack_detect - register HDMI plugged callback
> + * @component: the hdmi-codec instance
> + * @jack: ASoC jack to report (dis)connection events on
> + */
> +int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> +			       struct snd_soc_jack *jack)
> +{
> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	if (hcp->hcd.ops->hook_plugged_cb) {
> +		hcp->jack = jack;
> +		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
> +						    hcp->hcd.data,
> +						    plugged_cb);
> +		if (ret) {
> +			hcp->jack = NULL;
> +			return ret;
> +		}
> +		return 0;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);

int ret = -EOPNOTSUPP;
(...)

return ret;

In consequence, you can reduce the number of "return(s)" and also remove 
the redundant parenthesis for the if-statement used to set jack to NULL.

Czarek
