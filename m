From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Tue, 27 Sep 2011 13:31:52 +0100
Message-ID: <20110927123151.GK4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D2C424337
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 14:31:53 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit f0e8ed858edb327802ee65fd695cc1538286226f:

  ASoC: Ensure we generate a driver name (2011-09-21 14:54:23 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.1

Jarkko Nikula (1):
      ASoC: omap-mcbsp: Do not attempt to change DAI sysclk if stream is active

Lars-Peter Clausen (1):
      ASoC: ssm2602: Re-enable oscillator after suspend

 sound/soc/codecs/ssm2602.c  |    3 ++-
 sound/soc/omap/omap-mcbsp.c |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)
