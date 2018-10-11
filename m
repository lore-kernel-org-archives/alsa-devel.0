From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [RFC PATCH 3/4] ASoC: domain: Add sample rate domain
	support
Date: Thu, 11 Oct 2018 17:28:30 +0100
Message-ID: <20181011162831.26351-4-ckeepax@opensource.cirrus.com>
References: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A38267937
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 18:28:36 +0200 (CEST)
In-Reply-To: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The rate domain widgets allowed tracking of which hardware blocks
are physically bound to the same sample rate. The next step is to
follow which blocks are connected together as two directly connected
blocks should also run at the same rate, even though the hardware
may provide independent settings for them.

To acheive this two new concepts are introduced to ASoC, a rate
domain and a rate domain group. The rate domain group corresponds
to the rate domain widgets previously added to DAPM. And the domains
correspond to actual sample rates.

The rate domain groups internally track which other groups they
are connected to. These lists of peer groups are updated as DAPM
routes are connected/disconnected and form a collection of graphs
tracking which domain groups are connected.  Note that these graphs
are significantly smaller than the DAPM graph itself.

When a domain group's corresponding widget is powered up then
the group must locate an actual domain to attach to. Firstly, the
group will walk its peer graph, should it find it is attached to
widgets that require certain domains it will limit the choice to
those. For example if a widget is connected into a graph that is
already powered up then it will find the only suitable domain is
the one being currently used by the groups in the graph.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Thinking about trying to split this into two patches perhaps one
to add the tracking of the rate domain groups connecting together
and then a second patch to add the actual domains.

Thanks,
Charles

 include/sound/soc-dapm.h   |  12 +-
 include/sound/soc-domain.h |  98 +++++++++++
 include/sound/soc.h        |   8 +
 sound/soc/Makefile         |   2 +-
 sound/soc/soc-core.c       |   8 +
 sound/soc/soc-dapm.c       |  35 ++++
 sound/soc/soc-domain.c     | 412 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 573 insertions(+), 2 deletions(-)
 create mode 100644 include/sound/soc-domain.h
 create mode 100644 sound/soc/soc-domain.c

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c0ef27b2d4b22..c736b1d3e4931 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -275,7 +275,12 @@ struct device;
 
 #define SND_SOC_DAPM_RATE(wname, wreg, wshift, winvert, wops, wpriv) \
 {	.id = snd_soc_dapm_rate, .name = wname, \
-	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert) }
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.event = snd_soc_domain_event, \
+	.event_flags = SND_SOC_DAPM_WILL_PMU | SND_SOC_DAPM_PRE_PMU | \
+		       SND_SOC_DAPM_POST_PMD, \
+	.priv = (&(struct snd_soc_domain_group_driver){ \
+	.name = wname, .ops = wops, .private_data = wpriv}),}
 
 
 /* dapm kcontrol types */
@@ -410,6 +415,9 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
+int snd_soc_dapm_connect_domains(struct snd_soc_dapm_context *dapm,
+				 const char * const a, const char * const b);
+
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
@@ -629,6 +637,8 @@ struct snd_soc_dapm_widget {
 	int endpoints[2];
 
 	struct clk *clk;
+
+	struct snd_soc_domain_group *dgroup;
 };
 
 struct snd_soc_dapm_update {
diff --git a/include/sound/soc-domain.h b/include/sound/soc-domain.h
new file mode 100644
index 0000000000000..94e1c1ae9ff00
--- /dev/null
+++ b/include/sound/soc-domain.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ASoC Sample Rate Domain Support
+ *
+ * Copyright (c) 2018 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef LINUX_SND_SOC_DOMAIN_H
+#define LINUX_SND_SOC_DOMAIN_H
+
+#define SND_SOC_DOMAIN_CURRENT -1
+
+struct snd_soc_domain;
+struct snd_soc_domain_group;
+
+struct snd_soc_domain_ops {
+	int (*set_rate)(struct snd_soc_domain *domain, int rate);
+	int (*get_rate)(struct snd_soc_domain *domain);
+};
+
+struct snd_soc_domain_driver {
+	const char * const name;
+
+	const struct snd_soc_domain_ops *ops;
+
+	void *private_data;
+};
+
+struct snd_soc_domain {
+	const struct snd_soc_domain_driver *driver;
+	struct snd_soc_component *component;
+
+	/* TODO: Probably should be a snd_pcm_hw_params */
+	int rate;
+
+	int active_groups;
+};
+
+struct snd_soc_domain_group_ops {
+	int (*set_domain)(struct snd_soc_domain_group *group, int dom);
+
+	int (*mask_domains)(struct snd_soc_domain_group *group,
+			    unsigned long *domain_mask);
+	/* optional */
+	int (*pick_domain)(struct snd_soc_domain_group *group,
+			   const unsigned long *domain_mask);
+};
+
+struct snd_soc_domain_group_driver {
+	const char * const name;
+
+	const struct snd_soc_domain_group_ops *ops;
+
+	void *private_data;
+};
+
+struct snd_soc_domain_group {
+	const struct snd_soc_domain_group_driver *driver;
+	struct snd_soc_component *component;
+
+	int domain_index;
+	int attach_count;
+
+	struct list_head peers;
+
+	unsigned int walking:1;
+	unsigned int power:1;
+};
+
+int devm_snd_soc_domain_init(struct snd_soc_component *component);
+
+struct snd_soc_domain_group *
+devm_snd_soc_domain_group_new(struct snd_soc_component *component,
+			      const struct snd_soc_domain_group_driver *drv);
+
+struct snd_soc_domain *snd_soc_domain_get(struct snd_soc_domain_group *group,
+					  int index);
+bool snd_soc_domain_active(struct snd_soc_domain *domain);
+int snd_soc_domain_get_rate(struct snd_soc_domain *domain);
+
+int snd_soc_domain_set_rate(struct snd_soc_domain_group *group, int rate);
+
+/* TODO: API to force a particular domain onto a group? */
+int snd_soc_domain_attach(struct snd_soc_domain_group *group);
+int snd_soc_domain_detach(struct snd_soc_domain_group *group);
+
+int snd_soc_domain_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol,
+			 int event);
+
+int snd_soc_domain_connect_widgets(struct snd_soc_dapm_widget *a,
+				   struct snd_soc_dapm_widget *b,
+				   bool connect);
+
+#endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1dab1f4b194d..475843a17ebd4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -413,6 +413,7 @@ struct snd_soc_jack_pin;
 #include <sound/soc-dapm.h>
 #include <sound/soc-dpcm.h>
 #include <sound/soc-topology.h>
+#include <sound/soc-domain.h>
 
 struct snd_soc_jack_gpio;
 
@@ -763,6 +764,9 @@ struct snd_soc_component_driver {
 	const struct snd_soc_dapm_route *dapm_routes;
 	unsigned int num_dapm_routes;
 
+	const struct snd_soc_domain_driver *domains;
+	unsigned int num_domains;
+
 	int (*probe)(struct snd_soc_component *);
 	void (*remove)(struct snd_soc_component *);
 	int (*suspend)(struct snd_soc_component *);
@@ -838,6 +842,9 @@ struct snd_soc_component {
 	struct list_head dai_list;
 	int num_dai;
 
+	struct snd_soc_domain *domains;
+	int num_domains;
+
 	struct regmap *regmap;
 	int val_bytes;
 
@@ -1036,6 +1043,7 @@ struct snd_soc_card {
 
 	struct mutex mutex;
 	struct mutex dapm_mutex;
+	struct mutex domain_mutex;
 
 	bool instantiated;
 	bool topology_shortname_created;
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87c3cfc4..185f51aa963a2 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o
-snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
+snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o soc-domain.o
 snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
 ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 62e8e36062df0..4623adb27543b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1345,6 +1345,13 @@ static int soc_probe_component(struct snd_soc_card *card,
 		}
 	}
 
+	ret = devm_snd_soc_domain_init(component);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to initialise domains: %d\n",
+			ret);
+		goto err_probe;
+	}
+
 	if (component->driver->controls)
 		snd_soc_add_component_controls(component,
 					       component->driver->controls,
@@ -2739,6 +2746,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
+	mutex_init(&card->domain_mutex);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e3858d1e81dc..a3f01626fda76 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2179,6 +2179,9 @@ static void soc_dapm_connect_path(struct snd_soc_dapm_path *path,
 	if (path->connect == connect)
 		return;
 
+	/* TODO: Need to handle routes that are already connected */
+	snd_soc_domain_connect_widgets(path->source, path->sink, connect);
+
 	path->connect = connect;
 	dapm_mark_dirty(path->source, reason);
 	dapm_mark_dirty(path->sink, reason);
@@ -2685,6 +2688,14 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	if (wsource->is_supply || wsink->is_supply)
 		path->is_supply = 1;
 
+	switch (wsource->id) {
+	case snd_soc_dapm_rate:
+		wsink->dgroup = wsource->dgroup;
+		break;
+	default:
+		break;
+	}
+
 	/* connect static paths */
 	if (control == NULL) {
 		path->connect = 1;
@@ -3463,6 +3474,14 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			goto request_failed;
 		}
 		break;
+	case snd_soc_dapm_rate:
+		w->dgroup = devm_snd_soc_domain_group_new(dapm->component,
+							  w->priv);
+		if (IS_ERR(w->dgroup)) {
+			ret = PTR_ERR(w->dgroup);
+			goto request_failed;
+		}
+		break;
 	default:
 		break;
 	}
@@ -4566,6 +4585,22 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 					    SND_SOC_BIAS_OFF);
 }
 
+int snd_soc_dapm_connect_domains(struct snd_soc_dapm_context *dapm,
+				 const char * const a, const char * const b)
+{
+	struct snd_soc_dapm_widget *wa, *wb;
+
+	wa = dapm_find_widget(dapm, a, false);
+	if (!wa)
+		return -ENODEV;
+	wb = dapm_find_widget(dapm, b, false);
+	if (!wb)
+		return -ENODEV;
+
+	return snd_soc_domain_connect_widgets(wa, wb, true);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_connect_domains);
+
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood, lrg@slimlogic.co.uk");
 MODULE_DESCRIPTION("Dynamic Audio Power Management core for ALSA SoC");
diff --git a/sound/soc/soc-domain.c b/sound/soc/soc-domain.c
new file mode 100644
index 0000000000000..01914d5971601
--- /dev/null
+++ b/sound/soc/soc-domain.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ASoC Sample Rate Domain Support
+ *
+ * Copyright (c) 2018 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+
+struct domain_group_peer {
+	struct list_head list;
+	int link_count;
+	struct snd_soc_domain_group *group;
+};
+
+static inline void domain_mutex_lock(struct snd_soc_component *component)
+{
+	mutex_lock(&component->card->domain_mutex);
+}
+
+static inline void domain_mutex_unlock(struct snd_soc_component *component)
+{
+	mutex_unlock(&component->card->domain_mutex);
+}
+
+static inline void domain_mutex_assert_held(struct snd_soc_component *component)
+{
+	lockdep_assert_held(&component->card->domain_mutex);
+}
+
+int devm_snd_soc_domain_init(struct snd_soc_component *component)
+{
+	int i;
+
+	if (!component->driver->num_domains)
+		return 0;
+
+	component->num_domains = component->driver->num_domains;
+	component->domains = devm_kcalloc(component->card->dev,
+					  component->num_domains,
+					  sizeof(*component->domains),
+					  GFP_KERNEL);
+	if (!component->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < component->num_domains; i++) {
+		component->domains[i].component = component;
+		component->domains[i].driver = &component->driver->domains[i];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_snd_soc_domain_init);
+
+struct snd_soc_domain_group *
+devm_snd_soc_domain_group_new(struct snd_soc_component *component,
+			      const struct snd_soc_domain_group_driver *driver)
+{
+	struct snd_soc_domain_group *group;
+
+	group = devm_kzalloc(component->card->dev, sizeof(*group), GFP_KERNEL);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&group->peers);
+
+	group->component = component;
+	group->driver = driver;
+
+	return group;
+}
+EXPORT_SYMBOL_GPL(devm_snd_soc_domain_group_new);
+
+struct snd_soc_domain *snd_soc_domain_get(struct snd_soc_domain_group *group,
+					  int index)
+{
+	int ndomains = group->component->num_domains;
+
+	domain_mutex_assert_held(group->component);
+
+	if (index == SND_SOC_DOMAIN_CURRENT)
+		index = group->domain_index;
+
+	if (index < 0 || index >= ndomains)
+		return NULL;
+
+	return &group->component->domains[index];
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_get);
+
+bool snd_soc_domain_active(struct snd_soc_domain *domain)
+{
+	bool active;
+
+	domain_mutex_assert_held(domain->component);
+
+	active = !!domain->active_groups;
+
+	return active;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_active);
+
+int snd_soc_domain_get_rate(struct snd_soc_domain *domain)
+{
+	domain_mutex_assert_held(domain->component);
+
+	return domain->rate;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_get_rate);
+
+int snd_soc_domain_set_rate(struct snd_soc_domain_group *group, int rate)
+{
+	struct snd_soc_domain *domain;
+	int ret = -ENODEV;
+
+	domain_mutex_lock(group->component);
+
+	domain = snd_soc_domain_get(group, SND_SOC_DOMAIN_CURRENT);
+	if (domain) {
+		domain->rate = rate;
+		ret = domain->driver->ops->set_rate(domain, rate);
+	}
+
+	domain_mutex_unlock(group->component);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_set_rate);
+
+static struct snd_soc_domain_group *
+group_walk(struct snd_soc_domain_group *group, bool local,
+	   bool (*cond)(struct snd_soc_domain_group *g, void *c), void *cookie)
+{
+	struct domain_group_peer *link;
+	struct snd_soc_domain_group *target = NULL;
+
+	domain_mutex_assert_held(group->component);
+
+	if (group->walking)
+		return NULL;
+
+	dev_vdbg(group->component->dev, "Walking %s\n", group->driver->name);
+
+	if (cond(group, cookie))
+		return group;
+
+	group->walking = true;
+	list_for_each_entry(link, &group->peers, list) {
+		if (!link->group->power)
+			continue;
+
+		if (local && link->group->component != group->component)
+			continue;
+
+		target = group_walk(link->group, local, cond, cookie);
+		if (target)
+			break;
+	}
+	group->walking = false;
+
+	return target;
+}
+
+static bool group_mask(struct snd_soc_domain_group *group, void *cookie)
+{
+	unsigned long *mask = cookie;
+
+	if (group->attach_count)
+		*mask &= 1 << group->domain_index;
+	else if (group->driver->ops->mask_domains)
+		group->driver->ops->mask_domains(group, mask);
+
+	return false;
+}
+
+static int group_pick(struct snd_soc_domain_group *group,
+				const unsigned long *domain_mask)
+{
+	int ndomains = group->component->num_domains;
+	int i;
+
+	domain_mutex_assert_held(group->component);
+
+	for_each_set_bit(i, domain_mask, ndomains) {
+		struct snd_soc_domain *domain = &group->component->domains[i];
+
+		if (!snd_soc_domain_active(domain))
+			return i;
+	}
+
+	return find_first_bit(domain_mask, ndomains);
+}
+
+int snd_soc_domain_attach(struct snd_soc_domain_group *group)
+{
+	int ret = 0;
+
+	domain_mutex_lock(group->component);
+
+	dev_dbg(group->component->dev, "Attaching domain to %s: %d\n",
+		group->driver->name, group->attach_count);
+
+	if (!group->attach_count) {
+		const struct snd_soc_domain_group_ops *ops = group->driver->ops;
+		unsigned long dom_map = ~0UL;
+		struct snd_soc_domain *domain;
+
+		group_walk(group, true, group_mask, &dom_map);
+
+		if (ops->pick_domain)
+			group->domain_index = ops->pick_domain(group, &dom_map);
+		else
+			group->domain_index = group_pick(group, &dom_map);
+
+		domain = snd_soc_domain_get(group, SND_SOC_DOMAIN_CURRENT);
+		if (!domain) {
+			dev_err(group->component->dev,
+				"No suitable domain to attach for %s\n",
+				group->driver->name);
+			ret = -ENODEV;
+			goto error;
+		}
+
+		dev_dbg(group->component->dev, "Apply domain %s to %s\n",
+			domain->driver->name, group->driver->name);
+
+		ret = ops->set_domain(group, group->domain_index);
+		if (ret)
+			goto error;
+
+		domain->active_groups++;
+	}
+
+	group->attach_count++;
+
+error:
+	domain_mutex_unlock(group->component);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_attach);
+
+int snd_soc_domain_detach(struct snd_soc_domain_group *group)
+{
+	int ret = 0;
+
+	domain_mutex_lock(group->component);
+
+	dev_dbg(group->component->dev, "Detaching domain from %s: %d\n",
+		group->driver->name, group->attach_count);
+
+	if (!group->attach_count) {
+		dev_err(group->component->dev, "Unbalanced detach on %s\n",
+			group->driver->name);
+		ret = -EPERM;
+	} else {
+		struct snd_soc_domain *domain;
+
+		domain = snd_soc_domain_get(group, SND_SOC_DOMAIN_CURRENT);
+		if (!domain) {
+			dev_err(group->component->dev,
+				"Group %s has missing domain\n",
+				group->driver->name);
+			ret = -ENODEV;
+			goto error;
+		}
+
+		domain->active_groups--;
+		group->attach_count--;
+	}
+
+error:
+	domain_mutex_unlock(group->component);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_detach);
+
+int snd_soc_domain_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol,
+			 int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_WILL_PMU:
+		w->dgroup->power = true;
+		return 0;
+	case SND_SOC_DAPM_PRE_PMU:
+		return snd_soc_domain_attach(w->dgroup);
+	case SND_SOC_DAPM_POST_PMD:
+		w->dgroup->power = false;
+		return snd_soc_domain_detach(w->dgroup);
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_event);
+
+static struct domain_group_peer *
+group_peer_find(struct snd_soc_domain_group *group,
+		struct snd_soc_domain_group *peer)
+{
+	struct domain_group_peer *link;
+
+	domain_mutex_assert_held(group->component);
+
+	list_for_each_entry(link, &group->peers, list) {
+		if (link->group == peer)
+			return link;
+	}
+
+	return NULL;
+}
+
+static int group_peer_new(struct snd_soc_domain_group *group,
+			  struct snd_soc_domain_group *peer)
+{
+	struct domain_group_peer *link;
+
+	domain_mutex_lock(group->component);
+
+	link = group_peer_find(group, peer);
+	if (!link) {
+		dev_dbg(group->component->dev, "New peer: %s -> %s\n",
+			group->driver->name, peer->driver->name);
+
+		link = kzalloc(sizeof(*link), GFP_KERNEL);
+		if (!link)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&link->list);
+		link->group = peer;
+
+		list_add_tail(&link->list, &group->peers);
+	}
+
+	link->link_count++;
+
+	domain_mutex_unlock(group->component);
+
+	return 0;
+}
+
+static int group_peer_delete(struct snd_soc_domain_group *group,
+			     struct snd_soc_domain_group *peer)
+{
+	struct domain_group_peer *link;
+	int ret = 0;
+
+	domain_mutex_lock(group->component);
+
+	link = group_peer_find(group, peer);
+	if (!link) {
+		dev_err(group->component->dev,
+			"Delete on invalid peer: %s -> %s\n",
+			group->driver->name, peer->driver->name);
+		ret = -ENOENT;
+		goto error;
+	}
+
+	link->link_count--;
+	if (!link->link_count) {
+		dev_dbg(group->component->dev, "Delete peer: %s -> %s\n",
+			group->driver->name, peer->driver->name);
+
+		list_del(&link->list);
+		kfree(link);
+	}
+
+error:
+	domain_mutex_unlock(group->component);
+
+	return ret;
+}
+
+int snd_soc_domain_connect_widgets(struct snd_soc_dapm_widget *a,
+				   struct snd_soc_dapm_widget *b,
+				   bool connect)
+{
+	int (*op)(struct snd_soc_domain_group *group,
+		  struct snd_soc_domain_group *peer);
+	int ret;
+
+	if (!a->dgroup || !b->dgroup)
+		return 0;
+
+	dev_dbg(a->dapm->dev, "%s %s,%s - %s,%s\n",
+		connect ? "Connecting" : "Disconnecting",
+		a->name, a->dgroup->driver->name,
+		b->name, b->dgroup->driver->name);
+
+	if (connect)
+		op = group_peer_new;
+	else
+		op = group_peer_delete;
+
+	ret = op(a->dgroup, b->dgroup);
+	if (ret)
+		return ret;
+
+	ret = op(b->dgroup, a->dgroup);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_domain_connect_widgets);
-- 
2.11.0
