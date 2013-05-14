From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] ASoC: kirkwood-dma: Staticize non
	exported struct
Date: Tue, 14 May 2013 22:19:48 +0200
Message-ID: <1368562797-10440-2-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 664DB26080A
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:24 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

The kirkwood_dma_ops struct is not used outside of kirkwood-dma.c, so make it
static.

Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index d3d4bdc..a9f1453 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -289,7 +289,7 @@ static snd_pcm_uframes_t kirkwood_dma_pointer(struct snd_pcm_substream
 	return count;
 }
 
-struct snd_pcm_ops kirkwood_dma_ops = {
+static struct snd_pcm_ops kirkwood_dma_ops = {
 	.open =		kirkwood_dma_open,
 	.close =        kirkwood_dma_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.8.0
