From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: sound: add devicetree
	document for rt5616
Date: Tue, 22 Dec 2015 01:50:16 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010E22FC@RTITMBSV03.realtek.com.tw>
References: <1450703894-32623-2-git-send-email-wxt@rock-chips.com>
 <1450709768-14898-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F55226145A
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 02:50:22 +0100 (CET)
In-Reply-To: <1450709768-14898-1-git-send-email-wxt@rock-chips.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, "broonie@kernel.org" <broonie@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Caesar Wang [mailto:wxt@rock-chips.com]
> Sent: Monday, December 21, 2015 10:56 PM
> To: broonie@kernel.org; robh+dt@kernel.org
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> alsa-devel@alsa-project.org; Bard Liao; heiko@sntech.de; Caesar Wang
> Subject: [PATCH v1 2/2] dt-bindings: sound: add devicetree document for
> rt5616
> 
> Add the description for rt5616 codec.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v1:
> - As Heiko comments, remove the not exist option properties.
> 
>  Documentation/devicetree/bindings/sound/rt5616.txt | 36
> ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/sound/rt5616.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt
> b/Documentation/devicetree/bindings/sound/rt5616.txt
> new file mode 100644
> index 0000000..2030a22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rt5616.txt
> @@ -0,0 +1,36 @@
> +RT5616 audio CODEC
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "realtek,rt5616".
> +
> +- reg : The I2C address of the device.
> +
> +Pins on the device (for linking into audio routes) for RT5616:
> +
> +  * IN1P
> +  * IN2P
> +  * IN2N
> +  * LOUTL
> +  * LOUTR

These names below seems not defined in rt5616_dapm_widgets.
Where are they from?

> +  * CPN2
> +  * CPP2
> +  * CPN1
> +  * CPP1
> +  * HPO_R
> +  * HPO_L
> +  * ADCDAT1
> +  * DACDAT1
> +  * LRCK1
> +  * BCLK1
> +  * MCLK
> +  * GPIO1
> +
> +Example:
> +
> +rt5616 {
> +	compatible = "realtek,rt5616";
> +	reg = <0x1b>;
> +};
> --
> 1.9.1
