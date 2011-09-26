From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/10] ASoC: twl6040: Gain ramp code cleanups
Date: Mon, 26 Sep 2011 16:26:23 +0300
Message-ID: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B8AF243AB
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:47 +0200 (CEST)
Received: by bkbzs2 with SMTP id zs2so5840175bkb.28
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:43 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

the following series cleans up the gain ramp code found in the twl6040 codec
driver.
Main changes:
- use one workqueue for the twl6040 codec driver (instead of the original 3)
- Delays between the steps does not need to be different among the range.
  I assume, that the original code contained copy-paste snippets from wm8350
  for this part
- Cleanups for the DAPM_OUT_DRV_E event handler code.
- delayed_works moved within their corresponding struct.

The series has been generated on top of:
git://opensource.wolfsonmicro.com/linux-2.6-asoc,
for-3.2 branch + ASoC: omap-mcpdm/twl6040: Offset cancellation series.

Side note: I have done this to better understand (while cleaning up the
twl6040 driver) the requirements for the ramp code, and to study the
possibility of adding support in the core for this (to handle the wm8350, and
twl6040 in a generic way later).
I'm still looking at the optimal implementation without ending up with too
complicated code/structures...

Regards,
Peter
---
Peter Ujfalusi (10):
  ASoC: twl6040: Rename pga_event to out_drv_event
  ASoC: twl6040: Combine the custom volsw get, and put functions
  ASoC: twl6040: Move delayed_work struct inside twl6040_output for
    HS/HF
  ASoC: twl6040: Move the delayed_work for HS detection under
    twl6040_jack_data
  ASoC: twl6040: One workqueue should be enough
  ASoC: twl6040: correct loop counters for HS/HF ramp code
  ASoC: twl6040: No need to change delay during HS ramp
  ASoC: twl6040: No need to change delay during HF ramp
  ASoC: twl6040: Shift 2 identifies the HS output in out_drv_event
  ASoC: twl6040: Simplify code in out_drv_event for pending work check

 sound/soc/codecs/twl6040.c |  203 ++++++++++++-------------------------------
 1 files changed, 57 insertions(+), 146 deletions(-)

-- 
1.7.6.1
