From: Clive Messer <clive.messer@digitaldreamtime.co.uk>
Subject: [PATCH 1/1] ASoC: pcm512x: Add 352k8 sample rate
	support
Date: Sun, 19 Jun 2016 18:52:35 +0100
Message-ID: <1466358755-31729-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dreamtime.org (barcelona.digitaldreamtime.co.uk
 [85.158.46.130])
 by alsa0.perex.cz (Postfix) with ESMTP id C72D9264F02
 for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2016 19:52:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clive Messer <clive.messer@digitaldreamtime.co.uk>
List-Id: alsa-devel@alsa-project.org

Add 352k8 sample rate to the slave constraint list.

Signed-off-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
---
 sound/soc/codecs/pcm512x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 047c489..eca6648 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -480,7 +480,7 @@ static unsigned long pcm512x_ncp_target(struct pcm512x_priv *pcm512x,
 
 static const u32 pcm512x_dai_rates[] = {
 	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
-	88200, 96000, 176400, 192000, 384000,
+	88200, 96000, 176400, 192000, 352800, 384000,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_slave = {
-- 
2.5.5
