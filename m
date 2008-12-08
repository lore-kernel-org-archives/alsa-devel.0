From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/8] ASoC: TWL4030: DAPM implementation for
	outputs (playback)
Date: Mon,  8 Dec 2008 10:09:00 +0200
Message-ID: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CFC2C103811
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 09:09:14 +0100 (CET)
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

This series of patches adds DAPM implementation for all outputs
found on TWL.

The design allows one to configure all outputs independently from
each other, since the internal routing of TWL actually treats them
individually.

The pre-DAC routings can be configured in the board specific files
of needed. I have sent a patch which has added this to the codec driver.

Based on the output routing selections all the corresponding DAC and
analog PGA on the chain will be powered on.

---
Peter Ujfalusi (8):
 ASoC: TWL4030: Correct DAPM_DAC with power control
 ASoC: TWL4030: Add Analog PGA control switch to DAPM
 ASoC: TWL4030: Add DAPM event handler for output MUX selection
 ASoC: TWL4030: DAPM mapping of the Earpiece output
 ASoC: TWL4030: DAPM mapping of the PreDriv outputs
 ASoC: TWL4030: DAPM mapping of the Headset outputs
 ASoC: TWL4030: DAPM mapping of the Carkit outputs
 ASoC: TWL4030: DAPM mapping of the Handsfree outputs

 sound/soc/codecs/twl4030.c |  248 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 243 insertions(+), 5 deletions(-)
