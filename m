From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] MFD: twl6040: Version support fixes,
	additions
Date: Mon, 16 Jul 2012 11:49:42 +0200
Message-ID: <1342432184-12046-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id EC1AC24375
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 11:50:00 +0200 (CEST)
Received: by obbuo19 with SMTP id uo19so14349933obb.39
	for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2012 02:49:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

The following series fixes the revision information for twl6040 and adds support
for twl6041.

While the first patch is changing a driver in sound/soc/codecs the series can go
via MFD since we do not have pending patches for twl6040 audio part for 3.6.

Regards,
Peter
---
Peter Ujfalusi (2):
  MFD: twl6040: Fix revision information
  MFD: twl6040: Add support for twl6041

 Documentation/devicetree/bindings/mfd/twl6040.txt |    2 +-
 drivers/mfd/twl6040-core.c                        |    1 +
 include/linux/mfd/twl6040.h                       |    5 +++--
 sound/soc/codecs/twl6040.c                        |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.7.8.6
