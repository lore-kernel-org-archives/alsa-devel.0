From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 3/4] ASoC: sti: use bind_pcm_ctl
Date: Tue, 8 Nov 2016 09:11:14 +0100
Message-ID: <1478592675-23092-4-git-send-email-arnaud.pouliquen@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0C3266EF9
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:13:12 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Bind PCM control to PCM device created during DAI linking.

Change-Id: Idbc6cb8421fd3b8fd6e2fb93c84578410ea7b227
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 549fac3..a958144 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -245,8 +245,6 @@ static int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
 		 * Uniperipheral instance ID
 		 */
 		ctrl = &uni->snd_ctrls[i];
-		ctrl->index = uni->id;
-		ctrl->device = uni->id;
 	}
 
 	return snd_soc_add_dai_controls(dai, uni->snd_ctrls, uni->num_ctrls);
@@ -348,7 +346,8 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_driver sti_uniperiph_dai_template = {
 	.probe = sti_uniperiph_dai_probe,
 	.suspend = sti_uniperiph_dai_suspend,
-	.resume = sti_uniperiph_dai_resume
+	.resume = sti_uniperiph_dai_resume,
+	.bind_pcm_ctl = true,
 };
 
 static const struct snd_soc_component_driver sti_uniperiph_dai_component = {
-- 
1.9.1
