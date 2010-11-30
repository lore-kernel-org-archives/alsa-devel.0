From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/5] ASoC: tpa6130a2: pop removal (mostly)
	changes
Date: Tue, 30 Nov 2010 15:59:59 +0200
Message-ID: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1B3103811
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:00:12 +0100 (CET)
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

The following series improves the tpa driver to have better
pop filtering capabilities.
New stereo DAPM route can be used to reduce left/right power
time differences.
Machine drivers can opt to not use the built in DAPM routes, and
use direct call to enable the stereo path.

---
Peter Ujfalusi (5):
  ASoC: tpa6130a2: Simplify power state management
  ASoC: tpa6130a2: Defer SW enable from power enable
  ASoC: tpa6130a2: Use one event handler for PGA_E
  ASoC: tpa6130a2: Add stereo DAPM path
  ASoC: tpa6130a2: Make DAPM registration optional, and direct
    interface

 sound/soc/codecs/tpa6130a2.c |   77 ++++++++++++++++++++++++------------------
 sound/soc/codecs/tpa6130a2.h |    3 +-
 2 files changed, 46 insertions(+), 34 deletions(-)

-- 
1.7.3.2
