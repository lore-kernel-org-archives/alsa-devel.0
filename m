From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ASoC: DAPM: Fix uninitialized return value
	from snd_soc_dai_link_event()
Date: Mon, 28 Oct 2013 14:21:48 +0100
Message-ID: <1382966510-13075-4-git-send-email-tiwai@suse.de>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D46D26163E
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:19:06 +0100 (CET)
In-Reply-To: <1382966510-13075-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

In a slightest path (both source and sink hw_params are NULL), the
function may return an uninitialized value.

Spotted by coverity CID 703453.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d2ff080..c21c8e7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3428,6 +3428,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 		}
+
+		ret = 0;
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
-- 
1.8.4.1
