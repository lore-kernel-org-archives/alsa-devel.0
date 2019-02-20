From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Allow compressed buffers in
	any memory region" to the asoc tree
Date: Wed, 20 Feb 2019 12:13:20 +0000 (GMT)
Message-ID: <20190220121320.7520811274ED@debutante.sirena.org.uk>
References: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B09E2F8079B
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 13:13:22 +0100 (CET)
In-Reply-To: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, broonie@kernel.org, aford@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Allow compressed buffers in any memory region

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fb13f19d102ee47c0f27fda70387052a3fd3e656 Mon Sep 17 00:00:00 2001
From: Andrew Ford <aford@opensource.cirrus.com>
Date: Tue, 19 Feb 2019 17:31:56 +0000
Subject: [PATCH] ASoC: wm_adsp: Allow compressed buffers in any memory region

Currently, compressed buffers can only be specified in the XM memory
region. There is no reason to have such a restriction with the newer
meta-data based way of specifying the buffers, so remove it.

Signed-off-by: Andrew Ford <aford@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1dd291cebe67..12ef85e85c29 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -344,6 +344,7 @@ struct wm_adsp_compr_buf {
 	u32 irq_count;
 	int read_index;
 	int avail;
+	int host_buf_mem_type;
 };
 
 struct wm_adsp_compr {
@@ -3219,14 +3220,14 @@ static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
 static inline int wm_adsp_buffer_read(struct wm_adsp_compr_buf *buf,
 				      unsigned int field_offset, u32 *data)
 {
-	return wm_adsp_read_data_word(buf->dsp, WMFW_ADSP2_XM,
+	return wm_adsp_read_data_word(buf->dsp, buf->host_buf_mem_type,
 				      buf->host_buf_ptr + field_offset, data);
 }
 
 static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
 				       unsigned int field_offset, u32 data)
 {
-	return wm_adsp_write_data_word(buf->dsp, WMFW_ADSP2_XM,
+	return wm_adsp_write_data_word(buf->dsp, buf->host_buf_mem_type,
 				       buf->host_buf_ptr + field_offset, data);
 }
 
@@ -3264,6 +3265,8 @@ static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 	if (!buf->host_buf_ptr)
 		return -EIO;
 
+	buf->host_buf_mem_type = WMFW_ADSP2_XM;
+
 	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
 
 	return 0;
@@ -3282,6 +3285,7 @@ wm_adsp_find_host_buffer_ctrl(struct wm_adsp_compr_buf *buf)
 		if (!ctl->enabled)
 			continue;
 
+		buf->host_buf_mem_type = ctl->alg_region.type;
 		return ctl;
 	}
 
-- 
2.20.1
