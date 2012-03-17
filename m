From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
Date: Sat, 17 Mar 2012 08:07:59 +0800
Message-ID: <20120317000757.GB7860@S2101-09.ap.freescale.net>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
	<CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
	<20120316111814.GA7860@S2101-09.ap.freescale.net>
	<20120316192110.GH3158@opensource.wolfsonmicro.com>
	<CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A52A24450
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 01:07:27 +0100 (CET)
Received: by iakh37 with SMTP id h37so6813258iak.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 17:07:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 05:28:54PM -0400, Trent Piepho wrote:
> On Fri, Mar 16, 2012 at 3:21 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Fri, Mar 16, 2012 at 07:18:18PM +0800, Shawn Guo wrote:
> >
> >> Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
> >> and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?
> 
> It seems non-orthogonal to me that ESAI has esai in the name but SSI
> does not have ssi.
> 
SSI comes first and so takes the "default and shorter" name :)

-- 
Regards,
Shawn
