From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 08/11] ASoC: fsl-ssi: imx ac97 support
Date: Wed, 10 Apr 2013 13:33:04 +0200
Message-ID: <20130410113304.GB16749@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
 <5162301F.9090000@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5162301F.9090000@tabi.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 07, 2013 at 09:49:03PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >This patch copies some parts from imx-ssi to support AC97 on
> >imx27-pca100 and imx27-pcm043. It is activated with a new fsl,imx-ac97
> >bool property. It was tested on imx27-pca100.
> 
> I'm not crazy about this patch -- it seems a bit hackish.  There are
> too many "if (imx_ac97)" clauses.  Large pieces of code that don't
> appear to be related to AC97 are indented in an if-clause.  I
> especially don't like the "If we use AC97, the registers are already
> setup correctly".
> 

I will try to seperate it a little bit cleaner by using different dai
ops for ac97 for the two big ifs and perhaps use a seperated register
setup function so it can be used from ssi startup and ac97_setup.

Regards,

Markus

> -- 
> Timur Tabi
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
