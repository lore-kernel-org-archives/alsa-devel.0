From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 27/27] of: remove obsolete members from
	of_platform_driver
Date: Thu, 11 Mar 2010 11:24:17 -0700
Message-ID: <20100311182416.13103.38891.stgit__29604.1422560394$1268332047$gmane$org@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 0873C103B8A
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:24:20 +0100 (CET)
Received: by pzk41 with SMTP id 41so182691pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:24:20 -0800 (PST)
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

.name, .match_table and .owner already exist in struct device_driver.
Remove the duplication from struct of_platform_driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/platform.c       |    7 -------
 include/linux/of_platform.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9fd7f7d..ba402c6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -385,13 +385,6 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
 
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	if (!drv->driver.of_match_table)
-		drv->driver.of_match_table = drv->match_table;
 	drv->driver.bus = bus;
 
 	/* register with core */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index ac3ae07..1643d37 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -31,10 +31,6 @@ extern struct bus_type of_platform_bus_type;
  */
 struct of_platform_driver
 {
-	const char		*name;
-	const struct of_device_id	*match_table;
-	struct module		*owner;
-
 	int	(*probe)(struct of_device* dev,
 			 const struct of_device_id *match);
 	int	(*remove)(struct of_device* dev);
