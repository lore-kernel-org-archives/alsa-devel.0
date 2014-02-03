From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: davinci-mcasp: Cleanup patches
Date: Mon, 3 Feb 2014 14:51:49 +0200
Message-ID: <1391431912-31653-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D2A260815
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 13:51:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The first patch in this series is the one which did not applied cleanly from my
previous series. The other two is just generic code cleanup patches.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: davinci-mcasp: Code cleanup in davinci_mcasp_hw_params()
  ASoC: davinci-mcasp: Rename platform data struct
  ASoC: davinci-mcasp: Remove long lines from suspend/resume callbacks

 include/linux/platform_data/davinci_asp.h |  4 +-
 sound/soc/davinci/davinci-mcasp.c         | 86 +++++++++++++++----------------
 2 files changed, 46 insertions(+), 44 deletions(-)

-- 
1.8.5.3
