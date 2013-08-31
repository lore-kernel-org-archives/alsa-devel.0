From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v11 3/8] ASoC: generic: simple DT sound card
Date: Sat, 31 Aug 2013 09:17:52 +0200
Message-ID: <20130831071752.GX20071@s25.your-server.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
 <20130823095816.GF25263@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 11B862608D0
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 09:18:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130823095816.GF25263@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Aug 23, 2013 at 10:58:16AM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 05:05:56PM +0200, Markus Pargmann wrote:
> > Simple sound card initialized using DT. When used with AC97, ac97-codec
> > is used to automatically discover the used codec.
> 
> I've held back a bit on this one.  The reason is that it's adding a
> separate card to the generic card which doesn't seem like the obvious
> thing to do - obviously they have very similar goals, it's just that one
> is for DT usage and the other isn't.  What's the reason for not adding
> DT support to the generic card?

There was no code I could reuse from the existing simple card driver, so
I decided to seperate the DT part.

I will move the DT driver code into simple card and resend the patch.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
