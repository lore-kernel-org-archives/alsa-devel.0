From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/2] CHROMIUM: ASoC: rt5663: Add documentation for power
 supply support
Date: Fri, 2 Nov 2018 11:33:37 +0800
Message-ID: <CAFv8NwJuTkth_xvPpWok_O9v9TXdGEj9ow+NCvnMiJqRJTrLvA@mail.gmail.com>
References: <20181101124007.243258-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101124007.243258-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Sorry! I made a mistake in the title.
I will fix them and re-post.
On Thu, Nov 1, 2018 at 8:40 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> rt5663 codec driver will support setting CPVDD and AVDD power supply
> from device tree.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Documentation/devicetree/bindings/sound/rt5663.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
> index 23386446c63d6..d4058dfde0392 100644
> --- a/Documentation/devicetree/bindings/sound/rt5663.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5663.txt
> @@ -36,6 +36,9 @@ Optional properties:
>    "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges of
>    impedance in the impedance sensing function.
>
> +- avdd-supply: Power supply for AVDD, providing 1.8V.
> +- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
> +
>  Pins on the device (for linking into audio routes) for RT5663:
>
>    * IN1P
> @@ -51,4 +54,6 @@ rt5663: codec@12 {
>         compatible = "realtek,rt5663";
>         reg = <0x12>;
>         interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +       avdd-supply = <&pp1800_a_alc5662>;
> +       cpvdd-supply = <&pp3500_a_alc5662>;
>  };
> --
> 2.19.1.568.g152ad8e336-goog
>
