From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/11] ASoC: sn95031: Staticize non exported
	struct
Date: Tue, 14 May 2013 22:19:56 +0200
Message-ID: <1368562797-10440-10-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A00260862
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:29 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The sn95031_codec struct is not used outside of sn95031.c, so make it static.

Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index d1ae869d..dba26e63 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -883,7 +883,7 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver sn95031_codec = {
+static struct snd_soc_codec_driver sn95031_codec = {
 	.probe		= sn95031_codec_probe,
 	.remove		= sn95031_codec_remove,
 	.read		= sn95031_read,
-- 
1.8.0
