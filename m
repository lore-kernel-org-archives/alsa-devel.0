From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tpa6130a2: Fix compiler warning
Date: Tue, 28 Dec 2010 11:16:19 +0200
Message-ID: <1293527779-32580-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id D167F10380D
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 10:16:19 +0100 (CET)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/tpa6130a2.c: In function 'tpa6130a2_add_controls':
sound/soc/codecs/tpa6130a2.c:342: warning: unused variable 'dapm'

Introduced by commit 39646871a47fd8808c08de0ce7d7ca8393af2805 ("ASoC:
tpa6130a2: Replace DAPM code with direct interface").

The DAPM code has been removed from the driver, but the
dapm struct remained.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 0a99f31..1f1ac81 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -339,7 +339,6 @@ EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
 int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 {
 	struct	tpa6130a2_data *data;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	if (tpa6130a2_client == NULL)
 		return -ENODEV;
-- 
1.7.3.4
