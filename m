From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ASoC: wm8994: Add clock bindings to the
	device tree
Date: Thu, 25 Jul 2013 16:46:27 +0100
Message-ID: <20130725154627.GA22291@e106331-lin.cambridge.arm.com>
References: <1374762668-5037-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CFA926084C
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 17:46:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1374762668-5037-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 03:31:08PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Due to the variable availability of the clock API there is no code in the
> driver to use these at present, for the time being the machine drivers
> will need to handle requesting clocks.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Do these two clock inputs exist for all of wm1811, wm8994, and wm8958?

If I've read the context correctly, these are optional. Does this mean
that if not listed that an OS can assume they are already configured and
active? It would be nice to document that.

Otherwise, this looks sensible:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  Documentation/devicetree/bindings/sound/wm8994.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
> index f2f3e80..e045e90 100644
> --- a/Documentation/devicetree/bindings/sound/wm8994.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8994.txt
> @@ -32,6 +32,10 @@ Optional properties:
>      The second cell is the flags, encoded as the trigger masks from
>      Documentation/devicetree/bindings/interrupts.txt
>  
> +  - clocks : A list of up to two phandle and clock specifier pairs
> +  - clock-names : A list of clock names sorted in the same order as clocks.
> +                  Valid clock names are "MCLK1" and "MCLK2".
> +
>    - wlf,gpio-cfg : A list of GPIO configuration register values. If absent,
>      no configuration of these registers is performed. If any value is
>      over 0xffff then the register will be left as default. If present 11
> -- 
> 1.8.3.2
> 
> 
