From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add missing const from region
	definitions" to the asoc tree
Date: Tue, 02 Feb 2016 19:42:00 +0000
Message-ID: <E1aQgps-0007tT-Qi@debutante>
References: <1454340154-16544-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 014FC26530D
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:42:07 +0100 (CET)
In-Reply-To: <1454340154-16544-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add missing const from region definitions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3a9686c4ba7eec9201c6e8793705d32f24748771 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 1 Feb 2016 15:22:34 +0000
Subject: [PATCH] ASoC: wm_adsp: Add missing const from region definitions

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 653dbff81fee..28d3851c5063 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -325,7 +325,7 @@ struct wm_adsp_buffer_region_def {
 	unsigned int size_offset;
 };
 
-static struct wm_adsp_buffer_region_def default_regions[] = {
+static const struct wm_adsp_buffer_region_def default_regions[] = {
 	{
 		.mem_type = WMFW_ADSP2_XM,
 		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
@@ -347,7 +347,7 @@ struct wm_adsp_fw_caps {
 	u32 id;
 	struct snd_codec_desc desc;
 	int num_regions;
-	struct wm_adsp_buffer_region_def *region_defs;
+	const struct wm_adsp_buffer_region_def *region_defs;
 };
 
 static const struct wm_adsp_fw_caps ctrl_caps[] = {
-- 
2.7.0.rc3
