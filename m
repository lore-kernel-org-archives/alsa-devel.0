From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Thu, 8 Mar 2012 20:37:41 +0800
Message-ID: <20120308123739.GC2499@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<4F57ECC7.1040100@freescale.com>
	<20120308120207.GJ3638@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 153FE10BA70
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 13:37:53 +0100 (CET)
Received: by iakh37 with SMTP id h37so768951iak.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 04:37:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308120207.GJ3638@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2012 at 12:02:07PM +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 05:18:31PM -0600, Timur Tabi wrote:
> 
> > I've tested this patchset, and after adding the changes that I pointed out
> > in my previous email, audio still works on the P1022DS and MPC8610HPCD.
> 
> > Therefore:
> 
> > Acked-by: Timur Tabi <timur@freescale.com>
> 
> Excellent, it's great to see the SSI drivers merged!  Shawn, could you
> please resend the unapplied patches with all the relevant acks collected
> and tweaks that people requested just to make sure I've got everything.
> 
Sure.  I got interrupted from the work during the past 2 days, but I'm
resuming it now.

> I know Sascha wanted some slightly larger changes to the new card driver
> so if you want to hold off on that until you've done the updates that's
> fine but it'd be good to get all the other stuff merging the drivers
> together for 3.4 if we can.

That's my goal too.

-- 
Regards,
Shawn
