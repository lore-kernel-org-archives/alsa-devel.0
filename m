From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 08/27] drivers/crypto/of: don't use deprecated
	field in	of_platform_driver
Date: Thu, 11 Mar 2010 11:22:32 -0700
Message-ID: <20100311182231.13103.47091.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id D2F1F103AC7
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:22:40 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so181718pzk.23
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

 drivers/crypto/amcc/crypto4xx_core.c |    7 +++++--
 drivers/crypto/talitos.c             |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 1c3849f..36b5fb1 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1280,8 +1280,11 @@ static const struct of_device_id crypto4xx_match[] = {
 };
 
 static struct of_platform_driver crypto4xx_driver = {
-	.name		= "crypto4xx",
-	.match_table	= crypto4xx_match,
+	.driver = {
+		.name = "crypto4xx",
+		.owner = THIS_MODULE,
+		.of_match_table = crypto4xx_match,
+	},
 	.probe		= crypto4xx_probe,
 	.remove		= crypto4xx_remove,
 };
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index fd529d6..917faf7 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1967,8 +1967,11 @@ static const struct of_device_id talitos_match[] = {
 MODULE_DEVICE_TABLE(of, talitos_match);
 
 static struct of_platform_driver talitos_driver = {
-	.name = "talitos",
-	.match_table = talitos_match,
+	.driver = {
+		.name = "talitos",
+		.owner = THIS_MODULE,
+		.of_match_table = talitos_match,
+	},
 	.probe = talitos_probe,
 	.remove = talitos_remove,
 };
