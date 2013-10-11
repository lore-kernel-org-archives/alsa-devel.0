From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/3] ASoC: mxs-saif error handling
Date: Fri, 11 Oct 2013 12:11:01 +0200
Message-ID: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DA219265665
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:11:55 +0200 (CEST)
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
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

This series contains error handling patches for mxs-saif. The first patch is
a comment about the possible command sequence of trigger functions.

Regards,

Markus Pargmann


Markus Pargmann (3):
      ASoC: snd_soc_dai_ops trigger function description
      ASoC: mxs-saif: Store saif state
      ASoC: mxs-saif: Handle errors in trigger function

 include/sound/soc-dai.h  |  7 +++++++
 sound/soc/mxs/mxs-saif.c | 30 +++++++++++++++++++++++++-----
 sound/soc/mxs/mxs-saif.h |  5 +++++
 3 files changed, 37 insertions(+), 5 deletions(-)
