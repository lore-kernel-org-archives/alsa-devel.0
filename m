From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: davinci-mcasp/evm: PM related changes
Date: Thu, 30 Jan 2014 15:21:29 +0200
Message-ID: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 3616E265378
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:21:37 +0100 (CET)
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

Hi,

In order to be able to benefit from the core's feature to handle the dai pinctrl
default/sleep states the davinci-evm should set it's .pm section snd_soc_pm_ops.

In the McASP driver consolidate the pm_runtime use to avoid unbalanced
refcounting: trigger:start increased while trigger:stop did not decreased the
pm counter.
Move the pm callbacks from platfrom device to the soc_dai_driver.

Now it is only a matter of dts update to enable the pin level power saving for
McASP.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: davinci-mcasp: Consolidate pm_runtime_get/put() use in the
    driver
  ASoC: davinci-evm: Add pm callbacks to platform driver
  ASoC: davinci-mcasp: Move pm callbacks from platform device to
    soc_dai_driver

 sound/soc/davinci/davinci-evm.c   |  1 +
 sound/soc/davinci/davinci-mcasp.c | 97 +++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 51 deletions(-)

-- 
1.8.5.3
