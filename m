From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/7] ASoC: TWL4030: put the codec to off when
	not active
Date: Tue, 25 May 2010 14:34:01 +0300
Message-ID: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 414FA24476
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:34:33 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

The following series at the end will let the twl4030 codec to use BIAS_OFF
instead of BIAS_STANDBY.
The difference in power consumption is about 0.5mA.

To achieve this:
- The regcache has been reseted to codec default
- The codec initialization has been optimized, it is no longer writes all 73
  registers at startup, but only modifies few selected one.
- The power related code has been cleaned up, and optimized
- Support added for machine drivers to select the offset cancellation path
- debug support for checking the codec default registers (machine drivers can
  ask for checking, but shall be disabled in production).

I guess that's it.
The driver has been tested on a custom board with twl5031. It passed all of our
internal test cases covering much of the codec features.

---
Peter Ujfalusi (7):
  ASoC: TWL4030: Revisit codec defaults
  ASoC: TWL4030: Remove wrapper for power down
  ASoC: TWL4030: Make offset cancellation path configurable
  ASoC: TWL4030: Optimize the power up sequence
  ASoC: TWL4030: Helper to check chip default registers
  ASoC: TWL4030: Correct the ARXR2_APGA_CTL chip default
  ASoC: TWL4030: Use BIAS_OFF instead of BIAS_STANDBY, when not in use

 sound/soc/codecs/twl4030.c |  286 ++++++++++++++++++++++++--------------------
 sound/soc/codecs/twl4030.h |    2 +
 2 files changed, 157 insertions(+), 131 deletions(-)
