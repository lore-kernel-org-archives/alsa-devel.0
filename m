From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: wm_adsp: Print out the firmware
	version
Date: Fri,  1 Nov 2013 15:56:57 +0000
Message-ID: <1383321417-1133-7-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA37526585C
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:57:04 +0100 (CET)
In-Reply-To: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1761f65..df95e5a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -570,6 +570,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			 file, header->ver);
 		goto out_fw;
 	}
+	adsp_info(dsp, "Firmware version: %d\n", header->ver);
 
 	if (header->core != dsp->type) {
 		adsp_err(dsp, "%s: invalid core %d != %d\n",
-- 
1.8.4.2
