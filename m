From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/12] ASoC: SSM2602: Remove unused struct and
	define
Date: Thu,  5 May 2011 16:59:13 +0200
Message-ID: <1304607560-15083-5-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id EEB81103A0E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:44 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Those are leftovers from a pre-multicomponent era.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.h b/sound/soc/codecs/ssm2602.h
index 42a47d0..b98c691 100644
--- a/sound/soc/codecs/ssm2602.h
+++ b/sound/soc/codecs/ssm2602.h
@@ -117,11 +117,5 @@
 #define SSM2602_CACHEREGNUM 	10
 
 #define SSM2602_SYSCLK	0
-#define SSM2602_DAI		0
-
-struct ssm2602_setup_data {
-	int i2c_bus;
-	unsigned short i2c_address;
-};
 
 #endif
-- 
1.7.2.5
