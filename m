From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 18/27] drivers/parport/of: don't use deprecated
	field in	of_platform_driver
Date: Thu, 11 Mar 2010 11:23:27 -0700
Message-ID: <20100311182327.13103.91141.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 99AC4103B1E
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:23:30 +0100 (CET)
Received: by mail-px0-f181.google.com with SMTP id 11so3407pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:23:30 -0800 (PST)
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

 drivers/parport/parport_sunbpp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 065f229..9a5b4b8 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -382,8 +382,11 @@ static const struct of_device_id bpp_match[] = {
 MODULE_DEVICE_TABLE(of, bpp_match);
 
 static struct of_platform_driver bpp_sbus_driver = {
-	.name		= "bpp",
-	.match_table	= bpp_match,
+	.driver = {
+		.name = "bpp",
+		.owner = THIS_MODULE,
+		.of_match_table = bpp_match,
+	},
 	.probe		= bpp_probe,
 	.remove		= __devexit_p(bpp_remove),
 };
