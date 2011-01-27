From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH] ASoC: DaVinci: fix kernel panic due to
	uninitialized platform_data
Date: Thu, 27 Jan 2011 19:17:43 +0530
Message-ID: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF49103ACE
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 14:50:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Manjunathappa,
	Prakash" <prakash.pm@ti.com>, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the Kernel panic issue on accessing davinci_vc in
cq93vc_probe function. struct davinci_vc is part of platform device's
private driver data(codec->dev->p->driver_data) and this is populated
by DaVinci Voice Codec MFD driver.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
This patch applies to Linus's tree at [1].

[1] http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
---
 sound/soc/codecs/cq93vc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 46dbfd0..347a567 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -153,7 +153,7 @@ static int cq93vc_resume(struct snd_soc_codec *codec)
 
 static int cq93vc_probe(struct snd_soc_codec *codec)
 {
-	struct davinci_vc *davinci_vc = codec->dev->platform_data;
+	struct davinci_vc *davinci_vc = snd_soc_codec_get_drvdata(codec);
 
 	davinci_vc->cq93vc.codec = codec;
 	codec->control_data = davinci_vc;
-- 
1.7.1
