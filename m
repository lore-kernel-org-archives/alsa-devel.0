From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Thu, 22 Sep 2011 18:17:45 +0100
Message-ID: <20110922171744.GF5173@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6322B103879
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 19:17:47 +0200 (CEST)
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

The following changes since commit 5013951be88e136d9990ef55303276e2779ce8d8:

  ASoC: Fix trivial build regression in Kirkwood I2S (2011-09-12 11:48:12 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.1

A couple of driver fixes and the driver name issue we discussed.

Axel Lin (1):
      ASoC: bf5xx-ad73311: Fix prototype for bf5xx_probe

Mark Brown (2):
      ASoC: Remove bitrotted wm8962_resume()
      ASoC: Ensure we generate a driver name

 sound/soc/blackfin/bf5xx-ad73311.c |    2 +-
 sound/soc/codecs/wm8962.c          |   26 --------------------------
 sound/soc/soc-core.c               |   18 +++++++++++++++---
 3 files changed, 16 insertions(+), 30 deletions(-)
