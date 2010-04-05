From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/3] WM8750: Fix SPITZ machine
Date: Mon,  5 Apr 2010 06:00:04 +0200
Message-ID: <1270440005-25459-2-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f217.google.com (mail-fx0-f217.google.com
	[209.85.220.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 00964103803
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 06:00:59 +0200 (CEST)
Received: by fxm9 with SMTP id 9so2967787fxm.4
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 21:00:59 -0700 (PDT)
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
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
Cc: Marek Vasut <marek.vasut@gmail.com>, broonie@opensource.wolfsonmicro.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch registers the WM8750 codec on a proper place on the SPITZ machine
after the WM8750 driver was converted to new API. Moreover, the incorrect code
is hereby removed from the aSoC driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |    4 ++++
 sound/soc/pxa/spitz.c     |    7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 19b5109..58eb5e1 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -817,6 +817,10 @@ static struct i2c_board_info akita_i2c_board_info[] = {
 		.addr		= 0x18,
 		.platform_data	= &akita_ioexp,
 	},
+	{
+		.type		= "wm8750",
+		.addr		= 0x1b,
+	},
 };
 
 static void __init akita_init(void)
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index c4cd2ac..d256f5f 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -322,17 +322,10 @@ static struct snd_soc_card snd_soc_spitz = {
 	.num_links = 1,
 };
 
-/* spitz audio private data */
-static struct wm8750_setup_data spitz_wm8750_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 /* spitz audio subsystem */
 static struct snd_soc_device spitz_snd_devdata = {
 	.card = &snd_soc_spitz,
 	.codec_dev = &soc_codec_dev_wm8750,
-	.codec_data = &spitz_wm8750_setup,
 };
 
 static struct platform_device *spitz_snd_device;
-- 
1.7.0
