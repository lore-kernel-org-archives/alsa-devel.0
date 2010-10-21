From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: Error handling for broken
 chip
Date: Thu, 21 Oct 2010 22:07:47 +0100
Message-ID: <1287695267.3205.73.camel@odin>
References: <1287662583-17809-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101021153918.GB9447@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 92870103A69
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 23:07:44 +0200 (CEST)
Received: by wye20 with SMTP id 20so54104wye.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 14:07:44 -0700 (PDT)
In-Reply-To: <20101021153918.GB9447@opensource.wolfsonmicro.com>
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

On Thu, 2010-10-21 at 08:39 -0700, Mark Brown wrote:
> On Thu, Oct 21, 2010 at 03:03:03PM +0300, Peter Ujfalusi wrote:
> > Correct/Implement handling of broken chip.
> > Fail the i2c_prope if the communication with the chip
> > fails.
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
