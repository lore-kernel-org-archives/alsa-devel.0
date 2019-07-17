From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/3] i.MX8M support for FSL SAI
Date: Wed, 17 Jul 2019 12:56:32 +0200
Message-ID: <20190717105635.18514-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AC27F8015B
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 12:56:40 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Angus Ainslie <angus@akkea.ca>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi all,

those are the changes that are absolutely needed to support the i.MX8M
SAI block. The most noticable difference is the moved register layout,
due to the hardware guys adding two version registers at the start of
the register map and considerable bigger FIFO sizes.

Downstream has a lot more changes to support new features, but those
3 patches at least allows me to play back audio on i.MX8M based
systems.

Regards,
Lucas

Lucas Stach (3):
  ASoC: fsl_sai: add of_match data
  ASoC: fsl_sai: derive TX FIFO watermark from FIFO depth
  ASoC: fsl_sai: add i.MX8M support

 .../devicetree/bindings/sound/fsl-sai.txt     |  2 +-
 sound/soc/fsl/fsl_sai.c                       | 45 +++++++++++++++----
 sound/soc/fsl/fsl_sai.h                       |  8 +++-
 3 files changed, 44 insertions(+), 11 deletions(-)

-- 
2.20.1
