From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Fri, 9 Mar 2012 15:13:49 +0800
Message-ID: <20120309071347.GM2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<4F5910EE.8090408@freescale.com>
	<20120309011914.GF2499@S2101-09.ap.freescale.net>
	<4F5966DC.6090201@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1298410BB8B
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 08:13:55 +0100 (CET)
Received: by iakh37 with SMTP id h37so2113320iak.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 23:13:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F5966DC.6090201@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2012 at 02:11:41AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Are you testing the patch set on top of the SHA below, which I
> > mentioned in the cover letter?
> >
> >    3030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc)
> >
> > I see the similar problem on the following SHA with my testing on
> > imx-sgtl5000.
> >
> >    1a8feca (Merge branch 'for-3.4' into asoc-next)
> 
> It appears the problem is with for-3.4 itself.  I'm running git-bisect now 
> to narrow it down.
> 
My bisect tells that the offending commit is:

  96acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex)

But I do not understand why yet.

-- 
Regards,
Shawn
