From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: Staticise rx51_aux_dev
Date: Tue, 13 Dec 2011 10:13:13 +0800
Message-ID: <1323742393.2544.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7411E24422
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 03:13:27 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so4428975vbb.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 18:13:26 -0800 (PST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/omap/rx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 4cabb74..ad16db5 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -365,7 +365,7 @@ static struct snd_soc_dai_link rx51_dai[] = {
 	},
 };
 
-struct snd_soc_aux_dev rx51_aux_dev[] = {
+static struct snd_soc_aux_dev rx51_aux_dev[] = {
 	{
 		.name = "TLV320AIC34b",
 		.codec_name = "tlv320aic3x-codec.2-0019",
-- 
1.7.5.4
