From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: xtfpga-i2s: Add missing __rcu
	annotation
Date: Mon, 27 Jul 2015 10:56:28 +0200
Message-ID: <1437987388-9706-7-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1DB22619E7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:39 +0200 (CEST)
In-Reply-To: <1437987388-9706-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

tx_substeam is accessed using the RCU API and hence should have the __rcu
annotation. Fixes the following sparse warnings:

	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: incompatible types in
		comparison expression (different address spaces)
	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream
		[noderef] <asn:4>*' versus
	sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream *'
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: incompatible types in
		comparison expression (different address spaces)
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream
		[noderef] <asn:4>*' versus
	sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream *'

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/xtensa/xtfpga-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 039f65e..8382ffa 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -75,7 +75,7 @@ struct xtfpga_i2s {
 	 * stream in the pcm_close callback it synchronizes with the interrupt
 	 * handler by means of synchronize_rcu call.
 	 */
-	struct snd_pcm_substream *tx_substream;
+	struct snd_pcm_substream __rcu *tx_substream;
 	unsigned (*tx_fn)(struct xtfpga_i2s *i2s,
 			  struct snd_pcm_runtime *runtime,
 			  unsigned tx_ptr);
-- 
2.1.4
