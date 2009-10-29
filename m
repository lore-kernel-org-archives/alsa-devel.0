From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: CS4270: export de-emphasis filter
	as ALSA control
Date: Thu, 29 Oct 2009 02:24:32 +0100
Message-ID: <1256779472-30754-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E177A24423
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 02:25:44 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The CS4270 codec features an de-emphasis filter for compensation of
audio material filtered by an 50/15 uS algorithm. Not sure whether we
should always enable it for 44100Hz sampling frequency, but it should at
least be configurable by the user.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index ca1e24a..8069023 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -520,6 +520,7 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_SINGLE("Digital Sidetone Switch", CS4270_FORMAT, 5, 1, 0),
 	SOC_SINGLE("Soft Ramp Switch", CS4270_TRANS, 6, 1, 0),
 	SOC_SINGLE("Zero Cross Switch", CS4270_TRANS, 5, 1, 0),
+	SOC_SINGLE("De-emphasis filter", CS4270_TRANS, 0, 1, 0),
 	SOC_SINGLE("Popguard Switch", CS4270_MODE, 0, 1, 1),
 	SOC_SINGLE("Auto-Mute Switch", CS4270_MUTE, 5, 1, 0),
 	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1),
-- 
1.6.5
