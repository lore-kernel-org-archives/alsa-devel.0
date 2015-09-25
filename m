From: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Subject: [PATCH 2/2] ASoC: sgtl5000: fix error message output
	for MicBias voltage
Date: Fri, 25 Sep 2015 21:33:42 +0200
Message-ID: <1443209622-7716-2-git-send-email-gianlucarenzi@eurekelettronica.it>
References: <y>
 <1443209622-7716-1-git-send-email-gianlucarenzi@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gianlinux (unknown [77.89.4.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F9DA26644C
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 21:40:16 +0200 (CEST)
In-Reply-To: <1443209622-7716-1-git-send-email-gianlucarenzi@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Gianluca Renzi <gianlucarenzi@eurekelettronica.it>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
---
 sound/soc/codecs/sgtl5000.c |    2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

--- a/sound/soc/codecs/sgtl5000.c	2015-09-25 15:24:10.597051191 +0200
+++ b/sound/soc/codecs/sgtl5000.c	2015-09-25 21:28:00.318016274 +0200
@@ -1549,7 +1549,7 @@ static int sgtl5000_i2c_probe(struct i2c
 			else {
 				sgtl5000->micbias_voltage = 0;
 				dev_err(&client->dev,
-					"Unsuitable MicBias resistor\n");
+					"Unsuitable MicBias voltage\n");
 			}
 		} else {
 			sgtl5000->micbias_voltage = 0;
