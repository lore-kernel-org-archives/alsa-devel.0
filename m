From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: Fix WM8731 SPI write
Date: Mon, 15 Sep 2008 14:25:01 +0100
Message-ID: <1221485106-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080915132418.GA23825@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D8A224654
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 15:25:08 +0200 (CEST)
In-Reply-To: <20080915132418.GA23825@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Alan Horstmann <gineera@aspect135.co.uk>

Ensure wm8731_spi_write byte order is consistent regardless of
endianess.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 975befd..7b64d9a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -688,12 +688,13 @@ static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
 {
 	struct spi_transfer t;
 	struct spi_message m;
-	u16 msg[2];
+	u8 msg[2];
 
 	if (len <= 0)
 		return 0;
 
-	msg[0] = (data[0] << 8) + data[1];
+	msg[0] = data[0];
+	msg[1] = data[1];
 
 	spi_message_init(&m);
 	memset(&t, 0, (sizeof t));
-- 
1.5.6.5
