From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/3 take2] ASoC: TWL4030: Handsfree pop removal
	and mute
Date: Mon, 25 May 2009 11:12:10 +0300
Message-ID: <1243239133-18996-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA3D103836
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 10:12:20 +0200 (CEST)
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

Changes: REG_SW_SHADOW = 0x4A (instead of 0x50)

The following series fixes the HandsfreeL/R pop removal sequence:
The pop removal is moved from the MUX_E to PGA_E DAPM control and also
the sequence is modified to match with the sequence described in the TRM.
Note, that the power-down sequence is not described in the TRM, it has been
implemented in a way that it should make sense.

HandsetL/R mute: Since all bits are needed for the pop removal and they have to
modified in a strict order/timing:
I have added SW_SHADOW non HW register. This register at the moment only handles
the HandsfreeL/R mute.

---
Peter Ujfalusi (3):
  ASoC: TWL4030: Handsfree pop removal redesign
  ASoC: TWL4030: Add shadow register
  ASoC: TWL4030: HandsfreeL/R mute DAPM switch

 sound/soc/codecs/twl4030.c |   99 +++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/twl4030.h |    7 +++-
 2 files changed, 85 insertions(+), 21 deletions(-)
