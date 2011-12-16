From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix build error in sst_platform.c
Date: Fri, 16 Dec 2011 11:47:08 +0800
Message-ID: <1324007228.26942.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 21B5524804
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 04:47:22 +0100 (CET)
Received: by yhjj56 with SMTP id j56so2673200yhj.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 19:47:20 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lu Guanqun <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Fix below build error:

  CC      sound/soc/mid-x86/sst_platform.o
sound/soc/mid-x86/sst_platform.c: In function 'sst_platform_open':
sound/soc/mid-x86/sst_platform.c:274:2: error: 'ret_val' undeclared (first use in this function)
sound/soc/mid-x86/sst_platform.c:274:2: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [sound/soc/mid-x86/sst_platform.o] Error 1
make[2]: *** [sound/soc/mid-x86] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/sst_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 24f9471..11c39c5 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -267,6 +267,7 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sst_runtime_stream *stream;
+	int ret_val;
 
 	pr_debug("sst_platform_open called\n");
 
-- 
1.7.5.4
