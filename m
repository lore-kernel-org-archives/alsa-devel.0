From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/5] ASoC: tlv320dac33: Adding new FIFO mode
Date: Thu, 31 Dec 2009 10:30:18 +0200
Message-ID: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E195103891
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:30:36 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

the following series adds new FIFO operating mode to the tlv320dac33 codec
driver.
To be able to add new FIFO mode the code has to be restructured in order to
keep it readable after the new mode is added.
Since both of the support FIFO mode in the driver needs the codec to be the
master, an additional check is added to avoid misconfiguration.

---
Peter Ujfalusi (5):
  ASoC: tlv320dac33: Change nsample switch to FIFO mode enum
  ASoC: tlv320dac33: Introduce prefill and playback state handlers
  ASoC: tlv320dac33: Clean up the hardware configuration code
  ASoC: tlv320dac33: Add new FIFO mode: mode 7
  ASoC: tlv320dac33: Safety check for codec slave mode

 sound/soc/codecs/tlv320dac33.c |  190 ++++++++++++++++++++++++++++++++--------
 1 files changed, 153 insertions(+), 37 deletions(-)
