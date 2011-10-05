From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/10] ASoC: twl6040: Warn user in
	twl6040_put_volsw for error case
Date: Wed,  5 Oct 2011 10:29:28 +0300
Message-ID: <1317799768-15683-11-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BBBF103A4D
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:57 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so2091143bkb.40
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:57 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Let the user know, that the callback has been called with unexpected
register parameter.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 7450e1b..62edded 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -759,6 +759,8 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 		out = &twl6040_priv->handsfree;
 		break;
 	default:
+		dev_warn(codec->dev, "%s: Unexpected register: 0x%02x\n",
+					__func__, mc->reg);
 		return -EINVAL;
 	}
 
-- 
1.7.7
