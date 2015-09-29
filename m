From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC 3/5] ASoC: codec: hdmi drm codec driver
Date: Tue, 29 Sep 2015 16:53:44 +0300
Message-ID: <560A97E8.4050303@ti.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
 <1442841596-1323-4-git-send-email-arnaud.pouliquen@st.com>
 <56055626.7030908@ti.com> <56056D52.3@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C4C2606AC
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 15:53:51 +0200 (CEST)
In-Reply-To: <56056D52.3@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "airlied@linux.ie" <airlied@linux.ie>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 09/25/15 18:50, Arnaud Pouliquen wrote:
> Hello Jyri,
>
> Yes using or not DRM bridge we should be able to have a common
> implementation
>
> Please find,my answer belows
>
> BR,
> Arnaud
>
> On 09/25/2015 04:11 PM, Jyri Sarha wrote:
>> Despite my earlier comment this implementation and the related HW is
>> quite similar in all significant aspects to the patch set posted couple
>> of days ago [1] for Beaglebone-Black HDMI audio.
>>
>> [1] http://permalink.gmane.org/gmane.linux.alsa.devel/144144
> yes i trying to align my dev on it. to match with your development.
> Aim for me is to reuse it and adapt it using a DRM bridge interface.
> i hope to provide a V2 next week.
>>
>> I have not yet gotten to bottom of drm-side audio bride part, but I am
>> working on it. Bellow is couple of early comments to the ASoC part.
>>
>> Best regards,
>> Jyri
>>
>> On 09/21/15 16:19, Arnaud Pouliquen wrote:
>>> +
>>> +static int st_hdmi_dai_probe(struct snd_soc_dai *dai)
>>> +{
>>> +    struct hdmi_drm_dai_data *priv;
>>> +
>>> +    dev_err(dai->dev, "%s: enter\n", __func__);
>>> +    priv = devm_kzalloc(dai->dev, sizeof(*priv), GFP_KERNEL);
>>> +
>>> +    priv->bridge = of_drm_find_bridge(dai->dev->of_node);
>>> +
>>> +    dev_err(dai->dev, "%s: bridge %p\n", __func__, priv->bridge);
>>> +
>>> +    snd_soc_dai_set_drvdata(dai, priv);
>>> +
>>
>> The call above overwrites the private data pointer of the drivers that
>> registering the codec. This hardly works in general.
>>
>> A separate platform driver - with this already merged patch [2] - that I
>> use with my patch-set solves this issue quite nicely.
>>
>> [2] http://lists.freedesktop.org/archives/dri-devel/2015-May/083517.html
> Yes same dev,(but no crash...?).i need to define sub node.
>>> +    return 0;
>>> +}here are several important callbacks missing here
>>> +
>>> +static const struct snd_soc_dai_ops hdmi_drm_codec_ops = {
>>> +        .prepare =  hdmi_drm_dai_prepare,
>>> +        .trigger = hdmi_drm_dai_trigger,
>>> +};
>>
>>
>> At least set_daifmt() and hw_params() callbacks should be defined before
>> this could be generally usable. HDMI encoders do not usually support too
>> many daifmts, but the driver should be able the check that the selected
>> format is supported. But as you said this not complete code yet.
> I'm trying to match codec ops with following DRM audio bridge ops,
> that is similar to the existing drm_bridge_funcs structure.

I am not yet too familiar with drm way of doing things. My code is 
trying to follow the way how ALSA does things. I tried to survive with 
as few callback as possible, but if you think more is needed I can add 
those if there is a corresponding callback in ALSA.

> struct drm_audio_bridge_funcs {
>      void (*disable)(struct drm_bridge *bridge);

There is no such thing in my HDMI codec. However, there is digital_mute 
callback that is used by alsa before the streams are shut down to avoid 
undesired pops and clicks.

>      void (*post_disable)(struct drm_bridge *bridge);

Post_disable should map more or less directly to audio_shutdown() in my 
code.

>      void (*pre_enable)(struct drm_bridge *bridge);

audio_startup() and hw_params() should both be called at pre_enable() 
phase.

>      void (*enable)(struct drm_bridge *bridge);

... or one could see hw_params() to map to enable. And there is 
digital_mute which is toggled by ALSA at this phase.

>      int  (*mode_set)(struct drm_bridge *bridge,
>              struct hdmi_audio_mode *mode);

Actually hw_params() does pretty much the same thing as set_mode(), but 
it should be called after audio_startup() has been called.

>      uint8_t *(*mode_get)(struct drm_bridge *bridge); /*return eld*/
> };

For this there is get_eld() in my HDMI codec code.

> audio parameters should be part of struct hdmi_audio_mode that contains
> audio configurations ( info frame,iec, format, clk...)
>
>

BTW, the HDMI codec is made in such a way that one can get by with only 
hw_params() and audio_shutdown(). In such an implementation hw_params() 
sets the HDMI encoder ready for receiving i2s or spdif from CPU DAI and 
audio_shutdown() disables the audio stream.

Best regards,
Jyri
