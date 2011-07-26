From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] ASoC: sgtl5000: add device tree probe support
Date: Tue, 26 Jul 2011 20:55:11 +0100
Message-ID: <20110726195511.GA9956@opensource.wolfsonmicro.com>
References: <1311265731-23318-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1311265731-23318-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Zeng Zhaoming <zhaoming.zeng-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 22, 2011 at 12:28:51AM +0800, Shawn Guo wrote:

> It adds device tree probe support for sgtl5000 driver.

Kind of waiting for the device tree people to comment on this...

>  .../bindings/sound/soc/codecs/fsl-sgtl5000.txt     |   11 +++++++++++

I'd expect this can just be put directly under the sound directory.

> +++ b/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
> @@ -0,0 +1,11 @@
> +* Freescale SGTL5000 Stereo Codec
> +
> +Required properties:
> +- compatible : "fsl,sgtl5000".
> +
> +Example:
> +
> +codec: sgtl5000@0a {
> +	compatible = "fsl,sgtl5000";
> +	reg = <0x0a>;
> +};

This might get a tiny bit verbose...  I wonder if it makes sense to have
some central file for devices with trivial bindings?  But possibly more
trouble than it's worth.
