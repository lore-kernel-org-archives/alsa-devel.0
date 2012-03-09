From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/2] ASoC: core: Rename card mutex subclass to
	better align with usage.
Date: Fri,  9 Mar 2012 12:02:07 +0000
Message-ID: <1331294528-27350-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 4017A10BB45
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:02:21 +0100 (CET)
Received: by wgbgn7 with SMTP id gn7so1190583wgb.33
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 04:02:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Change SND_SOC_CARD_CLASS_PCM to SND_SOC_CARD_CLASS_RUNTIME to better
describe all uses for this mutex subclass and align with DAPM too.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 66fd9bc..0989987 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -289,8 +289,8 @@ enum snd_soc_pcm_subclass {
 };
 
 enum snd_soc_card_subclass {
-	SND_SOC_CARD_CLASS_INIT	= 0,
-	SND_SOC_CARD_CLASS_PCM	= 1,
+	SND_SOC_CARD_CLASS_INIT		= 0,
+	SND_SOC_CARD_CLASS_RUNTIME	= 1,
 };
 
 int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
-- 
1.7.5.4
