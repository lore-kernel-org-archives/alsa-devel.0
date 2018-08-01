From: Colin King <colin.king@canonical.com>
Subject: [PATCH 7/9] ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
Date: Wed,  1 Aug 2018 11:47:40 +0100
Message-ID: <20180801104742.4328-8-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jaya Kumar <jayakumar.alsa@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'priv' is assigned and not used, removing this allows
the removal of pointer 'rtd'.

Cleans up clang warning:
warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/stm/stm32_adfsdm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 0e9373064032..706ff005234f 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -269,16 +269,10 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_soc_pcm_runtime *rtd;
-	struct stm32_adfsdm_priv *priv;
 
 	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (substream) {
-		rtd = substream->private_data;
-		priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
+	if (substream)
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-	}
 }
 
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
-- 
2.17.1
