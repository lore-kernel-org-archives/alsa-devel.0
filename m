From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8991: Fix wrong bit setting for
 WM8991_POWER_MANAGEMENT_2
Date: Fri, 14 Oct 2011 12:08:00 +0800
Message-ID: <1318565280.10049.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 35713243A2
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 06:08:12 +0200 (CEST)
Received: by gyg8 with SMTP id 8so771823gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 21:08:09 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If (fakepower & ((1 << WM8991_INMIXR_PWR_BIT)|(1 << WM8991_AINRMUX_PWR_BIT))))
is false, we should clear WM8991_AINR_ENA bits instead of WM8991_AINL_ENA.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8991.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 08d64a6..708d251 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -393,7 +393,7 @@ static int inmixer_event(struct snd_soc_dapm_widget *w,
 			 (1 << WM8991_AINRMUX_PWR_BIT)))
 		reg |= WM8991_AINR_ENA;
 	else
-		reg &= ~WM8991_AINL_ENA;
+		reg &= ~WM8991_AINR_ENA;
 
 	snd_soc_write(w->codec, WM8991_POWER_MANAGEMENT_2, reg);
 	return 0;
-- 
1.7.4.1
