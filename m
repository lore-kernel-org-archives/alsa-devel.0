From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: wm_adsp: Add debug info on
	get()/put() transfers
Date: Fri,  1 Nov 2013 15:56:55 +0000
Message-ID: <1383321417-1133-5-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C366265852
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:57:02 +0100 (CET)
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
 sound/soc/codecs/wm_adsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4039d05..79dc4aa 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -401,6 +401,7 @@ static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
 		kfree(scratch);
 		return ret;
 	}
+	adsp_dbg(adsp, "Wrote %zu bytes to %x\n", ctl->len, reg);
 
 	kfree(scratch);
 
@@ -455,6 +456,7 @@ static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 		kfree(scratch);
 		return ret;
 	}
+	adsp_dbg(adsp, "Read %zu bytes from %x\n", ctl->len, reg);
 
 	memcpy(buf, scratch, ctl->len);
 	kfree(scratch);
-- 
1.8.4.2
