From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] fix typo and removed unneeded switch case
Date: Sat, 28 Feb 2009 13:21:03 +0100
Message-ID: <1235823663-9023-1-git-send-email-daniel@caiaq.de>
References: <ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 29FA71037F2
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 13:21:12 +0100 (CET)
In-Reply-To: <ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

This removes a misspelled comment and got rid of superfluous switch
case.

Cc: Timur Tabi <timur@freescale.com>
Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/codecs/cs4270.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 339e0f6..f86f33c 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -267,10 +267,8 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_CBM_CFM:
 		cs4270->slave_mode = 0;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		/* unsupported - cs4270 can eigther be slave or master to
-		 * both the bitclk and the lrclk. */
 	default:
+		/* all other modes are unsupported by the hardware */
 		ret = -EINVAL;
 	}
 
-- 
1.6.1.3
