From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 0/5] ASoC: fsl_spdif: Add sysclk df support
Date: Wed, 30 Apr 2014 18:54:04 +0800
Message-ID: <cover.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 by alsa0.perex.cz (Postfix) with ESMTP id B8DF92602F3
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:52:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of patches mainly add sysclk_df support to derive tx clock
from sysclk, and meanwhile, accordingly do some additional improvements.

Nicolin Chen (5):
  ASoC: fsl_spdif: Use clk_set_rate() for spdif root clock only
  ASoC: fsl_spdif: Rename all _div to _df
  ASoC: fsl_spdif: Add sysclk df support to derive txclk from sysclk
  ASoC: fsl_spdif: Print actual sample rate for debug
  ASoc: fsl_spdif: Add descriptions for fsl_spdif_priv

 sound/soc/fsl/fsl_spdif.c | 145 ++++++++++++++++++++++++++++++++--------------
 sound/soc/fsl/fsl_spdif.h |  14 +++--
 2 files changed, 109 insertions(+), 50 deletions(-)

-- 
1.8.4
