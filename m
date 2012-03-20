From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: omap-mcbsp: Constraint handling
	changes
Date: Tue, 20 Mar 2012 13:13:38 +0200
Message-ID: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog135.obsmtp.com [74.125.149.84])
	by alsa0.perex.cz (Postfix) with ESMTP id D36D924616
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:13:56 +0100 (CET)
Received: by mail-lb0-f176.google.com with SMTP id m11so5777143lbo.21
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 04:13:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello,

This series will add the following changes:
1. We do not need to place buffer size constraint in case of a capture stream.

2. Grazvydas Ignotas <notasas@gmail.com> reported that on Pandora they have
issues with legacy applications (and OSS emulation) when they open the playback
with small period size (smaller than the FIFO size). Since these legacy
applications can not be fixed (and it is not feasible), this series will provide
a solution to overcome with the underruns at the stream start.

With the introduction of the new sysfs file (period_protection) the user can
request the driver to place the constraint to the period size instead of the
buffer size.
With the period_protection one can specify the number of samples they want to
have as protection in period size constraint over the McBSP FIFO size.

As an example:
OMAP3, McBSP2, stereo stream.
the FIFO is 640 samples long.
period_protection = 1 will ensure that the period size is minimum of 641 samples
long.

With the test code from Grazvydas Ignotas:
http://notaz.gp2x.de/misc/alsa_period_test.c

I don't see underrun issues with period_protection = 1 on BeagleBoard.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: omap-mcbsp: buffer size constraint only applies to playback
    stream
  ASoC: omap-mcbsp: Restructure omap_mcbsp_dai_startup code
  ASoC: omap-mcbsp: Add period size protection mode

 sound/soc/omap/mcbsp.c      |    2 +
 sound/soc/omap/mcbsp.h      |    1 +
 sound/soc/omap/omap-mcbsp.c |   71 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 14 deletions(-)

-- 
1.7.8.5
