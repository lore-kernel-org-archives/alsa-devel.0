From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: DAC power optimization
Date: Tue, 13 Jul 2010 11:31:36 +0100
Message-ID: <1279017096.3125.31.camel@odin>
References: <1279012064-684-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100713093731.GC11860@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 474762440A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 12:31:45 +0200 (CEST)
Received: by wwb13 with SMTP id 13so223882wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 03:31:39 -0700 (PDT)
In-Reply-To: <20100713093731.GC11860@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-07-13 at 10:37 +0100, Mark Brown wrote:
> On Tue, Jul 13, 2010 at 12:07:44PM +0300, Peter Ujfalusi wrote:
> > Restructure the DAPM connections in order to enable
> > only the needed DAC (out of four in twl4030 series).
> > I need to keep the 'AIF Enable' supply connected to
> > the L2/R2 digital path, since the digital loopback
> > needs AIF and APLL running.
> > If no valid route available, than none of the DAC will
> > be powered, but the AIF and APLL is going to be enabled.
> > Furthermore, if only one audio path have valid route,
> > than only the corresponding DAC will be powered.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsomicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
