From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 7/7] ASoc: codec: sti enable fast io for regmap
Date: Mon, 24 Oct 2016 16:42:57 +0200
Message-ID: <1477320177-30130-8-git-send-email-arnaud.pouliquen@st.com>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id DDDED266CAE
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:20 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Some registers accesses are done in atomic context.
Enable fast io to use spinlock instead of mutex to protect access.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/sti-sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 21d087b..62c6187 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -317,7 +317,7 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 static const struct regmap_config stih407_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
-
+	.fast_io = true,
 	.max_register = STIH407_AUDIO_DAC_CTRL,
 	.reg_defaults = stih407_sas_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(stih407_sas_reg_defaults),
-- 
1.9.1
