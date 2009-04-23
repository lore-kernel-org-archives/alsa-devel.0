From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: 4 channel support for twl4030 and
	omap-mcbsp - Try2
Date: Thu, 23 Apr 2009 14:36:47 +0300
Message-ID: <1240486610-8125-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id CF3C710380B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 13:36:59 +0200 (CEST)
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
This series adds support for 4 channel DSP mode (A or B) to OMAP McBSP and also
to the twl4030 codec driver.
As an example the Beagle board file is modified to be able to use 4 channel
mode.

The change in twl4030 is made in a way, that it will not enable the 4 channel
mode when the codec is in OPTION2 mode.
Since some of the bits in the OPTION register are shared and have different
effect in OPTION1 and OPTION2 modes, an extra care is taken to prevent unvanted
modification to the register.

Note:
The series is on top of Mark's tree in regard of the twl4030 codec, so it is on
top of the 'ASoC: TWL4030: Add VDL path support' from Joonyoung Shim.

---
Peter Ujfalusi (2):
  ASoC: OMAP: Add 4 channel support to mcbsp
  ASoC: TWL4030: Add 4 channel TDM support

Ujfalusi Peter (Nokia-D/Tampere) (1):
  ASoC: Beagle: Add support for 4 channel mode

 sound/soc/codecs/twl4030.c   |   52 ++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/twl4030.h   |   11 +++++++++
 sound/soc/omap/omap-mcbsp.c  |    5 ++-
 sound/soc/omap/omap3beagle.c |   26 ++++++++++++++------
 4 files changed, 82 insertions(+), 12 deletions(-)
