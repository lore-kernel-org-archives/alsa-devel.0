From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND v2 0/4] Cleanups/Bugfixes and DT Prep
	for CS42L52
Date: Fri, 25 Oct 2013 10:01:13 -0500
Message-ID: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C31265601
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 16:59:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series fixes a bug and cleans up the platform data so the driver can nicely move to DT.

Convert platform data initialization to regmap_update_bits in i2c_probe.
Add GPIO for CODEC Reset.
Add print message for Rev ID.

Version 2 splits the regmap_patch bug with the MAX_REGISTER increase.
Series based off of a clean for-next branch

Brian Austin (4):
  ASoC: cs42l52: Add platform data for reset gpio
  ASoC: cs42l52: increase MAX_REGISTER for regmap_register_patch
  ASoC: cs42l52: convert pdata config to regmap_update_bits
  ASoC: cs42l52: Add chip rev id message

 include/sound/cs42l52.h    |  2 +
 sound/soc/codecs/cs42l52.c | 93 +++++++++++++++++++++++++++-------------------
 sound/soc/codecs/cs42l52.h |  2 +-
 3 files changed, 57 insertions(+), 40 deletions(-)

-- 
1.8.4.rc3
