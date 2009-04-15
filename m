From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: OMAP: Finalizing the DSP mode support
Date: Wed, 15 Apr 2009 15:38:54 +0300
Message-ID: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B70E1038CD
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 14:39:02 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Hello,

This series should finally got both DSP_A and DSP_B modes working correctly
on OMAP platforms.
Big thanks goes to Jarkko to get (and test) the DSP_B mode in a good shape.

But, the DSP modes should use single-phase mode instead of the dual-phase mode,
which is intended to be used with I2S, Left-justified, Right-justified modes.

The second patch adds DSP_A mode support to omap-mcbsp.

---
Peter Ujfalusi (2):
  ASoC: OMAP: Use single-phase for DSP mode
  ASoC: OMAP: Add DSP_A mode support for mcbsp

 sound/soc/omap/omap-mcbsp.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)
