From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH 1/6] ASoC: wm0010: Remove redundant spi driver
	bus initialization
Date: Tue, 23 Jun 2015 22:52:12 +0800
Message-ID: <1435071132-24409-1-git-send-email-borneo.antonio@gmail.com>
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 78BE926049D
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 16:52:37 +0200 (CEST)
Received: by wgck11 with SMTP id k11so12005805wgc.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 07:52:37 -0700 (PDT)
In-Reply-To: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: Antonio Borneo <borneo.antonio@gmail.com>
List-Id: alsa-devel@alsa-project.org

In ancient times it was necessary to manually initialize the bus
field of an spi_driver to spi_bus_type. These days this is done in
spi_register_driver(), so we can drop the manual assignment.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.de>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org
To: patches@opensource.wolfsonmicro.com
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/wm0010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f37989e..61bfff4 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -1005,7 +1005,6 @@ static int wm0010_spi_remove(struct spi_device *spi)
 static struct spi_driver wm0010_spi_driver = {
 	.driver = {
 		.name	= "wm0010",
-		.bus 	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm0010_spi_probe,
-- 
2.4.4
