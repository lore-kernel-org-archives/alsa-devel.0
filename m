From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Use spi_write in do_spi_write
Date: Thu,  5 May 2011 19:52:46 +0200
Message-ID: <1304617966-4410-4-git-send-email-lars@metafoo.de>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with ESMTP id B706F2414C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 19:53:12 +0200 (CEST)
In-Reply-To: <1304617966-4410-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mike Frysinger <vapier@gentoo.org>
Cc: device-driver-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Instead of open-coding the spi transfer use spi_write.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-cache.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index f1ee207..3897d4a 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -25,20 +25,14 @@ static int do_spi_write(void *control_data, const char *msg,
 			int len)
 {
 	struct spi_device *spi = control_data;
-	struct spi_transfer t;
-	struct spi_message m;
+	int ret;
 
 	if (len <= 0)
 		return 0;
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof t);
-
-	t.tx_buf = msg;
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
+	ret = spi_write(spi, msg, len);
+	if (ret < 0)
+		return ret;
 
 	return len;
 }
-- 
1.7.2.5
