From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8400: Fix wrong bit setting for
 WM8400_POWER_MANAGEMENT_2
Date: Fri, 14 Oct 2011 13:56:49 +0800
Message-ID: <1318571809.4610.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.213.177])
	by alsa0.perex.cz (Postfix) with ESMTP id CEFBE24465
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 07:57:01 +0200 (CEST)
Received: by yxk36 with SMTP id 36so486802yxk.22
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 22:57:00 -0700 (PDT)
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

If (fakepower & ((1 << WM8400_INMIXR_PWR) | (1 << WM8400_AINRMUX_PWR)))
is false, we should clear WM8400_AINR_ENA bits instead of WM8400_AINL_ENA.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8400.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index fbee556..dc13be2 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -383,7 +383,7 @@ static int inmixer_event (struct snd_soc_dapm_widget *w,
 		(1 << WM8400_AINRMUX_PWR))) {
 		reg |= WM8400_AINR_ENA;
 	} else {
-		reg &= ~WM8400_AINL_ENA;
+		reg &= ~WM8400_AINR_ENA;
 	}
 	wm8400_write(w->codec, WM8400_POWER_MANAGEMENT_2, reg);
 
-- 
1.7.4.1
