From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Staticise ep93xx_ac97_dai
Date: Mon, 03 Oct 2011 11:33:05 +0800
Message-ID: <1317612785.5065.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 658331038AF
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 05:33:13 +0200 (CEST)
Received: by yxk8 with SMTP id 8so3602924yxk.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 20:33:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/ep93xx/ep93xx-ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-ac97.c b/sound/soc/ep93xx/ep93xx-ac97.c
index c7417c7..3cd6158 100644
--- a/sound/soc/ep93xx/ep93xx-ac97.c
+++ b/sound/soc/ep93xx/ep93xx-ac97.c
@@ -335,7 +335,7 @@ static struct snd_soc_dai_ops ep93xx_ac97_dai_ops = {
 	.trigger	= ep93xx_ac97_trigger,
 };
 
-struct snd_soc_dai_driver ep93xx_ac97_dai = {
+static struct snd_soc_dai_driver ep93xx_ac97_dai = {
 	.name		= "ep93xx-ac97",
 	.id		= 0,
 	.ac97_control	= 1,
-- 
1.7.4.1
