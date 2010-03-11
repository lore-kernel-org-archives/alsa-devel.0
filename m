From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 06/37] arch/microblaze: use .dev.of_node
	instead of .node in	struct of_device
Date: Thu, 11 Mar 2010 11:04:21 -0700
Message-ID: <20100311180420.4824.30530.stgit__48220.0017235757$1268330818$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 417BF1039DB
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:04:24 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so171791pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:04:23 -0800 (PST)
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
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

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/of_device.c   |    8 ++++----
 arch/microblaze/kernel/of_platform.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/of_device.c b/arch/microblaze/kernel/of_device.c
index 12371bd..ae165fc 100644
--- a/arch/microblaze/kernel/of_device.c
+++ b/arch/microblaze/kernel/of_device.c
@@ -12,7 +12,7 @@
 void of_device_make_bus_id(struct of_device *dev)
 {
 	static atomic_t bus_no_reg_magic;
-	struct device_node *node = dev->node;
+	struct device_node *node = dev->dev.of_node;
 	const u32 *reg;
 	u64 addr;
 	int magic;
@@ -76,17 +76,17 @@ int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	ofdev = to_of_device(dev);
 
-	if (add_uevent_var(env, "OF_NAME=%s", ofdev->node->name))
+	if (add_uevent_var(env, "OF_NAME=%s", ofdev->dev.of_node->name))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->node->type))
+	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->dev.of_node->type))
 		return -ENOMEM;
 
 	/* Since the compatible field can contain pretty much anything
 	 * it's not really legal to split it out with commas. We split it
 	 * up using a number of environment variables instead. */
 
-	compat = of_get_property(ofdev->node, "compatible", &cplen);
+	compat = of_get_property(ofdev->dev.of_node, "compatible", &cplen);
 	while (compat && *compat && cplen > 0) {
 		if (add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat))
 			return -ENOMEM;
diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index 1c6d684..ea7d024 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -167,7 +167,7 @@ EXPORT_SYMBOL(of_platform_bus_probe);
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
-	return to_of_device(dev)->node == data;
+	return to_of_device(dev)->dev.of_node == data;
 }
 
 struct of_device *of_find_device_by_node(struct device_node *np)
@@ -185,7 +185,7 @@ EXPORT_SYMBOL(of_find_device_by_node);
 static int of_dev_phandle_match(struct device *dev, void *data)
 {
 	phandle *ph = data;
-	return to_of_device(dev)->node->phandle == *ph;
+	return to_of_device(dev)->dev.of_node->phandle == *ph;
 }
 
 struct of_device *of_find_device_by_phandle(phandle ph)
