From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/9] ASoC: TWL4030: DAPM implementation for
	outputs (playback) - try3
Date: Tue,  9 Dec 2008 12:35:43 +0200
Message-ID: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 335B4103844
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:35:58 +0100 (CET)
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
Cc: sakoman@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

The whole series again, altrough 1 and 2 has been accepted already.

This series of patches (try3) adds DAPM implementation for all outputs
found on TWL.

The design allows one to configure all outputs independently from
each other, since the internal routing of TWL actually treats them
individually.

The pre-DAC routings can be configured in the board specific files
of needed. I have sent a patch which has added this to the codec driver.

Based on the output routing selections all the corresponding DAC and
analog PGA on the chain will be powered on.

Remove the Headset output gain modifications from the twl4030_power_up
and twl4030_power_down function, since they are not needed.

Changes since try1 (comments addressed):
- Removed the " Switch" from the option texts and also from the intercon.

---
Peter Ujfalusi (9):
 ASoC: TWL4030: Correct DAPM_DAC with power control
 ASoC: TWL4030: Add Analog PGA control switch to DAPM
 ASoC: TWL4030: Add DAPM event handler for output MUX selection
 ASoC: TWL4030: DAPM mapping of the Earpiece output
 ASoC: TWL4030: DAPM mapping of the PreDriv outputs
 ASoC: TWL4030: DAPM mapping of the Headset outputs
 ASoC: TWL4030: DAPM mapping of the Carkit outputs
 ASoC: TWL4030: DAPM mapping of the Handsfree outputs
 ASoC: TWL4030: Do not alter the Headset output volume on power-up/down

 sound/soc/codecs/twl4030.c |  263 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 248 insertions(+), 15 deletions(-)
