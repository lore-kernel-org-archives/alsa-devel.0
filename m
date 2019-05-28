From: bgoswami@codeaurora.org
Subject: [PATCH] ALSA: pcm: Check for integer overflow during
	multiplication
Date: Mon, 27 May 2019 22:27:03 -0700
Message-ID: <1559021223-28674-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2D10F808F6
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 07:27:18 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, plai@codeaurora.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, Phani Kumar Uppalapati <phaniu@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Phani Kumar Uppalapati <phaniu@codeaurora.org>

Channel info data structure is parsed from userspace and if
the number of channels is not set correctly, it could lead
to integer overflow when the number of channels is multiplied
with pcm bit width. Add a condition to check for integer
overflow during the multiplication operationi, and return error
if overflow detected.

Signed-off-by: Phani Kumar Uppalapati <phaniu@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/core/pcm_lib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 345ab1a..f45ae3a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1718,6 +1718,11 @@ static int snd_pcm_lib_ioctl_channel_info(struct snd_pcm_substream *substream,
 	switch (runtime->access) {
 	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
 	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
+		if ((UINT_MAX/width) < info->channel) {
+			snd_printd("%s: integer overflow in multiplication\n",
+				   __func__);
+			return -EINVAL;
+		}
 		info->first = info->channel * width;
 		info->step = runtime->channels * width;
 		break;
@@ -1725,6 +1730,12 @@ static int snd_pcm_lib_ioctl_channel_info(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_ACCESS_RW_NONINTERLEAVED:
 	{
 		size_t size = runtime->dma_bytes / runtime->channels;
+
+		if ((size > 0) && ((UINT_MAX/(size * 8)) < info->channel)) {
+			snd_printd("%s: integer overflow in multiplication\n",
+				   __func__);
+			return -EINVAL;
+		}
 		info->first = info->channel * size * 8;
 		info->step = width;
 		break;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
