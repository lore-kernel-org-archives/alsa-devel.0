From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Tue, 6 Mar 2012 23:50:57 +0800
Message-ID: <20120306155055.GA13802@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
	<20120305174232.GA3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34539104542
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 16:36:26 +0100 (CET)
Received: by iakh37 with SMTP id h37so7658337iak.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 07:36:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120305174232.GA3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 06:42:32PM +0100, Sascha Hauer wrote:
> On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> > This is the initial imx-sgtl5000 machine driver support with only
> > playback dai link implemented.  More features can be added on top
> > of it later.
> 
> Are there problems with capturing? It should be trivial to add and
> it would be much more confident that this series as a whole works as
> expected.
> 
I worked all day long to try to give that answer.  Here it is.

No, there is no problem with capturing on fsl_ssi + imx_pcm_dma +
imx_sgtl5000 side.  But there is a problem with sgtl5000 codec driver.
With that problem fixed in sgtl5000, this series works just fine with
capturing.  (I'm not sure I want to fix it within this series though,
as it's already big enough.)

-- 
Regards,
Shawn
