From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: fix compile breakage - add a missing
	header include
Date: Tue, 19 Jan 2010 08:39:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001190832580.4607@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id CD5C8244CA
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 08:39:01 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

It might well have been reported and / or fixed in some trees, sorry for 
the noise, if that's the case.

 include/sound/soc-dai.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ca24e7f..061f16d 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -16,6 +16,8 @@
 
 #include <linux/list.h>
 
+#include <sound/soc.h>
+
 struct snd_pcm_substream;
 
 /*
-- 
1.6.2.4
