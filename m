From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 09/27] drivers/atm/of: don't use deprecated
	field in	of_platform_driver
Date: Thu, 11 Mar 2010 11:22:37 -0700
Message-ID: <20100311182237.13103.61327.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CA94103B0F
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:22:40 +0100 (CET)
Received: by mail-pw0-f51.google.com with SMTP id 10so163737pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:22:40 -0800 (PST)
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

 drivers/atm/fore200e.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 593a03a..da8f176 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -2695,8 +2695,11 @@ static const struct of_device_id fore200e_sba_match[] = {
 MODULE_DEVICE_TABLE(of, fore200e_sba_match);
 
 static struct of_platform_driver fore200e_sba_driver = {
-	.name		= "fore_200e",
-	.match_table	= fore200e_sba_match,
+	.driver = {
+		.name = "fore_200e",
+		.owner = THIS_MODULE,
+		.of_match_table = fore200e_sba_match,
+	},
 	.probe		= fore200e_sba_probe,
 	.remove		= __devexit_p(fore200e_sba_remove),
 };
