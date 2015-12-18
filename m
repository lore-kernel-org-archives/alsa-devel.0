From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 2/4] ASoC: sun4i-codec: Add support
 for PA gpio pin
Date: Fri, 18 Dec 2015 21:53:41 +0100
Message-ID: <20151218205341.GO30359@lukather>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
 <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
 <20151214155616.GL19456@lukather>
 <566EE953.3050702@redhat.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBVXE2GZQKGQECNKLG4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <566EE953.3050702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Dec 14, 2015 at 05:07:47PM +0100, Hans de Goede wrote:
> >>+static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
> >>+				 struct snd_kcontrol *k, int event)
> >>+{
> >>+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
> >>+
> >>+	if (scodec->gpio_pa)
> >>+		gpiod_set_value_cansleep(scodec->gpio_pa,
> >>+					 !!SND_SOC_DAPM_EVENT_ON(event));
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
> >>+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
> >>+};
> >>+
> >>+static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
> >>+	{ "Speaker", NULL, "Power Amplifier" },
> >>+};
> >
> >Shouldn't it be tied to the HP outputs instead?
> 
> You're right, the HP outputs are the final outputs, and since this is
> for enabling an external amplifier you're right. Since Mark has already
> merged this patch I will do a follow up patch to fix this.

Great, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--3snK74p7ddXn3Qrx--
