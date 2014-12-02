From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 0/2] fsl_ssi misc fix
Date: Tue, 2 Dec 2014 14:55:05 +0900
Message-ID: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, festevam@gmail.com, lars@metafoo.de, arnd@arndb.de, broonie@kernel.org, mpa@pengutronix.de
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi,

Changes in v2:
	- fix error path in probe
	- replace irq_of_parse_and_map with platform_get_irq

Changes in v1:
	- free IRQ before irq_dispose_mapping

Jiada Wang (2):
  ASoC: fsl_ssi: fix error path in probe
  ASoC: fsl_ssi: use platform_get_irq instead of irq_of_parse_and_map

 sound/soc/fsl/fsl_ssi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
1.9.3
