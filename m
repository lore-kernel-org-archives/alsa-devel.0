From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring and
	Headset pop-attenuation fix
Date: Mon, 18 May 2009 16:02:03 +0300
Message-ID: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 608E5103844
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 15:02:43 +0200 (CEST)
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

The following series aims to fix the Headset power on/off pop noise problems.

Since the twl4030 codec internal implementation have this order in HW:
DAC -> Analog PGA -> Mixer

While the ASoC framework expects the following order:
DAC -> Mixer -> Analog PGA

I needed to move the APGA control from SND_SOC_DAPM_PGA to be handled with
_MIXER. Than adding a PGA to the headset outputs results correct power
sequences.

This patch also separates the analog and digital loopback paths, so when the
analog loopback is enabled none of the DACs will be powered on, while in case
of digital loopback the corresponding DACs will be powered.

These are internal changes, not visible for the user. I have tested it with my
custom board with the headset soldered to HeadsetL, the pop noise is really small
if any.

The user must also set the correct ramp delay for the given board.
On my board:
MCLK = 38.4MHz
RAMP_DELAY = 2 (109/81/55 ms) works best (meaning 55ms ramp
delay), if it is shorter, than it clicks, if it is longer, than it does not
click, but the beep tone can be observed.

I hope that I have not missed anything with the patches, since these are forward
ported from my working tree to sound-2.6:topic/asoc.

I have applied the patch from Misael on top of the current topic/asoc, so the
head was:
ASoC: TWL4030: Enable/disable voice digital filters

I believe that this should be able to minimize the pop noise on the headset
outputs.

---
Peter Ujfalusi (2):
  ASoC: TWL4030: Change DAPM routings and controls for DACs and PGAs
  ASoC: TWL4030: Move the Headset pop-attenuation code to PGA event

 sound/soc/codecs/twl4030.c |  257 ++++++++++++++++++++++++++++----------------
 1 files changed, 162 insertions(+), 95 deletions(-)
