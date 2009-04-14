From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: DSP mode corrections for omap-mcbsp
Date: Tue, 14 Apr 2009 10:45:29 +0300
Message-ID: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8847A24481
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 09:45:43 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Hello,

As a follow-up for the before easter mail thread on the omap DSP_A/_B mode
support...

This series should fix the current DSP_B mode and also introduces support for
DSP_A mode in omap-mcbsp.

Since omap's mcbsp module is quite flexible, one who is writing a board file for
the omap platform has to check both the modes (DSP_A/_B) and the clock polarity
settings against the codec requirements and pick the correct pair.

For example in osk5912 board file:
To use DSP_B mode (as it is now, no changes needed):
        snd_soc_dai_set_fmt(codec_dai,
                SND_SOC_DAIFMT_DSP_B |
                SND_SOC_DAIFMT_NB_IF |
                SND_SOC_DAIFMT_CBM_CFM);

To use the DSP_A mode for the same board, codec:
        snd_soc_dai_set_fmt(codec_dai,
                SND_SOC_DAIFMT_DSP_A |
                SND_SOC_DAIFMT_IB_IF |
                SND_SOC_DAIFMT_CBM_CFM);


---
Peter Ujfalusi (2):
  ASoC: omap-mcbsp: Correct the DSP_B mode
  ASoC: omap-mcbsp: Add DSP_A support

 sound/soc/omap/omap-mcbsp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
