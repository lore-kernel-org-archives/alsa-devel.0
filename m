From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] ASoC: dpcm: symmetry constraint on FE substream
Date: Mon, 28 May 2018 10:18:19 +0800
Message-ID: <1527473899-23079-3-git-send-email-kaichieh.chuang@mediatek.com>
References: <1527473899-23079-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1527473899-23079-1-git-send-email-kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

We should set BE symmetric constraint on FE substream.

in case one BE is used by two FE1/FE2,
the first BE runtime will use FE1's substream->runtime.
hence the FE1's will be constrained by BE symmetry property.

Though, second FE2 call dpcm_apply_symmetry,
the be_substream->runtime == FE1's substream->runtime.
The FE2's substream->runtime will not be constrained
by BE's symmetry property.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/soc-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ffdbbd9..61494f7 100644
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
