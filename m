From: Marc Dietrich <marvin24@gmx.de>
Subject: [PATCH 1/2] ASoC: tegra+alc5632: Swap MICBIAS1 and
	MIC1 dapm widgets
Date: Sat,  7 Jul 2012 15:36:29 +0200
Message-ID: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id D571724340
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2012 15:37:01 +0200 (CEST)
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
Cc: Marc Dietrich <marvin24@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Leon Romanovsky <leon@leon.nu>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

MICBIAS1 is an internal widget. If MICBIAS1 is connected to the board
driver instead of the MIC1 ASoC core, it enables widgets even if the
capture stream isn't active.

Cc: Leon Romanovsky <leon@leon.nu>
Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 sound/soc/codecs/alc5632.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 7dd0242..8609a86 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -551,8 +551,10 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Left LineIn", NULL,				"LINEINL"},
 	{"Right LineIn", NULL,				"LINEINR"},
 	{"Phone", NULL,				"PHONEP"},
-	{"MIC1 Pre Amp", NULL,				"MIC1"},
-	{"MIC2 Pre Amp", NULL,				"MIC2"},
+	{"MICBIAS1", NULL,				"MIC1"},
+	{"MIC1 Pre Amp", NULL,				"MICBIAS1"},
+	{"MICBIAS2", NULL,				"MIC2"},
+	{"MIC2 Pre Amp", NULL,				"MICBIAS2"},
 	{"MIC1 PGA", NULL,				"MIC1 Pre Amp"},
 	{"MIC2 PGA", NULL,				"MIC2 Pre Amp"},
 
-- 
1.7.9.5
