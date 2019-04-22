From: Daniel Gomez <dagmcr@gmail.com>
Subject: [PATCH] spi: Madera codecs: add missing of table
	registration
Date: Mon, 22 Apr 2019 21:13:50 +0200
Message-ID: <1555960430-8899-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05427F80730
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2019 21:13:58 +0200 (CEST)
Received: by mail-lj1-x244.google.com with SMTP id h21so11202922ljk.13
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2019 12:13:58 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com, lee.jones@linaro.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, javier@dowhile0.org, dagmcr@gmail.com
List-Id: alsa-devel@alsa-project.org

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/mfd/madera-spi.ko  | grep alias
alias:          spi:wm1840
alias:          spi:cs47l91
alias:          spi:cs47l90
alias:          spi:cs47l85
alias:          spi:cs47l35

After this patch:
modinfo drivers/mfd/madera-spi.ko  | grep alias
alias:          spi:wm1840
alias:          spi:cs47l91
alias:          spi:cs47l90
alias:          spi:cs47l85
alias:          spi:cs47l35
alias:          of:N*T*Ccirrus,wm1840C*
alias:          of:N*T*Ccirrus,wm1840
alias:          of:N*T*Ccirrus,cs47l91C*
alias:          of:N*T*Ccirrus,cs47l91
alias:          of:N*T*Ccirrus,cs47l90C*
alias:          of:N*T*Ccirrus,cs47l90
alias:          of:N*T*Ccirrus,cs47l85C*
alias:          of:N*T*Ccirrus,cs47l85
alias:          of:N*T*Ccirrus,cs47l35C*
alias:          of:N*T*Ccirrus,cs47l35

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/mfd/madera-spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
index 4c398b2..1128584 100644
--- a/drivers/mfd/madera-spi.c
+++ b/drivers/mfd/madera-spi.c
@@ -121,6 +121,16 @@ static const struct spi_device_id madera_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, madera_spi_ids);
 
+const struct of_device_id madera_of_match[] = {
+	{ .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
+	{ .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
+	{ .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
+	{ .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
+	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, madera_of_match);
+
 static struct spi_driver madera_spi_driver = {
 	.driver = {
 		.name	= "madera",
-- 
2.7.4
