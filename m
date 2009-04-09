From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: omap-mcbsp,
	osk5912 and tlv320aic23 DSP mode change
Date: Thu,  9 Apr 2009 12:34:39 +0300
Message-ID: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 009CB24389
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 11:34:56 +0200 (CEST)
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
Cc: jarkko.nikula@nokia.com, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

Hello,

While I was trying to implement the four channel mode for the twl4030 codec, I
have noticed, that the DSP_B mode implementation in omap-mcbsp and tlv320aic23
is not coorect, also for me it seams that the osk5912 configuration for the DSP
mode is incorrect (based on the tlv320aic32 datasheet).

The following series tries to correct this by:
- Adding DSP_A support for the codec (setting the LRP bit for the DSP mode)
- Changing the DSP_B mode to DSP_A mode in omap-mcbsp
- Correcting the dai format configuration for the osk5912 board file.

Please note, that I don't have access to osk5912 board, but based on the
available documentation, I think the changes in this series are correct.

---
Peter Ujfalusi (3):
  ASoC: tlv320aic32: add DSP_A format support
  ASoC: omap-mcbsp: change the DSP_B mode to DSP_A mode
  ASoC: osk5912: Use the correct DSP_A mode

 sound/soc/codecs/tlv320aic23.c |    2 ++
 sound/soc/omap/omap-mcbsp.c    |    4 ++--
 sound/soc/omap/osk5912.c       |    8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)
