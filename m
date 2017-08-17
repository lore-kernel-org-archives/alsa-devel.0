From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 05/12] ALSA: mips: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:53 +0530
Message-ID: <1502961360-22063-6-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F51267645
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 11:17:12 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 83so8929337pgb.4
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 02:17:12 -0700 (PDT)
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used in a copy operation.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/mips/hal2.c       | 2 +-
 sound/mips/sgio2audio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 3318c15..367d6c37 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -496,7 +496,7 @@ static void hal2_free_dmabuf(struct hal2_codec *codec)
 		       DMA_ATTR_NON_CONSISTENT);
 }
 
-static struct snd_pcm_hardware hal2_pcm_hw = {
+static const struct snd_pcm_hardware hal2_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 0ebc1c3..603892f 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -532,7 +532,7 @@ static irqreturn_t snd_sgio2audio_error_isr(int irq, void *dev_id)
 
 /* PCM part */
 /* PCM hardware definition */
-static struct snd_pcm_hardware snd_sgio2audio_pcm_hw = {
+static const struct snd_pcm_hardware snd_sgio2audio_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
