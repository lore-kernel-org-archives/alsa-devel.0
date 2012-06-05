From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/4] omap-abe-twl6040: Device tree
	support
Date: Tue, 05 Jun 2012 15:46:26 +0300
Message-ID: <4FCDFFA2.3060205@ti.com>
References: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog137.obsmtp.com (na3sys009aog137.obsmtp.com
	[74.125.149.18]) by alsa0.perex.cz (Postfix) with ESMTP id 816EC24642
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 14:46:33 +0200 (CEST)
Received: by lbbgg6 with SMTP id gg6so4681440lbb.36
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 05:46:30 -0700 (PDT)
In-Reply-To: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam,

On 05/16/2012 02:57 PM, Peter Ujfalusi wrote:

> Hello,
> =

> Changes since v1:
> - Binding docukentation updated with available pins and connectors
> - dts section for abe-twl6040 sound configuration has been changed


Can you take a look at patch 4 in this series?
The rest of the series has been already applied for 3.5 but the 4th one has
been missed.

Thank you,
P=E9ter

> =

> Instead of dai link pairs only the nodes probed via DT have phandle:
> ti,mcpdm; ti,dmic, ti,twl6040.
> The driver in turn is responsible to handle the provided information.
> To provide dai link pairs (cpu dai - codec) we would need Linux (ASoC) sp=
ecific
> nodes in DT for the dmic codec and twl6040 ASoC codec driver.
> =

> If the DT section have ti,dmic phandle the ASoC machine driver will regis=
ter the
> device to load the ASoC dmic-codec runtime.
> =

> Example dts section for audio support (SDP4430):
> sound {
> 	compatible =3D "ti,abe-twl6040";
> 	ti,model =3D "SDP4430";
> =

> 	ti,jack-detection =3D <1>;
> 	ti,mclk-freq =3D <38400000>;
> =

> 	ti,mcpdm =3D <&mcpdm>;
> 	ti,dmic =3D <&dmic>;
> =

> 	ti,twl6040 =3D <&twl6040>;
> =

> 	/* Audio routing */
> 	ti,audio-routing =3D
> 		"Headset Stereophone", "HSOL",
> 		"Headset Stereophone", "HSOR",
> 		"Earphone Spk", "EP",
> 		"Ext Spk", "HFL",
> 		"Ext Spk", "HFR",
> 		"Line Out", "AUXL",
> 		"Line Out", "AUXR",
> 		"Vibrator", "VIBRAL",
> 		"Vibrator", "VIBRAR",
> 		"HSMIC", "Headset Mic",
> 		"Headset Mic", "Headset Mic Bias",
> 		"MAINMIC", "Main Handset Mic",
> 		"Main Handset Mic", "Main Mic Bias",
> 		"SUBMIC", "Sub Handset Mic",
> 		"Sub Handset Mic", "Main Mic Bias",
> 		"AFML", "Line In",
> 		"AFMR", "Line In",
> 		"DMic", "Digital Mic",
> 		"Digital Mic", "Digital Mic1 Bias";
> };
> =

> =

> Regards,
> Peter
> ---
> Peter Ujfalusi (4):
>   ASoC: omap-abe-twl6040: Keep only one snd_soc_dai_link structure
>   ASoC: omap-abe-twl6040: Move Digital Mic widget into dapm table
>   ASoC: omap-abe-twl6040: Introduce driver data for runtime parameters
>   ASoC: omap-abe-twl6040: Add device tree support
> =

>  .../devicetree/bindings/sound/omap-abe-twl6040.txt |   91 +++++++++
>  sound/soc/omap/omap-abe-twl6040.c                  |  195 ++++++++++++++=
------
>  2 files changed, 230 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl6=
040.txt
> =
