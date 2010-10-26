From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: TWL4030: Use usleep_range when
 appropriate
Date: Tue, 26 Oct 2010 11:11:11 +0100
Message-ID: <1288087871.3301.8.camel@odin>
References: <1287995663-12395-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101025182228.GF16246@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B9E2610380F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 12:11:21 +0200 (CEST)
Received: by wye20 with SMTP id 20so4529927wye.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 03:11:19 -0700 (PDT)
In-Reply-To: <20101025182228.GF16246@opensource.wolfsonmicro.com>
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

On Mon, 2010-10-25 at 11:22 -0700, Mark Brown wrote:
> On Mon, Oct 25, 2010 at 11:34:23AM +0300, Peter Ujfalusi wrote:
> > Change the busy loop delays with usleep_range or msleep calls.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> _______________________________________________

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
