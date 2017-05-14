From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 15/21] ALSA: pcm: add const qualifier for
	read-only table for sampling rate
Date: Sun, 14 May 2017 17:57:50 +0900
Message-ID: <20170514085756.22382-16-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 552DB2665D5
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:06 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
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
index 65133c2..ad71eb2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2120,8 +2120,10 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
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
