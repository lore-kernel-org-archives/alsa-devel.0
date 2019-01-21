From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: Documentation: Add google,
	cros-ec-codec
Date: Mon, 21 Jan 2019 19:14:52 +0100
Message-ID: <CAFqH_50BKXftn_4p4dK59g3Zv5LvZYVF92weN4OW87muqE_iUQ@mail.gmail.com>
References: <20190119113332.249720-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0848B2667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 19:15:04 +0100 (CET)
Received: by mail-qt1-f196.google.com with SMTP id i7so24511594qtj.10
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 10:15:04 -0800 (PST)
In-Reply-To: <20190119113332.249720-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, tzungbi@chromium.org, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

+ devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org> and
Mark Rutland <mark.rutland@arm.com>

Missatge de Cheng-Yi Chiang <cychiang@chromium.org> del dia ds., 19 de
gen. 2019 a les 12:34:
>
> Add documentation for Chrome EC codec driver.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Change in v4:
>  - Add a property max-dmic-gain so we can configure maximum gain on dmic.
>  - Add Guenter to the reviewer list.
>
>  .../bindings/sound/google,cros-ec-codec.txt   | 26 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> new file mode 100644
> index 000000000000..1084f7f22eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> @@ -0,0 +1,26 @@
> +* Audio codec controlled by ChromeOS EC
> +
> +Google's ChromeOS EC codec is a digital mic codec provided by the
> +Embedded Controller (EC) and is controlled via a host-command interface.
> +
> +An EC codec node should only be found as a sub-node of the EC node (see
> +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> +
> +Required properties:
> +- compatible: Must contain "google,cros-ec-codec"
> +- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
> +- max-dmic-gain: A number for maximum gain in dB on digital microphone.
> +
> +Example:
> +
> +cros-ec@0 {
> +       compatible = "google,cros-ec-spi";
> +
> +       ...
> +
> +       cros_ec_codec: ec-codec {
> +               compatible = "google,cros-ec-codec";
> +               #sound-dai-cells = <1>;
> +               max-dmic-gain = <43>;
> +       };
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..a5678e4041e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3688,6 +3688,13 @@ N:       cros_ec
>  N:     cros-ec
>  F:     drivers/power/supply/cros_usbpd-charger.c
>
> +CHROMEOS EC CODEC DRIVER
> +M:     Cheng-Yi Chiang <cychiang@chromium.org>
> +S:     Maintained
> +R:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:     Guenter Roeck <groeck@chromium.org>
> +F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.20.1.321.g9e740568ce-goog
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
