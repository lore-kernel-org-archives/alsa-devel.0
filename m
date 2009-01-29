From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC: TWL4030: Analog bypass
	implementation - try2
Date: Thu, 29 Jan 2009 14:57:49 +0200
Message-ID: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A752B103878
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 13:58:10 +0100 (CET)
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Second try for the analog bypass implementation.

Since the first try most of the things has been turned around - I tried to
follow Mark's advice, I hope I managed well enough:
[1] New power, codec state handling
The codec will be powered at all time, except if the codec's bias level has
been set to SND_SOC_BIAS_OFF via the twl4030_set_bias_level call.

[2] Keeping the power consumption on the lowest level
When the codec is in SND_SOC_BIAS_ON state (playback/recording), there is
nothing can be done, the amplifiers are powered, PLL is enabled.
When the codec enters to SND_SOC_BIAS_STANDBY state, two thing can happen:
- If none of the bypass switches are enabled, than the gain controls for the
  outputs are forced to power-down mode and the PLL is disabled
- If one of the bypass switches are enabled, than the gain controls will be
  kept in their user configured state and the PLL stays enabled.

When the codec is in SND_SOC_BIAS_STANDBY (gains and PLL are disabled), change
in the bypass config will trigger an event and if it is needed the gains and
PLL will be enabled. Switching all bypass off will switch the gains and PLL off.

With the this implementation, there is no visible difference in power
consumption compared to the previous, codec off way.
So when the codec is in SND_SOC_BIAS_STANDBY mode and all of the bypasses are
disabled, the additional power consumption is minimal, if any.

---
Peter Ujfalusi (1):
  ASoC: TWL4030: Add analog loopback support

 sound/soc/codecs/twl4030.c |  212 +++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/twl4030.h |   15 +++
 2 files changed, 214 insertions(+), 13 deletions(-)
