From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 0/3] fix build error/warning in sound/soc/fsl
Date: Mon, 18 Aug 2014 16:38:37 +0800
Message-ID: <cover.1408350626.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C9052654B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 10:39:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, shengjiu.wang@freescale.com, xobs@kosagi.com, arnd@arndb.de, sfr@canb.auug.org.au, timur@tabi.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This series patch is for fixing build error/waring in sound/soc/fsl

Shengjiu Wang (3):
  ASoC: fsl: Kconfig: remove dependence of SND_IMX_SOC for
    SND_SOC_IMX_PCM_DMA
  ASoC: fsl-asoc-card: Fix build warning for maybe-uninitialized
  ASoC: fsl: fsl-asoc-card: Select SND_SOC_IMX_AUDMUX

 sound/soc/fsl/Kconfig         |    9 +++++----
 sound/soc/fsl/fsl-asoc-card.c |    9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.7.9.5
