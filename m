From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: pcm: add const qualifier for read-only
	table for sampling rate
Date: Wed, 17 May 2017 08:48:17 +0900
Message-ID: <20170516234820.14728-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 801B2266F78
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 01:48:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's a read-only table for each sampling rate, while it doesn't have
const qualifier and can be modified.

This commit add the qualifier. As a result, a symbol for the table
moves from .data section to .rodata.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d873f90..f3a3580 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1987,8 +1987,10 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 #error "Change this table"
 #endif
 
-static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+static const unsigned int rates[] = {
+	5512, 8000, 11025, 16000, 22050, 32000, 44100,
+	48000, 64000, 88200, 96000, 176400, 192000
+};
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 	.count = ARRAY_SIZE(rates),
-- 
2.9.3
