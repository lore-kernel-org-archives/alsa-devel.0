From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/4] Convert to use regmap framework's
	endianness method.
Date: Mon, 18 Aug 2014 14:52:18 +0800
Message-ID: <1408344742-28701-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 by alsa0.perex.cz (Postfix) with ESMTP id A12D32654BD
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 08:56:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, timur@tabi.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


Xiubo Li (4):
  ASoC: fsl-spdif: Convert to use regmap framework's endianness method.
  ASoC: fsl-esai: Convert to use regmap framework's endianness method.
  ASoC: fsl-sai: Convert to use regmap framework's endianness method.
  ASoC: fsl-sai: rename big_endian_data to is_msb_first.

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 16 ++++++++--------
 sound/soc/fsl/fsl_esai.c                            |  3 ---
 sound/soc/fsl/fsl_sai.c                             | 10 +++-------
 sound/soc/fsl/fsl_sai.h                             |  3 +--
 sound/soc/fsl/fsl_spdif.c                           |  3 ---
 5 files changed, 12 insertions(+), 23 deletions(-)

-- 
1.8.5
