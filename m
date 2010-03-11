From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 16/27] drivers/scsi/of: don't use deprecated
	field in	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:16 -0700
Message-ID: <20100311182316.13103.87138.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BC2B103B42
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:23:19 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so181718pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:23:19 -0800 (PST)
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade
List-Id: alsa-devel@alsa-project.org

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/scsi/qlogicpti.c |    7 +++++--
 drivers/scsi/sun_esp.c   |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 7374fbe..16dc12e 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1456,8 +1456,11 @@ static const struct of_device_id qpti_match[] = {
 MODULE_DEVICE_TABLE(of, qpti_match);
 
 static struct of_platform_driver qpti_sbus_driver = {
-	.name		= "qpti",
-	.match_table	= qpti_match,
+	.driver = {
+		.name = "qpti",
+		.owner = THIS_MODULE,
+		.of_match_table = qpti_match,
+	},
 	.probe		= qpti_sbus_probe,
 	.remove		= __devexit_p(qpti_sbus_remove),
 };
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 4369b76..10ba30a 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -632,8 +632,11 @@ static const struct of_device_id esp_match[] = {
 MODULE_DEVICE_TABLE(of, esp_match);
 
 static struct of_platform_driver esp_sbus_driver = {
-	.name		= "esp",
-	.match_table	= esp_match,
+	.driver = {
+		.name = "esp",
+		.owner = THIS_MODULE,
+		.of_match_table = esp_match,
+	},
 	.probe		= esp_sbus_probe,
 	.remove		= __devexit_p(esp_sbus_remove),
 };
