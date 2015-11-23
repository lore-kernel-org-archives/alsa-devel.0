From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: core: dapm more updates
Date: Mon, 23 Nov 2015 21:22:28 +0530
Message-ID: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BB8A26581B
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:48:43 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This series contains three updates we have for dapm

First marks the SND_SOC_BYTES_EXT as deprecated as discussed

Second one adds support for dapm sink widget. This is useful in DSP based
systems where a module can act as a sink of data

Last changes order of power state to before rechecking endpoint. This ensure
DAPM is restored properly before userspace can access the card.

Jeeja KP (1):
  ASoC: core: Change power state before rechecking endpoint

Vinod Koul (2):
  ASoC: core: mark SND_SOC_BYTES_EXT as deprecated
  ASoC: core: add a dapm sink widget

 include/sound/soc-dapm.h | 4 ++++
 include/sound/soc.h      | 3 +++
 sound/soc/soc-core.c     | 6 +++---
 sound/soc/soc-dapm.c     | 5 +++++
 4 files changed, 15 insertions(+), 3 deletions(-)

-- 
1.9.1
