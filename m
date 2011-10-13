From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ak4535: fixup cache register table
Date: Thu, 13 Oct 2011 17:17:06 +0800
Message-ID: <1318497427.2857.14.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A8856103A43
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 11:17:14 +0200 (CEST)
Received: by ywn1 with SMTP id 1so996785ywn.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 02:17:14 -0700 (PDT)
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

ak4535_reg should be 8bit, but cache table is defined as 16bit.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4535.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 68df32d..95d782d 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -39,11 +39,11 @@ struct ak4535_priv {
 /*
  * ak4535 register cache
  */
-static const u16 ak4535_reg[AK4535_CACHEREGNUM] = {
-    0x0000, 0x0080, 0x0000, 0x0003,
-    0x0002, 0x0000, 0x0011, 0x0001,
-    0x0000, 0x0040, 0x0036, 0x0010,
-    0x0000, 0x0000, 0x0057, 0x0000,
+static const u8 ak4535_reg[AK4535_CACHEREGNUM] = {
+	0x00, 0x80, 0x00, 0x03,
+	0x02, 0x00, 0x11, 0x01,
+	0x00, 0x40, 0x36, 0x10,
+	0x00, 0x00, 0x57, 0x00,
 };
 
 static const char *ak4535_mono_gain[] = {"+6dB", "-17dB"};
-- 
1.7.4.1
