From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 3/5] ASoC: codec: hdmi drm codec driver
Date: Fri, 25 Sep 2015 17:50:42 +0200
Message-ID: <56056D52.3@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
 <1442841596-1323-4-git-send-email-arnaud.pouliquen@st.com>
 <56055626.7030908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 9ADBF26065A
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 17:50:54 +0200 (CEST)
In-Reply-To: <56055626.7030908@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "airlied@linux.ie" <airlied@linux.ie>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hello Jyri,

Yes using or not DRM bridge we should be able to have a common 
implementation

Please find,my answer belows

BR,
Arnaud

On 09/25/2015 04:11 PM, Jyri Sarha wrote:
> Despite my earlier comment this implementation and the related HW is
> quite similar in all significant aspects to the patch set posted couple
> of days ago [1] for Beaglebone-Black HDMI audio.
>
> [1] http://permalink.gmane.org/gmane.linux.alsa.devel/144144
yes i trying to align my dev on it. to match with your development.
Aim for me is to reuse it and adapt it using a DRM bridge interface.
i hope to provide a V2 next week.
>
> I have not yet gotten to bottom of drm-side audio bride part, but I am
> working on it. Bellow is couple of early comments to the ASoC part.
>
> Best regards,
> Jyri
>
> On 09/21/15 16:19, Arnaud Pouliquen wrote:
>> +
>> +static int st_hdmi_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +	struct hdmi_drm_dai_data *priv;
>> +
>> +	dev_err(dai->dev, "%s: enter\n", __func__);
>> +	priv = devm_kzalloc(dai->dev, sizeof(*priv), GFP_KERNEL);
>> +
>> +	priv->bridge = of_drm_find_bridge(dai->dev->of_node);
>> +
>> +	dev_err(dai->dev, "%s: bridge %p\n", __func__, priv->bridge);
>> +
>> +	snd_soc_dai_set_drvdata(dai, priv);
>> +
>
> The call above overwrites the private data pointer of the drivers that
> registering the codec. This hardly works in general.
>
> A separate platform driver - with this already merged patch [2] - that I
> use with my patch-set solves this issue quite nicely.
>
> [2] http://lists.freedesktop.org/archives/dri-devel/2015-May/083517.html
Yes same dev,(but no crash...?).i need to define sub node.
>> +	return 0;
>> +}here are several important callbacks missing here
>> +
>> +static const struct snd_soc_dai_ops hdmi_drm_codec_ops = {
>> +		.prepare =  hdmi_drm_dai_prepare,
>> +		.trigger = hdmi_drm_dai_trigger,
>> +};
>
>
> At least set_daifmt() and hw_params() callbacks should be defined before
> this could be generally usable. HDMI encoders do not usually support too
> many daifmts, but the driver should be able the check that the selected
> format is supported. But as you said this not complete code yet.
I'm trying to match codec ops with following DRM audio bridge ops,
that is similar to the existing drm_bridge_funcs structure.
struct drm_audio_bridge_funcs {
	void (*disable)(struct drm_bridge *bridge);
	void (*post_disable)(struct drm_bridge *bridge);
	void (*pre_enable)(struct drm_bridge *bridge);
	void (*enable)(struct drm_bridge *bridge);
	int  (*mode_set)(struct drm_bridge *bridge,
			struct hdmi_audio_mode *mode);
	uint8_t *(*mode_get)(struct drm_bridge *bridge); /*return eld*/
};
audio parameters should be part of struct hdmi_audio_mode that contains 
audio configurations ( info frame,iec, format, clk...)
