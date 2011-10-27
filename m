From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/13] Convert some MICBIAS widgets to supplies
Date: Thu, 27 Oct 2011 09:54:05 +0200
Message-ID: <20111027075405.GA18360@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07B6124658
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:54:08 +0200 (CEST)
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
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since supply widgets are much easier to use than MICBIAS widgets we
should really convert existing drivers with MICBIAS widgets to use
supply widgets instead.  Start this with some easier drivers that don't
have any machine drivers.

Mark Brown (13):
      ASoC: Convert wm8400 MICBIAS to a supply widget
      ASoC: Convert wm8900 MICBIAS to a supply widget
      ASoC: Convert wm8904 MICBIAS to a supply widget
      ASoC: Convert wm8960 MICBIAS to a supply widget
      ASoC: Convert wm8961 MICBIAS to a supply widget
      ASoC: Convert wm8971 MICBIAS to a supply widget
      ASoC: Convert wm8974 MICBIAS to a supply widget
      ASoC: Convert wm8983 MICBIAS to a supply widget
      ASoC: Convert wm8985 MICBIAS to a supply widget
      ASoC: Convert wm8988 MICBIAS to a supply widget
      ASoC: Convert wm8990 MICBIAS to a supply widget
      ASoC: Convert wm8991 MICBIAS to a supply widget
      ASoC: Convert wm8995 MICBIASes to supply widgets

 sound/soc/codecs/wm8400.c |    4 ++--
 sound/soc/codecs/wm8900.c |    2 +-
 sound/soc/codecs/wm8904.c |    2 +-
 sound/soc/codecs/wm8960.c |    2 +-
 sound/soc/codecs/wm8961.c |    2 +-
 sound/soc/codecs/wm8971.c |    2 +-
 sound/soc/codecs/wm8974.c |    2 +-
 sound/soc/codecs/wm8983.c |    3 ++-
 sound/soc/codecs/wm8985.c |    3 ++-
 sound/soc/codecs/wm8988.c |    2 +-
 sound/soc/codecs/wm8990.c |    4 ++--
 sound/soc/codecs/wm8991.c |    4 ++--
 sound/soc/codecs/wm8995.c |    6 ++++--
 13 files changed, 21 insertions(+), 17 deletions(-)
