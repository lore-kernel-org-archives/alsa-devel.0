From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 11:42:10 +0200
Message-ID: <1526550130.2971.3.camel@pengutronix.de>
References: <20180517092245.16036-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F73F266F88
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 11:42:21 +0200 (CEST)
In-Reply-To: <20180517092245.16036-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-05-17 at 11:22 +0200, Marco Felsch wrote:
> The ssm2305 is a simple Class-D audio amplifier. A application can
> turn on/off the device by a gpio. It's also possible to hardwire the
> shutdown pin.
> 
> Tested on a i.MX6 based custom board.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/adi,ssm2305.txt |  15 +++
>  sound/soc/codecs/Kconfig                      |   7 ++
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/ssm2305.c                    | 105 ++++++++++++++++++
>  4 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
>  create mode 100644 sound/soc/codecs/ssm2305.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2305.txt b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
> new file mode 100644
> index 000000000000..fc4c99225538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
> @@ -0,0 +1,15 @@
> +Analog Devices SSM2305 Speaker Amplifier
> +========================================
> +
> +Required properties:
> +  - compatible : "adi,ssm2305"
> +
> +Optional properties:
> +  - ssm2305,shutdown-gpio : the gpio connected to the shutdown pin

This should be called shutdown-gpios (plural, no vendor prefix) for
consistency. Also, since the shutdown GPIO on SSM2305 is active low,
this should be documented here.

regards
Philipp
