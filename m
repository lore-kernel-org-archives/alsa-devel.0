From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: bf5xx-tdm-pcm: Staticize non
	exported struct
Date: Tue, 14 May 2013 22:19:53 +0200
Message-ID: <1368562797-10440-7-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 12AF3260851
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

The bf5xx_tdm_pcm_ops struct is only used in bf5xx-tdm-pcm.c, so make it static.

Cc: Scott Jiang <scott.jiang.linux@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-tdm-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 0e6b888..19e855d 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -229,8 +229,7 @@ static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-
-struct snd_pcm_ops bf5xx_pcm_tdm_ops = {
+static struct snd_pcm_ops bf5xx_pcm_tdm_ops = {
 	.open           = bf5xx_pcm_open,
 	.ioctl          = snd_pcm_lib_ioctl,
 	.hw_params      = bf5xx_pcm_hw_params,
-- 
1.8.0
