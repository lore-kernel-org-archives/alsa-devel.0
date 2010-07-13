From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Fix for digital loopback
 gain range
Date: Tue, 13 Jul 2010 11:32:11 +0100
Message-ID: <1279017131.3125.32.camel@odin>
References: <1278924606-5462-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100712085153.GA21840@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 346A810384B
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 12:32:15 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so223882wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 03:32:15 -0700 (PDT)
In-Reply-To: <20100712085153.GA21840@rakim.wolfsonmicro.main>
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

On Mon, 2010-07-12 at 09:51 +0100, Mark Brown wrote:
> On Mon, Jul 12, 2010 at 11:50:06AM +0300, Peter Ujfalusi wrote:
> > When the gain is configured using dB value it was
> > not possible to use -24dB since the loopback got
> > muted instead of -24dB.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
