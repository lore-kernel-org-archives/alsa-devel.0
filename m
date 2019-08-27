From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF
 pin option
Date: Tue, 27 Aug 2019 17:37:16 -0500
Message-ID: <20190827223716.GA31605@bogus>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
 <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Chas Williams <3chas3@gmail.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 24, 2019 at 10:26:55PM +0200, Michał Mirosław wrote:
> Add single-pin LRCLK source options for Atmel SSC module.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> ---
>   v2: split from implementation patch
> 
> ---
>  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> index f9fb412642fe..c98e96dbec3a 100644
> --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> @@ -24,6 +24,11 @@ Optional properties:
>         this parameter to choose where the clock from.
>       - By default the clock is from TK pin, if the clock from RK pin, this
>         property is needed.
> +  - atmel,lrclk-from-tf-pin: bool property.
> +  - atmel,lrclk-from-rf-pin: bool property.
> +     - SSC in slave mode gets LRCLK from RF for receive and TF for transmit
> +       data direction. This property makes both use single TF (or RF) pin
> +       as LRCLK. At most one can be present.

A single property taking 1 of possible 2 values would prevent the error 
of more than 1 property present.

>    - #sound-dai-cells: Should contain <0>.
>       - This property makes the SSC into an automatically registered DAI.
>  
> -- 
> 2.20.1
> 
