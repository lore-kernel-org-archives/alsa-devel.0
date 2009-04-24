From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/3] ASoC: cs4270: fix Master Capture Switch
	polarity
Date: Fri, 24 Apr 2009 15:00:25 +0200
Message-ID: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D39910389D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 15:00:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The control modifies the MUTE register, hence the polarity must be
inverted.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@sirena.org.uk>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 7fa09a3..3c34fe6 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -486,7 +486,7 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_SINGLE("Zero Cross Switch", CS4270_TRANS, 5, 1, 0),
 	SOC_SINGLE("Popguard Switch", CS4270_MODE, 0, 1, 1),
 	SOC_SINGLE("Auto-Mute Switch", CS4270_MUTE, 5, 1, 0),
-	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 0)
+	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1)
 };
 
 /*
-- 
1.6.2.1
