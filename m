From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/6] ASoC: 4 channel support for twl4030 and
	omap-mcbsp
Date: Mon,  6 Apr 2009 15:19:26 +0300
Message-ID: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 63D3A1038CF
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:19:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Hello,

This series adds support for four channel DSP_A or DSP_B on omap-mcbsp and
four channel support for the twl4030 codec (in Option1).

Constrains added to deal with the channel count in twl4030 codec driver.

As an example, the board file for Beagle is modified to add support for stereo
and TDM mode depending on the stream's channel count, so the stereo and the
four channel mode are supported on Beagle.

Please note that patch #2 modifies also the DSP_B mode to have single phase
configuration, s since I think that is the correct for that mode also.


---
Peter Ujfalusi (6):
  ASoC: OMAP mcbsp: Add DSP_A support
  ASoC: OMAP mcbsp: Add 4 channel support
  ASoC: TWL4030: Enable all audio paths
  ASoC: TWL4030: Add 4 channel TDM support
  ASoC: TWL4030: Add constraints for 4 channel mode
  ASoC: Beagle: Add support for 4 channel mode

 sound/soc/codecs/twl4030.c   |   24 ++++++++++++++++++++----
 sound/soc/omap/omap-mcbsp.c  |   25 +++++++++++++++++++------
 sound/soc/omap/omap3beagle.c |   26 ++++++++++++++++++--------
 3 files changed, 57 insertions(+), 18 deletions(-)
