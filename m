From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] ASoC: hw-params-rules: add generic hw_params-rules
Date: Fri, 20 May 2016 12:30:44 +0000
Message-ID: <1463747445-14167-2-git-send-email-kernel@martin.sperl.org>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463747445-14167-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add generic rules that may execute when running hw_params
methods.

These rules are configured via the device-tree.

Right now only a static list of match and action rules exist.
This can get changed in the future to something more dynamic
if security concerns can get handled propperly.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../devicetree/bindings/sound/hw-params-rules.txt  |  86 +++++
 sound/soc/generic/Kconfig                          |   6 +
 sound/soc/generic/Makefile                         |   2 +
 sound/soc/generic/hw-params-rules.c                | 402 +++++++++++++++++++++
 sound/soc/generic/hw-params-rules.h                |  49 +++
 5 files changed, 545 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hw-params-rules.txt
 create mode 100644 sound/soc/generic/hw-params-rules.c
 create mode 100644 sound/soc/generic/hw-params-rules.h

diff --git a/Documentation/devicetree/bindings/sound/hw-params-rules.txt b/Documentation/devicetree/bindings/sound/hw-params-rules.txt
new file mode 100644
index 0000000..8e5f2b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hw-params-rules.txt
@@ -0,0 +1,86 @@
+HW-params-rules:
+
+Rules that execute actions during hw-params method calls.
+
+The following optional nodes will sit inside the sound card nodes:
+
+hw-params-rule subnodes:
+
+Required properties:
+- priority: the priority of the rule - lowest is applied first.
+
+contains further subnodes:
+
+- match:  list of matches that have to apply
+- action: list of actions to execute
+
+match and action subnodes:
+
+Required properties:
+
+- method: the method name (string) to execute
+
+Possible values for method:
+* asoc_generic_hw_params_match_sample_bits
+* asoc_generic_hw_params_match_rate
+* asoc_generic_hw_params_match_channel
+* asoc_generic_hw_params_set_fixed_bclk_size
+
+
+Required/optional properties depend on the method defined
+typical properies:
+
+- value: u32 value to pass to method.
+- values: u32 value array to pass to method.
+
+Example:
+sound {
+	compatible = "simple-audio-card";
+	...
+	/*
+	 * set bclk_size to 80 when encountering:
+	 * 48kHz or 96kHz with 2 channels with 32bit/channel
+	 */
+	hw-params-rule@0 {
+		priority = <0>;
+		match@0 {
+			method = "asoc_generic_hw_params_match_sample_bits";
+			values = <32>;
+		};
+		match@1 {
+			method = "asoc_generic_hw_params_match_rate";
+			values = <48000>, <96000>;
+		};
+		match@2 {
+			method = "asoc_generic_hw_params_match_channels";
+			values = <2>;
+		};
+		action@0 {
+			method = "asoc_generic_hw_params_set_fixed_bclk_size";
+			value = <80>;
+		};
+	};
+	/*
+	 * set bclk_size to 40 when encountering:
+	 * 48kHz with 2 channels with 16bit/channel
+	 */
+	hw-params-rule@1 {
+		priority = <1>;
+		match@0 {
+			method = "asoc_generic_hw_params_match_sample_bits";
+			values = <16>;
+		};
+		match@1 {
+			method = "asoc_generic_hw_params_match_rate";
+			values = <48000>;
+		};
+		match@2 {
+			method = "asoc_generic_hw_params_match_channels";
+			values = <2>;
+		};
+		action@0 {
+			method = "asoc_generic_hw_params_set_fixed_bclk_size";
+			value = <40>;
+		};
+	};
+};
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 610f612..2c9f0c1 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -1,3 +1,9 @@
+config SND_HW_PARAMS_RULES
+	tristate "ASoC hw_param rules support"
+	depends on OF
+	help
+	  This option enables generic hw_param_rules support
+
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
 	help
diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 9c3b246..4eaad07 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -1,3 +1,5 @@
 snd-soc-simple-card-objs	:= simple-card.o
+snd-soc-hw-params-rules-objs	:= hw-params-rules.o
 
 obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o
+obj-$(CONFIG_SND_HW_PARAMS_RULES)	+= snd-soc-hw-params-rules.o
diff --git a/sound/soc/generic/hw-params-rules.c b/sound/soc/generic/hw-params-rules.c
new file mode 100644
index 0000000..46dbdff
--- /dev/null
+++ b/sound/soc/generic/hw-params-rules.c
@@ -0,0 +1,402 @@
+/*
+ * ASoC generic hw_params_rules support
+ *
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/list_sort.h>
+#include <sound/pcm_params.h>
+#include <sound/simple_card.h>
+#include <sound/soc-dai.h>
+#include <sound/soc.h>
+
+struct snd_soc_hw_params_actionmatch {
+	struct list_head list;
+	int (*method)(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *params,
+		      void *data);
+	void *data;
+};
+
+struct snd_soc_hw_param_rule {
+	struct list_head list;
+	const char *name;
+	u32 priority;
+	struct list_head matches;
+	struct list_head actions;
+};
+
+struct snd_soc_size_u32array {
+	size_t size;
+	u32 data[];
+};
+
+static int asoc_generic_hw_params_read_u32array(
+	struct device *dev, struct device_node *node, void **data)
+{
+	int i, size, ret;
+	struct snd_soc_size_u32array *array;
+
+	size = of_property_count_elems_of_size(node, "values", sizeof(u32));
+	if (size < 0) {
+		dev_err(dev,
+			"%s: Could not read size of property \"values\" - %d\n",
+			of_node_full_name(node), size);
+		return size;
+	}
+
+	array = devm_kzalloc(dev, sizeof(*array) + sizeof(u32) * size,
+			     GFP_KERNEL);
+	if (!array)
+		return -ENOMEM;
+	*data = array;
+
+	array->size = size;
+
+	for (i = 0; i < size; i++) {
+		ret = of_property_read_u32(node, "values", &array->data[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_read_u32(
+	struct device *dev, struct device_node *node, void **data)
+{
+	return of_property_read_u32(node, "value", (u32 *)data);
+}
+
+static int asoc_generic_hw_params_match_sample_bits(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	void *data)
+{
+	long int bits =
+		snd_pcm_format_physical_width(params_format(params));
+	struct snd_soc_size_u32array *array = data;
+	int i;
+
+	for (i = 0; i < array->size; i++) {
+		if (bits == array->data[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_match_channels(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	void *data)
+{
+	int channels = params_channels(params);
+	struct snd_soc_size_u32array *array = data;
+	int i;
+
+	for (i = 0; i < array->size; i++) {
+		if (channels == array->data[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_match_rate(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	void *data)
+{
+	long int rate = params_rate(params);
+
+	struct snd_soc_size_u32array *array = data;
+	int i;
+
+	for (i = 0; i < array->size; i++) {
+		if (rate == array->data[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_set_fixed_bclk_size(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	void *data)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	return snd_soc_dai_set_bclk_ratio(cpu_dai, (unsigned int)data);
+}
+
+struct asoc_generic_hw_params_method {
+	const char *name;
+	int (*method)(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *params,
+		      void *data);
+	int (*parse)(struct device *dev, struct device_node *node,
+		     void **data);
+};
+
+#define HW_PARAMS_METHOD(m, p)		\
+	{.name = #m, .method = m, .parse = p }
+#define HW_PARAMS_METHOD_U32(n) \
+	HW_PARAMS_METHOD(n, asoc_generic_hw_params_read_u32)
+#define HW_PARAMS_METHOD_U32ARRAY(n) \
+	HW_PARAMS_METHOD(n, asoc_generic_hw_params_read_u32array)
+
+static const struct asoc_generic_hw_params_method
+asoc_generic_hw_params_methods[] = {
+	HW_PARAMS_METHOD_U32ARRAY(asoc_generic_hw_params_match_sample_bits),
+	HW_PARAMS_METHOD_U32ARRAY(asoc_generic_hw_params_match_rate),
+	HW_PARAMS_METHOD_U32ARRAY(asoc_generic_hw_params_match_channels),
+	HW_PARAMS_METHOD_U32(asoc_generic_hw_params_set_fixed_bclk_size)
+};
+
+static int asoc_generic_hw_params_lookup_methods(
+	struct device *dev, const char *method,
+	struct device_node *node,
+	struct snd_soc_hw_params_actionmatch *am)
+{
+	const struct asoc_generic_hw_params_method *m;
+	size_t i;
+
+	/*
+	 * hardcoded list of "allowed" methods
+	 * maybe a more dynamic approach using kallsyms could also be taken
+	 */
+	for (i = 0; i < ARRAY_SIZE(asoc_generic_hw_params_methods); i++) {
+		m = &asoc_generic_hw_params_methods[i];
+		if (strcmp(m->name, method) == 0) {
+			am->method = m->method;
+			if (m->parse)
+				return m->parse(dev, node, &am->data);
+			else
+				return 0;
+		}
+	}
+
+	dev_err(dev, "%s: method %s not found\n",
+		of_node_full_name(node), method);
+	return -EINVAL;
+}
+
+static int asoc_generic_hw_params_handle_rule(
+	struct snd_soc_hw_param_rule *rule,
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->dev;
+	struct snd_soc_hw_params_actionmatch *am;
+	int ret;
+
+	dev_dbg(dev, "Trying to apply rule: %s\n", rule->name);
+
+	/* apply match rules */
+	list_for_each_entry(am, &rule->matches, list) {
+		dev_dbg(dev, "\tRunning match %pf(%pK)\n",
+			am->method, am->data);
+		/* match method return 0 on match, 1 otherwise */
+		ret = am->method(substream, params, am->data);
+		if (!ret)
+			return 1;
+	}
+
+	/* so we match, so run all the actions */
+	list_for_each_entry(am, &rule->actions, list) {
+		dev_dbg(dev, "\tRunning action %pf(%pK)\n",
+			am->method, am->data);
+		/* action method returns 0 on success */
+		ret = am->method(substream, params, am->data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int asoc_generic_hw_params_process_rules(
+	struct list_head *list_head,
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_hw_param_rule *rule;
+	int ret;
+
+	/* check if the list_head is initialized */
+	if (!list_head->next)
+		return 0;
+
+	/* iterate all rules */
+	list_for_each_entry(rule, list_head, list) {
+		ret = asoc_generic_hw_params_handle_rule(
+			rule, substream, params);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_generic_hw_params_process_rules);
+
+static int asoc_generic_hw_params_actionmatch_parse_of(
+	struct device *dev, struct device_node *node,
+	struct list_head *list_head, const char *nodename)
+{
+	struct snd_soc_hw_params_actionmatch *am;
+	const char *methodname;
+	int ret;
+
+	/* get the method name */
+	ret = of_property_read_string(node, "method", &methodname);
+	if (ret) {
+		dev_err(dev, "%s: missing \"method\" property - %d\n",
+			of_node_full_name(node), ret);
+		return ret;
+	}
+
+	/* alloc the action/match */
+	am = devm_kzalloc(dev, sizeof(*am), GFP_KERNEL);
+	if (!am)
+		return -ENOMEM;
+
+	/* lookup the method */
+	ret = asoc_generic_hw_params_lookup_methods(dev, methodname,
+						    node, am);
+	if (ret)
+		return ret;
+
+	/* append to list */
+	list_add_tail(&am->list, list_head);
+
+	dev_dbg(dev, "\t\tadded %s: %s - %pf(%pK)\n", nodename,
+		of_node_full_name(node), am->method, am->data);
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_actionmatches_parse_of(
+	struct device *dev, struct device_node *node,
+	struct list_head *list_head, const char *nodename)
+{
+	struct device_node *np = NULL;
+	int ret = 0;
+
+	/* init matchers */
+	INIT_LIST_HEAD(list_head);
+
+	/* iterate over all child nodes */
+	for_each_child_of_node(node, np) {
+		if (np->name && (of_node_cmp(np->name, nodename) == 0)) {
+			ret = asoc_generic_hw_params_actionmatch_parse_of(
+				dev, np, list_head, nodename);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_rule_parse_of(
+	struct device *dev, struct device_node *node,
+	struct list_head *list_head)
+{
+	struct snd_soc_hw_param_rule *rule;
+	int ret;
+
+	rule = devm_kzalloc(dev, sizeof(*rule), GFP_KERNEL);
+	if (!rule)
+		return -ENOMEM;
+
+	rule->name = of_node_full_name(node);
+
+	dev_dbg(dev, "\tadding Rule: %s\n", rule->name);
+
+	/* read priority */
+	ret = of_property_read_u32(node, "priority", &rule->priority);
+	if (ret) {
+		dev_err(dev, "%s: can not read \"priority\" - %d\n",
+			rule->name, ret);
+		return ret;
+	}
+
+	/* parse all matches sub-nodes */
+	ret = asoc_generic_hw_params_actionmatches_parse_of(
+		dev, node, &rule->matches, "match");
+	if (ret)
+		return ret;
+
+	/* parse all action sub-nodes */
+	ret = asoc_generic_hw_params_actionmatches_parse_of(
+		dev, node, &rule->actions, "action");
+	if (ret)
+		return ret;
+
+	/* append to list */
+	list_add_tail(&rule->list, list_head);
+
+	return 0;
+}
+
+static int asoc_generic_hw_params_rules_sort(
+	void *data, struct list_head *a, struct list_head *b)
+{
+	struct snd_soc_hw_param_rule *rulea =
+		container_of(a, typeof(*rulea), list);
+	struct snd_soc_hw_param_rule *ruleb =
+		container_of(b, typeof(*ruleb), list);
+
+	if (rulea->priority < ruleb->priority)
+		return -1;
+	if (rulea->priority > ruleb->priority)
+		return 1;
+
+	return 0;
+}
+
+int asoc_generic_hw_params_rules_parse_of(
+	struct device *dev,
+	struct device_node *node,
+	struct list_head *list_head)
+{
+	const char *nodename = "hw-params-rule";
+	struct device_node *np = NULL;
+	int ret = 0;
+
+	/* init matchers */
+	INIT_LIST_HEAD(list_head);
+
+	if (!of_get_child_by_name(node, nodename))
+		return 0;
+
+	for (np = of_find_node_by_name(node, nodename); np;
+	     np = of_find_node_by_name(np, nodename)) {
+		ret = asoc_generic_hw_params_rule_parse_of(
+			dev, np, list_head);
+		if (ret)
+			return ret;
+	}
+
+	/* and sort by name */
+	list_sort(dev, list_head, asoc_generic_hw_params_rules_sort);
+
+	/* iterate the sub-nodes */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_generic_hw_params_rules_parse_of);
+
+MODULE_AUTHOR("Martin Sperl");
+MODULE_DESCRIPTION("generic hw_params_rules support");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/generic/hw-params-rules.h b/sound/soc/generic/hw-params-rules.h
new file mode 100644
index 0000000..0b054ce
--- /dev/null
+++ b/sound/soc/generic/hw-params-rules.h
@@ -0,0 +1,49 @@
+/*
+ * ASoC generic hw_params_rules support
+ *
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __HW_PARAMS_RULES_H
+#define __HW_PARAMS_RULES_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <sound/pcm.h>
+
+#if defined(CONFIG_SND_HW_PARAMS_RULES) ||	\
+	defined(CONFIG_SND_HW_PARAMS_RULES_MODULE)
+
+int asoc_generic_hw_params_rules_parse_of(
+	struct device *dev,
+	struct device_node *node,
+	struct list_head *list_head);
+
+int asoc_generic_hw_params_process_rules(
+	struct list_head *list_head,
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params);
+#else
+static int asoc_generic_hw_params_rules_parse_of(
+	struct device *dev,
+	struct device_node *node,
+	struct list_head *list_head)
+{
+	return 0;
+}
+
+static int asoc_generic_hw_params_process_rules(
+	struct list_head *list_head,
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	return 0;
+}
+#endif
+
+#endif
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
