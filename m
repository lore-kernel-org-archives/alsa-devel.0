From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/5] ASoC: twl6040: Updates for 3.9
Date: Fri, 11 Jan 2013 17:00:58 +0100
Message-ID: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BEA264FF6
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam,

Changes since v1:
- patch 2 for twl6040_resume() has been replaced with a simpler one

Cover letter from v1:

Small fixe from Misael for twl6040 codec driver and devm_* conversion, switch
to system workqueue and dead code removal.

Regards,
Peter
---
Misael Lopez Cruz (1):
  ASoC: twl6040: Convert PLUGINT to no-suspend irq

Peter Ujfalusi (4):
  ASoC: twl6040: Only set the bias_level once in twl6040_resume()
  ASoC: twl6040: Convert to use devm_* when possible
  ASoC: twl6040: Switch to use system workqueue for jack reporting
  ASoC: twl6040: Remove leftover code from hs/hf ramp implementation

 sound/soc/codecs/twl6040.c | 62 +++++++---------------------------------------
 1 file changed, 9 insertions(+), 53 deletions(-)

-- 
1.8.1
