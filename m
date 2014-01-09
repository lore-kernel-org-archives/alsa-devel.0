From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: wm_adsp: Fix sparse non static
	symbol warning
Date: Thu, 9 Jan 2014 22:22:35 +0800
Message-ID: <CAPgLHd_bNPEJmkjtmbeDrtmVMo5G7ELNCuyKuwT7Qa=weqh8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 095E9261AB2
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:22:36 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id mx12so1137603bkb.20
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 06:22:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, dp@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
Cc: yongjun_wei@trendmicro.com.cn, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

sound/soc/codecs/wm_adsp.c:1500:6: warning:
 symbol 'wm_adsp2_boot_work' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 41669ad..444626f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1497,7 +1497,7 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	return 0;
 }
 
-void wm_adsp2_boot_work(struct work_struct *work)
+static void wm_adsp2_boot_work(struct work_struct *work)
 {
 	struct wm_adsp *dsp = container_of(work,
 					   struct wm_adsp,
