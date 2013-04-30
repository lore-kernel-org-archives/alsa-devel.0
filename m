From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8994: missing break in
	wm8994_aif3_hw_params()
Date: Tue, 30 Apr 2013 10:24:41 +0300
Message-ID: <20130430072441.GB7237@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FD44264F26
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 09:24:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The missing break here means that we always return early and the
function is a no-op.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 14094f5..1eb152c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2882,6 +2882,7 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 		default:
 			return 0;
 		}
+		break;
 	default:
 		return 0;
 	}
