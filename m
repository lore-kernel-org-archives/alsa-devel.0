From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3] ASoC: tlv320dac33: Cleanup,
	and 32/24 bit support
Date: Wed, 22 Dec 2010 10:45:15 +0200
Message-ID: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A6A17103877
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 09:45:20 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

the following series adds 32/24 bit support for DAC33 codec.
The manual FIFO configuration code will be removed, since that
was mainly used for initial debugging, and with the 24 bit support
the FIFO sizes are different, so it would be pain to safe guard
the manual FIFO settings for both 16, and 24 bit modes.

---
Peter Ujfalusi (3):
  ASoC: tlv320dac33: Remove manual FIFO configuration
  ASoC: tlv320dac33: Some cleanup for 32/24 bit support
  ASoC: tlv320dac33: Add 32/24 bit audio support

 sound/soc/codecs/tlv320dac33.c |  214 +++++++++++-----------------------------
 1 files changed, 58 insertions(+), 156 deletions(-)

-- 
1.7.3.4
