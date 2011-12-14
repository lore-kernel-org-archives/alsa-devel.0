From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Staticise mfld_msic_dailink
Date: Wed, 14 Dec 2011 19:23:01 +0800
Message-ID: <1323861781.16636.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B11E82460E
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 12:23:08 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so1098321wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 03:23:08 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/mfld_machine.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index e53f8e4..8ae0574 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -281,7 +281,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	return ret_val;
 }
 
-struct snd_soc_dai_link mfld_msic_dailink[] = {
+static struct snd_soc_dai_link mfld_msic_dailink[] = {
 	{
 		.name = "Medfield Headset",
 		.stream_name = "Headset",
-- 
1.7.5.4
