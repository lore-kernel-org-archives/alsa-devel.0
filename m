From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Staticise samsung_spdif_dai
Date: Sun, 02 Oct 2011 17:42:30 +0800
Message-ID: <1317548550.16362.1.camel@phoenix>
References: <1317548500.16362.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id AA54C24469
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 11:42:39 +0200 (CEST)
Received: by pzd13 with SMTP id 13so8990346pzd.2
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 02:42:38 -0700 (PDT)
In-Reply-To: <1317548500.16362.0.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam@alsa-project.org, Girdwood <lrg@ti.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/spdif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 965b2bd..468cff1 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -341,7 +341,7 @@ static struct snd_soc_dai_ops spdif_dai_ops = {
 	.shutdown	= spdif_shutdown,
 };
 
-struct snd_soc_dai_driver samsung_spdif_dai = {
+static struct snd_soc_dai_driver samsung_spdif_dai = {
 	.name = "samsung-spdif",
 	.playback = {
 		.stream_name = "S/PDIF Playback",
-- 
1.7.4.1
