From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8996: Use SND_SOC_DAPM_AIF_OUT for
	AIF2 Capture
Date: Thu, 20 Oct 2011 12:16:31 +0800
Message-ID: <1319084191.12737.2.camel@phoenix>
References: <1319084004.12737.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 789C2103890
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 06:16:38 +0200 (CEST)
Received: by yxi13 with SMTP id 13so2397706yxi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 21:16:37 -0700 (PDT)
In-Reply-To: <1319084004.12737.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8996.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 43e46c7..1d7b174 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1113,9 +1113,9 @@ SND_SOC_DAPM_AIF_IN("AIF2RX1", "AIF2 Playback", 0,
 SND_SOC_DAPM_AIF_IN("AIF2RX0", "AIF2 Playback", 1,
 		    WM8996_POWER_MANAGEMENT_4, 8, 0),
 
-SND_SOC_DAPM_AIF_IN("AIF2TX1", "AIF2 Capture", 0,
+SND_SOC_DAPM_AIF_OUT("AIF2TX1", "AIF2 Capture", 0,
 		    WM8996_POWER_MANAGEMENT_6, 9, 0),
-SND_SOC_DAPM_AIF_IN("AIF2TX0", "AIF2 Capture", 1,
+SND_SOC_DAPM_AIF_OUT("AIF2TX0", "AIF2 Capture", 1,
 		    WM8996_POWER_MANAGEMENT_6, 8, 0),
 
 SND_SOC_DAPM_AIF_IN("AIF1RX5", "AIF1 Playback", 5,
-- 
1.7.5.4
