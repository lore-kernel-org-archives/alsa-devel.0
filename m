From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/4] ASoC: tlv320aic3x: Remove unused version
	string
Date: Mon, 26 Apr 2010 15:49:11 +0300
Message-ID: <1272286154-28392-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D752103816
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 14:48:37 +0200 (CEST)
Received: by ewy19 with SMTP id 19so3573402ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 05:48:36 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 5be580e..af463d8 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -50,8 +50,6 @@
 
 #include "tlv320aic3x.h"
 
-#define AIC3X_VERSION "0.2"
-
 /* codec private data */
 struct aic3x_priv {
 	struct snd_soc_codec codec;
-- 
1.7.0
