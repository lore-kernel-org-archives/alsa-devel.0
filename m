From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 00/10] Add Headphone Detection to
	TLV320AIC31xx Driver
Date: Thu, 7 Dec 2017 09:38:50 -0600
Message-ID: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id C12182671A3
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 16:39:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This series has the end goal of adding headphone detection to
the tlv320aic31xx driver. The first few patches are mostly cleanups.
Then a couple bug fixes I noticed. Followed by adding interrupt
handling and finally headphone detection.

Still not sure if the IRQ patch is correct, I think we have no good
way to share this IRQ line, so leaving it the way it is for now.

Thanks,
Andrew

Changes from v2:
 - Rebased on -next
 - Added delta patch for GPIO header fix
 - Split platform data remove into fwnode and pdata removal
 - Rework reset patch to print error code
 - Use snd_soc_codec_set_jack to set jack

Changes from v1:
 - Splitup the cleanup patch a bit more
 - Move the GPIO1 register fix patch before header cleanup
   so it can be taken back into stable
 - Added Acked-by
 - New patch dealing with regulator notifications
 - Various small touchups
 - Rebased on v4.15-rc1

Andrew F. Davis (10):
  ASoC: tlv320aic31xx: Fix GPIO header includes
  ASoC: tlv320aic31xx: Use fwnode APIs over raw OF calls
  ASoC: tlv320aic31xx: Remove platform data
  ASoC: tlv320aic31xx: Add MICBIAS off setting
  ASoC: tlv320aic31xx: Remove regulator notification handling
  ASoC: tlv320aic31xx: Reset registers during power up
  ASoC: tlv320aic31xx: Add short circuit detection support
  ASoC: tlv320aic31xx: Add overflow detection support
  ASoC: tlv320aic31xx: Add headphone/headset detection
  ASoC: tlv320aic31xx: Add button press detection

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   1 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |   1 +
 sound/soc/codecs/tlv320aic31xx.c                   | 263 +++++++++++++--------
 sound/soc/codecs/tlv320aic31xx.h                   |  41 +++-
 4 files changed, 196 insertions(+), 110 deletions(-)

-- 
2.15.0
