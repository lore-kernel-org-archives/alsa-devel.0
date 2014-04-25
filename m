From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 0/2] Fix rxclk rate measurement
Date: Fri, 25 Apr 2014 19:58:18 +0800
Message-ID: <cover.1398427055.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 by alsa0.perex.cz (Postfix) with ESMTP id D596D261A12
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:56:41 +0200 (CEST)
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

Add sysclk clock so as to calculate the rxclk rate correctly

Nicolin Chen (2):
  ASoC: fsl_spdif: Fix clock source for rxclk rate measurement
  ASoC: fsl_spdif: Drop hard code in clk_get() for rxclk

 sound/soc/fsl/fsl_spdif.c | 17 ++++++++++++++---
 sound/soc/fsl/fsl_spdif.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
1.8.4
