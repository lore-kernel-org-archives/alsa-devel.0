From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap-mcbsp: CPU version check changes
Date: Tue, 17 Jan 2012 14:16:08 +0100
Message-ID: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 96F662438F
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:16:34 +0100 (CET)
Received: by ghbg16 with SMTP id g16so2622499ghb.5
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 05:16:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following patches changes the way we check CPU versions to
enable different features (FIFO, and some register differencies).
In this way we are not going to need to change (and bloat) the
checks for future versions of OMAP.

Regards,
Peter

---
Peter Ujfalusi (2):
  ASoC: omap-mcbsp: Simplify checks for McBSP IP with FIFO
  ASoC: omap-mcbsp: Use future proof OMAP version checks for
    configuration

 sound/soc/omap/omap-mcbsp.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.7.8.3
