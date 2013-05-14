From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] ASoC: spear: spdif_out: Staticize
	unexported function
Date: Tue, 14 May 2013 22:19:50 +0200
Message-ID: <1368562797-10440-4-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id D6E39260816
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:25 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

The spdif_soc_dai_probe function is only used in spdif_out.c, so make it static.

Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/spear/spdif_out.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index fd25cc5..4bde512 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -240,7 +240,7 @@ static const struct snd_kcontrol_new spdif_out_controls[] = {
 			spdif_mute_get, spdif_mute_put),
 };
 
-int spdif_soc_dai_probe(struct snd_soc_dai *dai)
+static int spdif_soc_dai_probe(struct snd_soc_dai *dai)
 {
 	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
 
-- 
1.8.0
