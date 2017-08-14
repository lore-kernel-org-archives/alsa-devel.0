From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/10] ASoC: au1x: constify snd_pcm_ops
	structures
Date: Mon, 14 Aug 2017 11:26:24 +0530
Message-ID: <1502690193-29059-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5188A266DA4
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 07:57:42 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id y129so8950693pgy.3
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 22:57:41 -0700 (PDT)
In-Reply-To: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/au1x/dbdma2.c | 2 +-
 sound/soc/au1x/dma.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index b5d1caa..6a035ca 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -304,7 +304,7 @@ static int au1xpsc_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops au1xpsc_pcm_ops = {
+static const struct snd_pcm_ops au1xpsc_pcm_ops = {
 	.open		= au1xpsc_pcm_open,
 	.close		= au1xpsc_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index fcf5a9a..19457e2 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -277,7 +277,7 @@ static snd_pcm_uframes_t alchemy_pcm_pointer(struct snd_pcm_substream *ss)
 	return bytes_to_frames(ss->runtime, location);
 }
 
-static struct snd_pcm_ops alchemy_pcm_ops = {
+static const struct snd_pcm_ops alchemy_pcm_ops = {
 	.open			= alchemy_pcm_open,
 	.close			= alchemy_pcm_close,
 	.ioctl			= snd_pcm_lib_ioctl,
-- 
1.9.1
