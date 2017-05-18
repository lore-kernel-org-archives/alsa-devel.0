From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: audio-graph-card: fix spelling mistake:
	"missmatch" -> "mismatch"
Date: Thu, 18 May 2017 08:48:15 +0100
Message-ID: <20170518074815.10755-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 937F5267019
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 09:48:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 07e010d38596..e0c26380921e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -107,7 +107,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	int ret;
 
 	if (rcpu_ep != cpu_ep) {
-		dev_err(dev, "remote-endpoint missmatch (%s/%s/%s)\n",
+		dev_err(dev, "remote-endpoint mismatch (%s/%s/%s)\n",
 			cpu_ep->name, codec_ep->name, rcpu_ep->name);
 		ret = -EINVAL;
 		goto dai_link_of_err;
-- 
2.11.0
