From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 23/27] drivers/infiniband/of: don't use
	deprecated fields in	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:55 -0700
Message-ID: <20100311182354.13103.40771.stgit__4112.81527854062$1268332003$gmane$org@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 2139F103B66
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:23:57 +0100 (CET)
Received: by mail-px0-f181.google.com with SMTP id 11so3407pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:23:57 -0800 (PST)
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

 drivers/infiniband/hw/ehca/ehca_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 2639185..252489e 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -937,12 +937,13 @@ static struct of_device_id ehca_device_table[] =
 MODULE_DEVICE_TABLE(of, ehca_device_table);
 
 static struct of_platform_driver ehca_driver = {
-	.name        = "ehca",
-	.match_table = ehca_device_table,
 	.probe       = ehca_probe,
 	.remove      = ehca_remove,
-	.driver	     = {
+	.driver = {
+		.name = "ehca",
+		.owner = THIS_MODULE,
 		.groups = ehca_drv_attr_groups,
+		.of_match_table = ehca_device_table,
 	},
 };
