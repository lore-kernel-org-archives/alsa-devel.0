From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [PATCH V2] ASoC: sgtl5000: add delay before first I2C
	access
Date: Fri, 30 Jan 2015 14:07:55 -0700
Message-ID: <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C6549260506
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 22:08:01 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id eu11so56759045pac.13
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 13:08:00 -0800 (PST)
In-Reply-To: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Cc: fabio.estevam@freescale.com, broonie@kernel.org, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

To quote from section 1.3.1 of the data sheet:
	The SGTL5000 has an internal reset that is deasserted
	8 SYS_MCLK cycles after all power rails have been brought
	up. After this time, communication can start

	...
	1.0uS represents 8 SYS_MCLK cycles at the minimum 8.0 MHz SYS_MCLK.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
V2 replaces usleep_range with udelay and fixes microseconds in comment.

 sound/soc/codecs/sgtl5000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 29cf7ce..7d65a5b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1462,6 +1462,9 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	/* Need 8 clocks before I2C accesses */
+	udelay(1);
+
 	/* read chip information */
 	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
 	if (ret)
-- 
1.9.1
