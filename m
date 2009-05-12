From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
 headsetl_event: POST_PMD
Date: Tue, 12 May 2009 14:19:37 +0300
Message-ID: <20090512141937.08450516.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242040465-10835-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090511150320.1e15014b.jhnikula@gmail.com>
	<200905121350.26415.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 26039103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 13:17:59 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so2661783ana.2
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 04:17:59 -0700 (PDT)
In-Reply-To: <200905121350.26415.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009 13:50:26 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Jarkko and others: can you test this on top of the my patch?
> How does the 'tuck' sounds after this?
> =

Do difference IMO. I just noted that I'm able to get both
power-up/-down pops from both channels by toggling the control
"HeadsetL Mixer AudioL2" or "HeadsetL Mixer Voice" but only if "HeadsetL
Mixer AudioL1" is muted. But no pop from HeaderR controls.


-- =

Jarkko

> =

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 7847f80..f930fbc 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -61,7 +61,7 @@ static int dapm_up_seq[] =3D {
> =

>  static int dapm_down_seq[] =3D {
>         snd_soc_dapm_pre, snd_soc_dapm_adc, snd_soc_dapm_hp,
> snd_soc_dapm_spk,
> -       snd_soc_dapm_pga, snd_soc_dapm_mixer_named_ctl,
> snd_soc_dapm_mixer,
> +       snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_mixer,
> snd_soc_dapm_pga, snd_soc_dapm_dac, snd_soc_dapm_mic,
> snd_soc_dapm_micbias, snd_soc_dapm_mux, snd_soc_dapm_value_mux,
> snd_soc_dapm_supply, snd_soc_dapm_post
> =

> -- =

> P=E9ter
