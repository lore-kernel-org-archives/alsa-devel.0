From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for Maxim Integrated
	MAX98927 Amplifier
Date: Fri, 24 Mar 2017 10:26:13 -0500
Message-ID: <20170324152613.qzvsviznhiz5f3sj@rob-hp-laptop>
References: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A110A2669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 16:26:18 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id y88so643015ota.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 08:26:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, tiwai@suse.com, srinivas.kandagatla@linaro.org, romain.perier@collabora.com, bardliao@realtek.com, lars@metafoo.de, axel.lin@ingics.com, Paul.Handrigan@cirrus.com, devicetree@vger.kernel.org, arnd@arndb.de, nh6z@nh6z.net, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, dgreid@google.com, oder_chiou@realtek.com, KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org, petr@barix.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 09:40:23AM +0900, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
> Resubmit the intial version of MAX98927 driver. Added all fixes into the initial patch.
> 
>  .../devicetree/bindings/sound/max98927.txt         |   39 +
>  sound/soc/codecs/Kconfig                           |    5 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/max98927.c                        | 1040 ++++++++++++++++++++
>  sound/soc/codecs/max98927.h                        |  267 +++++
>  5 files changed, 1353 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/max98927.txt
>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>  create mode 100755 sound/soc/codecs/max98927.c
>  create mode 100755 sound/soc/codecs/max98927.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/max98927.txt b/Documentation/devicetree/bindings/sound/max98927.txt
> new file mode 100755
> index 0000000..d610879
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98927.txt
> @@ -0,0 +1,39 @@
> +max98927 audio CODEC
> +
> +This device supports I2C.

Can we combine this and the other max9892x bindings. They all look 
similar.

> +
> +Required properties:
> +
> +  - compatible : "maxim,max98927"
> +
> +  - maxim,vmon-slot-no : slot number used to send voltage information

While vendor prefix is preferred, so is using the same property names. 
Either use the existing names or deprecate the old ones in favor of 
these.

> +                   or in inteleave mode this will be used as
> +                   interleave slot.
> +                   This property can be set to values from 0 to 15 for slot 0 to 15.
> +                   Default value is 0.
> +
> +  - maxim,imon-slot-no : slot number used to send current information
> +                   This property can be set to values from 0 to 15 for slot 0 to 15.
> +                   Default value is 0.
> +
> +  - maxim,interleave-mode : When using two MAX98927 in a system it is
> +                   possible to create ADC data that that will
> +                   overflow the frame size. Digital Audio Interleave
> +                   mode provides a means to output VMON and IMON data
> +                   from two devices on a single DOUT line when running
> +                   smaller frames sizes such as 32 BCLKS per LRCLK or
> +                   48 BCLKS per LRCLK.
> +                   This property can be set to values from 0 to 1 for off and on.
> +                   Default value is 0.
> +
> +  - reg : the I2C address of the device for I2C
> +
> +Example:
> +
> +codec: max98927@3a {
> +   compatible = "maxim,max98927";
> +   maxim,vmon-slot-no = <0>;
> +   maxim,imon-slot-no = <1>;
> +   maxim,interleave-mode = <0>;
> +   reg = <0x3a>;
> +};
