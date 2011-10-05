From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ak4535: Set codec->hw_write to
	i2c_master_send
Date: Wed, 05 Oct 2011 15:27:56 +0800
Message-ID: <1317799677.21481.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A28011038A6
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:28:04 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so718674ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:28:04 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It was removed in commit f0fba2ad
"ASoC: multi-component - ASoC Multi-Component Support".

Add it back, otherwise codec->hw_write points to NULL.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4535.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index e1a214e..00cc92c 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -439,6 +439,7 @@ static int ak4535_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AK4535 Audio Codec %s", AK4535_VERSION);
 
+	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->control_data = ak4535->control_data;
 
 	/* power on device */
-- 
1.7.4.1
