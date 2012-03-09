From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 9 Mar 2012 09:32:17 +0800
Message-ID: <20120309013216.GH2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0473F10BBC7
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 02:32:26 +0100 (CET)
Received: by obbup3 with SMTP id up3so1480752obb.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 17:32:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F591B8D.8090705@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2012 at 02:50:21PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
> > codec-handle is an optional property, so missing it should not be a
> > fatal error.]
> 
> It's optional in the sense that if your SSI is not connected to anything,
> then you don't need to specify the codec handle.  If the SSI is connected
> to a codec, then the SSI node needs to point to it.
> 
It's true for the binding that mpc8610_hpcd and p1022_ds use.  But per
request from Mark, we need to use the new binding for imx machine
drivers, which will have the codec phandle in "audio complex" node.

> > More importantly, the imx machine drivers to be added working with
> > fsl_ssi will not have this property, as they use new ASoC machine
> > driver binding mechanism.
> 
> I want to see that binding documented in Documentation/devicetree/bindings
> first.

Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt, which
takes Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
as the example.

-- 
Regards,
Shawn
