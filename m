From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/4] ASoC: TWL4030: Gain control updates,
	adding pre-DAC routing controls
Date: Mon,  1 Dec 2008 10:03:44 +0200
Message-ID: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DB89C1037EC
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 09:04:11 +0100 (CET)
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

This series adds 'proper' gain controls for:
Per-DAC common gain controls.
There are three gain controls asspciated wit a DAC in TWL,
There are four DAC can be used (in OPT_MODE=1).
Digital fine gain, Digital coarse gain, Analog gain.

Every output, except the HandsFree has their own gain controls
per channel (L/R)

Pre-DAC routings:
Digital input namings:
SDRL1: TDM #1
SDRR1: TDM #2
SDRL2: TDM #3, I2S Left
SDRR2: TDM #4, I2S Right

Mono mixing:
SDRM1: mixed SDRL1 and SDRR1
SDRM2: mixed SDRL2 and SDRR2

The possible mux settings for the DAC inputs:
DACL1 <- SDRL1, SDRM1, SDRM2, SDRL2
DACR1 <- SDRR1, SDRM1, SDRM2, SDRR2
DACL2 <- SDRL2, SDRM2
DACR2 <- SDRR2, SDRM2


---
Peter Ujfalusi (4):
 ASoC: TWL4030: Change the capture volume control to TLV
 ASoC: TWL4030: Change the common playback volume controls
 ASoC: TWL4030: Add volume controls for outputs
 ASoC: TWL4030: Add pre-DAC digital mux controls

 sound/soc/codecs/twl4030.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
