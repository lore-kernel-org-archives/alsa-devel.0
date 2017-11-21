From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 0/2] Update codec driver for dual mics configuration
Date: Tue, 21 Nov 2017 17:15:44 +0000
Message-ID: <20171121171546.5656-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

The RT5651 codec has 3 analog input ports. Some laptops (like the KIANO laptop)
have two different analog mics on two ports, leaving the headset on the
remaining one. We need to add a new quirk to support also this configuration.

Carlo Caione (2):
  ASoC: intel: byt: Introduce new map for dual mics
  ASoC: intel: byt: Fix quirk for KIANO laptop

 sound/soc/intel/boards/bytcr_rt5651.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.14.1
