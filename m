From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Thu, 20 Jun 2013 14:51:48 +0200
Message-ID: <20130620125148.GC3085@s25.your-server.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
 <51BE8B21.8050605@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51BE8B21.8050605-N01EOCouUvQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 16, 2013 at 11:05:53PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> > Hi,
> >
> > This series adds DT support for phycore-ac97. Beside ac97 support, the series
> > adds imx-pcm-fiq and generic DMA bindings to fsl-ssi.
> >
> > In version 8 I fixed the build issues by seperating the DT capable ac97 phycore
> > driver from the old driver.
> 
> FYI, I get some warnings applying this patchset:
> 
> Applying: ASoC: Add phycore-ac97-dt driver
> /home/b04825/git/linux.alsa2/.git/rebase-apply/patch:375: new blank line 
> at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
> Applying: ASoC: fsl: Move fsl-ssi binding doc to sound/
> Applying: ASoC: fsl: Update fsl-ssi binding doc
> /home/b04825/git/linux.alsa2/.git/rebase-apply/patch:33: space before tab 
> in indent.
>    		    Only necessary for some boards with incompatible
> warning: 1 line adds whitespace errors.

Thanks, I fixed all whitespace errors and the compile error.

Regards,

Markus

> 
> -- 
> Timur Tabi
> 
