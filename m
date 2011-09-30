From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sn95031: Do not use static variable for
	channel_index
Date: Fri, 30 Sep 2011 13:56:59 +0800
Message-ID: <1317362219.6646.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 63A12103880
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 07:57:12 +0200 (CEST)
Received: by ywn1 with SMTP id 1so1425630ywn.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 22:57:11 -0700 (PDT)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

No reason to use static variable for channel_index.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sn95031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index adb85bf..02a4857 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -103,7 +103,7 @@ static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
 {
 	int base_addr, chnl_addr;
 	int value;
-	static int channel_index;
+	int channel_index;
 
 	/* Index of the first channel in which the stop bit is set */
 	channel_index = find_free_channel(sn95031_codec);
-- 
1.7.4.1
