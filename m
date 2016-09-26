From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 1/4] ASoC: wm_adsp: Use usleep_range for
	short delay
Date: Mon, 26 Sep 2016 10:15:22 +0100
Message-ID: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A6F02668A2
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 11:15:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Replace the 1ms msleep in wm_adsp2_ena with a usleep_range, as per
normal guidance on delay functions. Also tighten up the delay a little
as 1ms was quite generous.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

New since the first series of this patch chain.

 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 24485ec..4188c37 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2237,7 +2237,7 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 		if (val & ADSP2_RAM_RDY)
 			break;
 
-		msleep(1);
+		usleep_range(250, 500);
 	}
 
 	if (!(val & ADSP2_RAM_RDY)) {
-- 
2.1.4
