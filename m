From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tlv320dac33: Burst mode BCLK divider
	fixes
Date: Wed, 20 Jan 2010 09:39:34 +0200
Message-ID: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 387911038E3
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 08:42:22 +0100 (CET)
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

The following patches provides fixes for the BCLK clock divider configuration
in tlv320dac33 codec.
BCLK divider is used to specify the speed of the serial bus.
The speed of the bus can be (must be) faster than the actual stream's
sample rate in order to use the system in burst mode.

With the introduction of mode7 FIFO mode, the BCLK handling got broken in this
mode, the first patch fixes this issue.
The second patch adds support for configuring the burst mode BCLK through
platform data.

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: BCLK divider fix
  ASoC: tlv320dac33: Burst mode BCLK divider configuration

 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)
