From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Ignore VMID widgets for target bias
Date: Sat,  5 Oct 2013 19:26:17 +0200
Message-ID: <1380993977-1037-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-108.synserver.de (smtp-out-108.synserver.de
 [212.40.185.108])
 by alsa0.perex.cz (Postfix) with ESMTP id EBCCD2616FB
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 19:24:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

VMID widgets behave very similar to signal generator widgets. Both are always
considered to be powered up. This means that we need to ignore the VMID widgets
in the same way as signal generator widgets when calculating the DAPM context's
target bias level. Otherwise the presence of a VMID widget, regardless whether
it is on an active path or not, will cause the DAPM context to be powered up.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c17c14c..177f8a1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1840,6 +1840,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 			 */
 			switch (w->id) {
 			case snd_soc_dapm_siggen:
+			case snd_soc_dapm_vmid:
 				break;
 			case snd_soc_dapm_supply:
 			case snd_soc_dapm_regulator_supply:
-- 
1.8.0
