From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
	amplifier
Date: Tue, 30 Jul 2019 13:27:48 +0100
Message-ID: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BD4FF800BF
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 14:27:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-2-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Marco Felsch <m.felsch@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Nate Case <ncase@tesla.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Rob Duncan <rduncan@tesla.com>, Patrick Glaser <pglaser@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
> new file mode 100644
> index 000000000000..f80aaf4f1ba0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
> @@ -0,0 +1,26 @@
> +ST TDA7802 audio processor
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "st,tda7802"
> +- reg : the I2C address of the device
> +- enable-supply : a regulator spec for the PLLen pin
> +
> +Optional properties:
> +
> +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
> +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)

I wouldn't have expected the gains to be available as a device
tree setting.

> +- st,diagnostic-mode-ch13 : diagnotic mode for channels 1 and 3
> +                            values: "Speaker" (default), "Booster"
> +- st,diagnostic-mode-ch24 : diagnotic mode for channels 2 and 4
> +                            values: "Speaker" (default), "Booster"
> +
> +Example:
> +
> +amp: tda7802@6c {
> +	compatible = "st,tda7802";
> +	reg = <0x6c>;
> +	enable-supply = <&amp_enable_reg>;
> +};
> -- 
> 2.21.0
> 

Thanks,
Charles
