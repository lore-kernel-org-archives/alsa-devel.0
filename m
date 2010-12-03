From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: When disabling WM8994 FLL force a source
	selection
Date: Fri,  3 Dec 2010 16:45:01 +0000
Message-ID: <1291394701-30574-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0C7E103B75
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:45:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When we disable the WM8994 FLL code path sharing means that we end up
writing out a configuration. Currently this is the currently active
input and output frequency (which causes snd_soc_update_bits() to
suppress actual writes both immediately and in the common case where
we reenable the same configuration later) but we allow machine drivers
to pass through a source of zero. Since the register values written
are one less than the source constants this causes corruption of other
bitfields in the register.

Fix this by using the most recently configured FLL source when none is
provided.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index af3a98a..b37e95c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1677,6 +1677,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		/* Allow no source specification when stopping */
 		if (freq_out)
 			return -EINVAL;
+		src = wm8994->fll[id].src;
 		break;
 	case WM8994_FLL_SRC_MCLK1:
 	case WM8994_FLL_SRC_MCLK2:
-- 
1.7.1
