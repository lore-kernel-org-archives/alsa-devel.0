From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Avoid a redundant read in
	cs42l51_pdn_event
Date: Tue, 01 Nov 2011 15:17:57 +0800
Message-ID: <1320131877.5541.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 74B8724913
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 08:18:08 +0100 (CET)
Received: by ggnk1 with SMTP id k1so8193579ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2011 00:18:07 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

snd_soc_update_bits already does read-modify-write,
no need to read the register before calling snd_soc_update_bits.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l51.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 8c3c820..00718b5 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -175,21 +175,18 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 static int cs42l51_pdn_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
-	unsigned long value;
-
-	value = snd_soc_read(w->codec, CS42L51_POWER_CTL1);
-	value &= ~CS42L51_POWER_CTL1_PDN;
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMD:
-		value |= CS42L51_POWER_CTL1_PDN;
+		snd_soc_update_bits(w->codec, CS42L51_POWER_CTL1,
+				    CS42L51_POWER_CTL1_PDN,
+				    CS42L51_POWER_CTL1_PDN);
 		break;
 	default:
 	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(w->codec, CS42L51_POWER_CTL1,
+				    CS42L51_POWER_CTL1_PDN, 0);
 		break;
 	}
-	snd_soc_update_bits(w->codec, CS42L51_POWER_CTL1,
-		CS42L51_POWER_CTL1_PDN, value);
 
 	return 0;
 }
-- 
1.7.5.4
