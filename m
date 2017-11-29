From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 00/19] Add Headphone Detection to
	TLV320AIC31xx Driver
Date: Wed, 29 Nov 2017 15:32:41 -0600
Message-ID: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id B4A8C267957
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

This series has the end goal of adding headphone detection to
the tlv320aic31xx driver. The first few patches are mostly cleanups.
Then a couple bug fixes I noticed. Followed by adding interrupt
handling and finally headphone detection.

This series (or at least patch #8) depend on this DT fix[0].

Thanks,
Andrew

Changes from v1:
 - Splitup the cleanup patch a bit more
 - Move the GPIO1 register fix patch before header cleanup
   so it can be taken back into stable
 - Added Acked-by
 - New patch dealing with regulator notifications
 - Various small touchups
 - Rebased on v4.15-rc1 + [0]

[0] http://www.spinics.net/lists/kernel/msg2660968.html

Andrew F. Davis (19):
  ASoC: tlv320aic31xx: File header and copyright cleanup
  ASoC: tlv320aic31xx: Change aic31xx_power_off return type to void
  ASoC: tlv320aic31xx: Move ACPI table next to OF table
  ASoC: tlv320aic31xx: General source formatting cleanup
  ASoC: tlv320aic31xx: Fix GPIO1 register definition
  ASoC: tlv320aic31xx: Reformat header file using GENMASK and BIT macros
  ASoC: tlv320aic31xx: Merge init function into probe
  ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API
  ASoC: tlv320aic31xx: Remove platform data
  ASoC: tlv320aic31xx: Add MICBIAS off setting
  ASoC: tlv320aic31xx: Check clock and divider before division
  ASoC: tlv320aic31xx: Add CODEC clock slave support
  ASoC: tlv320aic31xx: Fix inverted BCLK handling
  ASoC: tlv320aic31xx: Remove regulator notification handling
  ASoC: tlv320aic31xx: Reset registers during power up
  ASoC: tlv320aic31xx: Add short circuit detection support
  ASoC: tlv320aic31xx: Add overflow detection support
  ASoC: tlv320aic31xx: Add headphone/headset detection
  ASoC: tlv320aic31xx: Add button press detection

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   1 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |   1 +
 sound/soc/codecs/tlv320aic31xx.c                   | 422 ++++++++++--------
 sound/soc/codecs/tlv320aic31xx.h                   | 496 ++++++++++-----------
 4 files changed, 471 insertions(+), 449 deletions(-)
 rewrite sound/soc/codecs/tlv320aic31xx.h (83%)

-- 
2.15.0
