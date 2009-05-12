From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Tue, 12 May 2009 13:50:26 +0300
Message-ID: <200905121350.26415.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242040465-10835-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090511150320.1e15014b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D6C82103838
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 12:50:49 +0200 (CEST)
In-Reply-To: <20090511150320.1e15014b.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "getarunks@gmail.com" <getarunks@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 11 May 2009 15:03:20 ext Jarkko Nikula wrote:
> On Mon, 11 May 2009 14:14:25 +0300
>
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > This patch fixes the - agressive - 'tuck' sound heard when
> > the codec goes to standby mode.
> >
> > We need to wait for the ramp down completion in case of
> > headsetl_event:POST_PMD.
>
> For my ears this sounds that the power-down pop is now even worse. I'm
> listening with some 32 ohm headphones connected into Beagle.
>
> Before it was kind of sharp snap but now it is snap + low-frequency
> tuck/pop. Positive that this low-frequency pop sounds kind of same than
> the power-up pop so there is now ramp in both events when coupling
> capasitor is charging/discharging.
>
> Do you know is the capacitor coupling configuration correct? TPS65950
> is mentioning it but I don't find it at quick look where to configure it
> for ac-coupled connection.

Jarkko and others: can you test this on top of the my patch?
How does the 'tuck' sounds after this?


diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7847f80..f930fbc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -61,7 +61,7 @@ static int dapm_up_seq[] =3D {

 static int dapm_down_seq[] =3D {
        snd_soc_dapm_pre, snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_s=
pk,
-       snd_soc_dapm_pga, snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_mixer,
+       snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_mixer, snd_soc_dapm_pga,
        snd_soc_dapm_dac, snd_soc_dapm_mic, snd_soc_dapm_micbias,
        snd_soc_dapm_mux, snd_soc_dapm_value_mux, snd_soc_dapm_supply,
        snd_soc_dapm_post

-- =

P=E9ter
