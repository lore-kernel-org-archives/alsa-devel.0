From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tlv320dac33 fixes
Date: Thu, 11 Mar 2010 16:26:20 +0200
Message-ID: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E9187103905
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 15:26:42 +0100 (CET)
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

Revisiting the start/stop sequence used by the tlv320dac33 codec in
order to avoid race conditions, which can occur, when the codec is in
FIFO modes.
It has been found that OMAP3 McBSP needs the BCLK continuously running
on the serial interface when it is configured to be slave.
DAC33 can be configured in a way, that it keeps the BCLK ticking, and
only enable the FS when it is needed.
Option for the platform data to select between continuous BCLK or non
continuous BCLK.

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: Start/stop sequence change
  ASoC: tlv320dac33: Add option for keeping the BCLK running

 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   38 ++++++++++++++------------------------
 2 files changed, 15 insertions(+), 24 deletions(-)
