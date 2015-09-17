From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 0/3] fsl esai/spdif/asrc need spba clock
Date: Thu, 17 Sep 2015 14:09:22 +0800
Message-ID: <cover.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0120.outbound.protection.outlook.com [207.46.100.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CF53A2619D7
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 08:09:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

fsl esai/spdif/asrc need spba clock

Shengjiu Wang (3):
  ASoC: fsl_esai: spba clock is needed by esai device
  ASoC: fsl_spdif: spba clk is needed by spdif device
  ASoC: fsl_asrc: spba clock is needed by asrc device

 Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 sound/soc/fsl/fsl_asrc.c                              | 12 ++++++++++++
 sound/soc/fsl/fsl_asrc.h                              |  1 +
 sound/soc/fsl/fsl_esai.c                              | 13 +++++++++++++
 sound/soc/fsl/fsl_spdif.c                             | 15 +++++++++++++++
 7 files changed, 47 insertions(+)

-- 
1.9.1
