From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: omap-mcpdm: Fix for full duplex audio
Date: Wed, 20 Mar 2013 10:47:11 +0100
Message-ID: <1363772834-29820-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DC732616E3
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 10:47:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

We had this issue for a long time but I had no time to think and fix it.
With this series the full duplex audio will work correctly with McPDM.

Under the hood we have HW limitation which prevents us to start up/downlink
separately.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: omap-mcpdm: Collect link direction configuration under a struct
  ASoC: omap-mcpdm: Fix for full duplex audio use case
  ASoC: omap-mcpdm: Remove leftower define for IO address

 sound/soc/omap/omap-mcpdm.c | 66 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 18 deletions(-)

-- 
1.8.1.5
