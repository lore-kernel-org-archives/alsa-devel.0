From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/2] ASoC: Add DT bindings documentation
 for max98504 amplifier
Date: Mon, 20 Jun 2016 08:15:22 -0500
Message-ID: <20160620131522.GA27923@rob-hp-laptop>
References: <1466095238-9047-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f194.google.com (mail-ob0-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B9F1265289
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 15:15:24 +0200 (CEST)
Received: by mail-ob0-f194.google.com with SMTP id wj2so4491064obc.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 06:15:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466095238-9047-1-git-send-email-s.nawrocki@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, inki.dae@samsung.com, broonie@kernel.org, ideal.song@samsung.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2016 at 06:40:37PM +0200, Sylwester Nawrocki wrote:
> This patch adds DT bindings documentation for Maxim MAX98504
> speaker amplifier.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since initial version:
>  - dropped all optional properties used for setting up TDM and
>    speaker data source,
>  - added regulator supply properties.
> ---
>  .../devicetree/bindings/sound/max98504.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/max98504.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/max98504.txt b/Documentation/devicetree/bindings/sound/max98504.txt
> new file mode 100644
> index 0000000..7aa5b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98504.txt
> @@ -0,0 +1,22 @@
> +Maxim MAX98504 class D mono speaker amplifier
> +
> +This device supports I2C control interface and an IRQ output signal. It features
> +a PCM and PDM digital audio interface (DAI) and a differential analog input.

Where's the IRQ in the binding?

> +
> +Required properties:
> +
> + - compatible : "maxim,max98504"
> + - reg : should contain the I2C slave device address
> + - DVDD-supply, DIOVDD-supply, PVDD-supply: power supplies for the device,
> +   as covered in Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +Example:
> +
> + max98504: max98504@31 {
> +	compatible = "maxim,max98504";
> +	reg = <0x31>;
> +
> +	DVDD-supply = <&regulator>;
> +	DIOVDD-supply = <&regulator>;
> +	PVDD-supply = <&regulator>;
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
