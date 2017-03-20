From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: Document the dmas and
 dma-names properties for bcm2835-analog-audio
Date: Mon, 20 Mar 2017 11:50:09 -0500
Message-ID: <20170320165009.ylrohjwettdy2lgf@rob-hp-laptop>
References: <20170312063820.19313-1-mzoran@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 61384266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 17:50:12 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id i1so19887979ota.3
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 09:50:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170312063820.19313-1-mzoran@crowfest.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Zoran <mzoran@crowfest.net>
Cc: mark.rutland@arm.co, stefan.wahren@i2se.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, tiwai@suse.com, eric@anholt.net, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 11, 2017 at 10:38:17PM -0800, Michael Zoran wrote:
> Add documentation for the DMA properties required when using the
> PWM controller of the bcm2835 for analog audio output.
> 
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> index cf573e85b11d..08fc06fc083a 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> @@ -1,14 +1,21 @@
>  BCM2835 PWM controller (Raspberry Pi controller)
>  
>  Required properties:
> -- compatible: should be "brcm,bcm2835-pwm"
> +- compatible: should be "brcm,bcm2835-pwm" or "brcm,bcm2835-analog-audio"

Compatibles are not for selecting usage modes. You should describe the 
connection to the pwm that makes it an audio output rather than change 
the compatible.

>  - reg: physical base address and length of the controller's registers
>  - clocks: This clock defines the base clock frequency of the PWM hardware
>    system, the period and the duty_cycle of the PWM signal is a multiple of
>    the base period.
> +
> +Required properties(PWM Output):
>  - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
>    the cells format.
>  
> +Required properties(Audio Output):
> +- dmas: Should contain one entry pointing to the DMA channel used to
> +	transfer audio data
> +- dma-names:   Should contain "tx"
> +
>  Examples:
>  
>  pwm@2020c000 {
> -- 
> 2.11.0
> 
