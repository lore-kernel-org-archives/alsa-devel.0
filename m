From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Use usleep_range
	for delays
Date: Sat, 23 Oct 2010 14:43:57 +0100
Message-ID: <1287841437.7486.0.camel@odin>
References: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
	<1287749481-12203-2-git-send-email-peter.ujfalusi@nokia.com>
	<20101022153225.GC16521@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BE15424460
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 15:44:02 +0200 (CEST)
Received: by wye20 with SMTP id 20so1876683wye.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 06:44:02 -0700 (PDT)
In-Reply-To: <20101022153225.GC16521@opensource.wolfsonmicro.com>
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

On Fri, 2010-10-22 at 08:32 -0700, Mark Brown wrote:
> On Fri, Oct 22, 2010 at 03:11:20PM +0300, Peter Ujfalusi wrote:
> > Switch to use the more precise usleep_range instead of
> > msleep().
> > Replace the udelay with usleep_range to remove the busy loop
> > waiting.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Borwn <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
