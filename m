From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 2/3] tosa: register wm9712 codec device
Date: Wed, 23 Feb 2011 02:29:10 +0300
Message-ID: <1298417351-24727-2-git-send-email-dbaryshkov@gmail.com>
References: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f49.google.com (mail-bw0-f49.google.com
	[209.85.214.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F9E01038DC
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 00:32:02 +0100 (CET)
Received: by bwz1 with SMTP id 1so1368410bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 15:32:02 -0800 (PST)
In-Reply-To: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since f0fba2ad1b it's required to register platform devices even for
AC'97 codecs. Register one on tosa (wm9712-codec).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/tosa.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 88b2329..7753d22 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -884,6 +884,11 @@ static struct platform_device sharpsl_rom_device = {
 	.dev.platform_data = &sharpsl_rom_data,
 };
 
+static struct platform_device wm9712_device = {
+	.name	= "wm9712-codec",
+	.id	= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&tosascoop_device,
 	&tosascoop_jc_device,
@@ -895,6 +900,7 @@ static struct platform_device *devices[] __initdata = {
 	&tosa_bt_device,
 	&sharpsl_rom_device,
 	&tosa_gpio_vbus,
+	&wm9712_device,
 };
 
 static void tosa_poweroff(void)
-- 
1.7.2.3
