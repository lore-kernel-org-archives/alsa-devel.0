From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/2] ASoC: core: volume control using signed
	register values
Date: Thu, 16 Jan 2014 16:02:09 +0100
Message-ID: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 624BE261723
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:02:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

There are a lot of codecs using negative and positive volume control ranges as
values in their registers. These two patches add support for arbitrary size
signed integer values in registers.

Regards,

Markus


Markus Pargmann (2):
  ASoC: core: Add signed register volume control logic
  ASoC: soc.h: Add SOC_DOUBLE_R_S_TLV

 include/sound/soc.h  | 15 ++++++++++++
 sound/soc/soc-core.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 7 deletions(-)

-- 
1.8.5.2
