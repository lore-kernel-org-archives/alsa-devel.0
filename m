From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] ASoC: core: allow control index different from
	0
Date: Tue, 4 Oct 2016 17:36:01 +0200
Message-ID: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A201266E84
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2016 17:36:15 +0200 (CEST)
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

To differentiate control with same name only device field can be used.
But some applications like iecset use control index to differentiate
controls linked to several PCM devices or DAIs.
This patch suppress index overwriting to allow to use control index field.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4afa8db..39bc1a9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2175,7 +2175,6 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 	char *name = NULL;
 
 	memcpy(&template, _template, sizeof(template));
-	template.index = 0;
 
 	if (!long_name)
 		long_name = template.name;
-- 
1.9.1
