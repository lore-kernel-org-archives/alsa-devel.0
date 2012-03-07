From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Wed, 7 Mar 2012 09:37:36 +0100
Message-ID: <20120307083736.GK3852@pengutronix.de>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
	<20120305174232.GA3852@pengutronix.de>
	<20120306155055.GA13802@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A8F89103CEE
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 09:37:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120306155055.GA13802@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 06, 2012 at 11:50:57PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 06:42:32PM +0100, Sascha Hauer wrote:
> > On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> > > This is the initial imx-sgtl5000 machine driver support with only
> > > playback dai link implemented.  More features can be added on top
> > > of it later.
> > 
> > Are there problems with capturing? It should be trivial to add and
> > it would be much more confident that this series as a whole works as
> > expected.
> > 
> I worked all day long to try to give that answer.  Here it is.
> 
> No, there is no problem with capturing on fsl_ssi + imx_pcm_dma +
> imx_sgtl5000 side.  But there is a problem with sgtl5000 codec driver.
> With that problem fixed in sgtl5000, this series works just fine with
> capturing.  (I'm not sure I want to fix it within this series though,
> as it's already big enough.)

Thanks a lot for testing this. In this case I'm fine with this series
and can likely Ack your next iteration. You can skip capture support
from this series as you said it's big enough. It's enough for me when
you say it works on your branch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
