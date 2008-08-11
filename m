From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] wm8750: add missing VREF output
Date: Tue, 12 Aug 2008 02:45:31 +0400
Message-ID: <1218494731-2649-2-git-send-email-dbaryshkov@gmail.com>
References: <1218494731-2649-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 0610B2434D
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 00:46:45 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1148387fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2008 15:46:45 -0700 (PDT)
In-Reply-To: <1218494731-2649-1-git-send-email-dbaryshkov@gmail.com>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Add missing output VREF. After a65f0568f6cc8433877fb71dd7d36b551854b0bc
it's critical, since it makes chip routing initialisation to fail.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8750.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 2e71394..c6a8edf 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -350,6 +350,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("ROUT2"),
 	SND_SOC_DAPM_OUTPUT("MONO1"),
 	SND_SOC_DAPM_OUTPUT("OUT3"),
+	SND_SOC_DAPM_OUTPUT("VREF"),
 
 	SND_SOC_DAPM_INPUT("LINPUT1"),
 	SND_SOC_DAPM_INPUT("LINPUT2"),
-- 
1.5.6.3
