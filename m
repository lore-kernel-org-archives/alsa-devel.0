From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 20/27] drivers/mmc/of: don't use deprecated
	field in	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:38 -0700
Message-ID: <20100311182338.13103.88443.stgit__36171.7611238875$1268331985$gmane$org@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 37148103B5C
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:23:43 +0100 (CET)
Received: by pwj10 with SMTP id 10so164218pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:23:41 -0800 (PST)
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

 drivers/mmc/host/sdhci-of-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index dfe5cea..7802a54 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -205,8 +205,11 @@ static const struct of_device_id sdhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_of_match);
 
 static struct of_platform_driver sdhci_of_driver = {
-	.driver.name = "sdhci-of",
-	.match_table = sdhci_of_match,
+	.driver = {
+		.name = "sdhci-of",
+		.owner = THIS_MODULE,
+		.of_match_table = sdhci_of_match,
+	},
 	.probe = sdhci_of_probe,
 	.remove = __devexit_p(sdhci_of_remove),
 	.suspend = sdhci_of_suspend,
