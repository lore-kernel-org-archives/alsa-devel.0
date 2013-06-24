From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: twl6040: Fixes and updates
Date: Mon, 24 Jun 2013 15:42:02 +0200
Message-ID: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 845192625CE
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 15:42:11 +0200 (CEST)
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi,

Updates for the twl6040 codec:
- Fix soc probe when the machine driver is removed and loaded again without
  removing the codec driver (was failing since the IRQ has been already
  requested)
- Playback pop noise reduction on stream start and stop with implementing the
  digital_mute callback and related tracking of the mute for different paths.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: twl6040: Drop using devm_request_threaded_irq()
  MFD: twl6040: Update register bit definitions
  ASoC: twl6040: Assign id for each DAI
  ASoC: twl6040: Add digital mute support

 include/linux/mfd/twl6040.h |   7 +++
 sound/soc/codecs/twl6040.c  | 109 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 2 deletions(-)

-- 
1.8.2.1
