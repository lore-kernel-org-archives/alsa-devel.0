From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: Staticise sh4_ssi_dai
Date: Sun, 02 Oct 2011 17:43:16 +0800
Message-ID: <1317548596.16362.2.camel@phoenix>
References: <1317548500.16362.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BBC8224468
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 11:43:23 +0200 (CEST)
Received: by gyg4 with SMTP id 4so3036591gyg.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 02:43:22 -0700 (PDT)
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
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/sh/ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 05192d9..e0c621c 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -342,7 +342,7 @@ static struct snd_soc_dai_ops ssi_dai_ops = {
 	.set_fmt	= ssi_set_fmt,
 };
 
-struct snd_soc_dai_driver sh4_ssi_dai[] = {
+static struct snd_soc_dai_driver sh4_ssi_dai[] = {
 {
 	.name			= "ssi-dai.0",
 	.playback = {
-- 
1.7.4.1
