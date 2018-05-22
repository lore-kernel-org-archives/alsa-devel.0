From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 2/2] ASoC: dpcm: symmetry constraint on FE
	substream
Date: Tue, 22 May 2018 17:13:28 +0800
Message-ID: <1526980408-1935-3-git-send-email-kaichieh.chuang@mediatek.com>
References: <1526980408-1935-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F14226765C
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 11:13:36 +0200 (CEST)
In-Reply-To: <1526980408-1935-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

We should set BE symmetric constraint on FE substream.

in case one BE is used by two FE1/FE2,
the first BE runtime will use FE1's substream->runtime.
hence the FE1's will be constrained by BE symmetry property.

Though, second FE2 call dpcm_apply_symmetry,
the be_substream->runtime == FE1's substream->runtime.
The FE2's substream->runtime will not be constrained
by BE's symmetry property.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/soc-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 481604a..1ef7514 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1779,14 +1779,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 
 		/* Symmetry only applies if we've got an active stream. */
 		if (rtd->cpu_dai->active) {
-			err = soc_pcm_apply_symmetry(be_substream, rtd->cpu_dai);
+			err = soc_pcm_apply_symmetry(fe_substream,
+						     rtd->cpu_dai);
 			if (err < 0)
 				return err;
 		}
 
 		for (i = 0; i < rtd->num_codecs; i++) {
 			if (rtd->codec_dais[i]->active) {
-				err = soc_pcm_apply_symmetry(be_substream,
+				err = soc_pcm_apply_symmetry(fe_substream,
 							     rtd->codec_dais[i]);
 				if (err < 0)
 					return err;
-- 
1.9.1
