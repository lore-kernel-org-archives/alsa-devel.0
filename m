From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 1/9] soc: qcom: add support APR driver
Date: Fri, 11 Aug 2017 15:29:44 +0200
Message-ID: <20170811132952.32572-2-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id CF80C267632
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:30:04 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id j32so20183375iod.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 06:30:04 -0700 (PDT)
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, sboyd@codeaurora.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <andy.gross@linaro.org>, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to APR (Asynchronous Packet Router) driver,
which is used communication between application processor and QDSP to
use services on QDSP like Audio and others.

CC: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |  66 ++++
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/apr.c                             | 406 +++++++++++++++++++++
 include/linux/soc/qcom/apr.h                       | 163 +++++++++
 5 files changed, 644 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/linux/soc/qcom/apr.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
new file mode 100644
index 0000000..6fdb8d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -0,0 +1,66 @@
+Qualcomm APR (Asynchronous Packet Router) binding
+
+This binding describes the Qualcomm APR. APR is a IPC protocol for
+communication between Application processor and QDSP. APR is mainly
+used for audio/voice services on the QDSP.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apr-<SOC-NAME>" example: "qcom,apr-msm8996"
+
+
+- qcom,smd-channel:
+	Usage: required
+	Value type: <string>
+	Definition: standard SMD property specifying the SMD channel used for
+		    communication with the APR on QDSP.
+		    Should be "apr_audio_svc".
+= APR DEVICES
+Each subnode of APR node represents services/devices that are only available
+when APR is active.
+
+= EXAMPLE
+The following example represents a QDSP based sound card on a MSM8996 device
+which uses apr as communication between Apps and QDSP.
+
+	apr {
+		compatible = "qcom,apr-msm8996";
+		qcom,smd-channels = "apr_audio_svc";
+
+		pcm: pcm0 {
+			compatible = "qcom,msm-pcm-dsp";
+			...
+		};
+
+		routing:routing {
+			compatible = "qcom,msm-pcm-routing";
+			#sound-dai-cells = <0>;
+			...
+		};
+
+		hdmi_dai: dai_hdmi {
+			compatible = "qcom,msm-dai-q6-hdmi";
+			#sound-dai-cells = <0>;
+			...
+		};
+
+		snd {
+			compatible	= "qcom,snd-apq8096";
+			qcom,model = "DB820c";
+			...
+		};
+
+		adm {
+			compatible = "qcom,q6adm";
+		};
+
+		asm {
+			compatible = "qcom,q6asm";
+		};
+
+		afe: afe {
+			compatible = "qcom,q6afe-v2";
+		};
+
+	};
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 6c5ba05..1c0e64a 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -115,3 +115,11 @@ config BUS_TOPOLOGY_ADHOC
 		directionality of connections by explicitly listing device connections
 		thus avoiding illegal routes.
 
+config QCOM_APR
+	tristate "Qualcomm APR (Asynchronous Packet Router)"
+	depends on (RPMSG_QCOM_SMD || RPMSG_QCOM_GLINK_RPM)
+	help
+          Enable APR IPC protocol support between
+          application processor and QDSP6. APR is
+          used by audio driver to configure QDSP6
+          ASM, ADM and AFE modules.
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index a946e41..78fa1d8 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 
 obj-$(CONFIG_MSM_BUS_SCALING) += msm_bus/
 obj-$(CONFIG_BUS_TOPOLOGY_ADHOC) += msm_bus/
+obj-$(CONFIG_QCOM_APR) += apr.o
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
new file mode 100644
index 0000000..0f10cf2
--- /dev/null
+++ b/drivers/soc/qcom/apr.c
@@ -0,0 +1,406 @@
+/* Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/rpmsg.h>
+#include <linux/of.h>
+
+struct apr_ops {
+	int (*get_data_src)(struct apr_hdr *hdr);
+};
+
+struct apr {
+	struct rpmsg_endpoint *ch;
+	struct device *dev;
+	struct mutex svcs_lock;
+	struct list_head svcs;
+	int svc_cnt;
+	int dest_id;
+	int client_id;
+	const struct apr_ops *ops;
+};
+
+struct apr_svc_table {
+	char name[64];
+	int id;
+	int client_id;
+};
+
+static const struct apr_svc_table svc_tbl_qdsp6[] = {
+	{ "AFE", APR_SVC_AFE, APR_CLIENT_AUDIO, },
+	{ "ASM", APR_SVC_ASM, APR_CLIENT_AUDIO, },
+	{ "ADM", APR_SVC_ADM, APR_CLIENT_AUDIO, },
+	{ "CORE", APR_SVC_ADSP_CORE, APR_CLIENT_AUDIO, },
+	{ "TEST", APR_SVC_TEST_CLIENT, APR_CLIENT_AUDIO, },
+	{ "MVM", APR_SVC_ADSP_MVM, APR_CLIENT_AUDIO, },
+	{ "CVS", APR_SVC_ADSP_CVS, APR_CLIENT_AUDIO, },
+	{ "CVP", APR_SVC_ADSP_CVP, APR_CLIENT_AUDIO, },
+	{ "USM", APR_SVC_USM, APR_CLIENT_AUDIO, },
+	{ "VIDC", APR_SVC_VIDC, },
+	{ "LSM", APR_SVC_LSM, APR_CLIENT_AUDIO, },
+};
+
+int apr_send_pkt(void *handle, uint32_t *buf)
+{
+	struct apr_svc *svc = handle;
+	struct apr *apr = dev_get_drvdata(svc->dev->parent);
+	struct apr_hdr *hdr;
+	unsigned long flags;
+	int ret;
+
+	if (!handle || !buf) {
+		dev_err(svc->dev, "APR: Wrong parameters\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&svc->w_lock, flags);
+
+	hdr = (struct apr_hdr *)buf;
+	hdr->src_domain = APR_DOMAIN_APPS;
+	hdr->src_svc = svc->id;
+	hdr->dest_domain = svc->dest_domain;
+	hdr->dest_svc = svc->id;
+
+	ret = rpmsg_send(apr->ch, buf, hdr->pkt_size);
+	if (ret) {
+		dev_err(svc->dev, "Unable to send APR pkt %d\n",
+			hdr->pkt_size);
+	} else {
+		ret = hdr->pkt_size;
+	}
+
+	spin_unlock_irqrestore(&svc->w_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(apr_send_pkt);
+
+static int apr_find_svc(const char *svc_name, int domain_id, int *client_id,
+			int *svc_id)
+{
+	struct apr_svc_table *tbl = (struct apr_svc_table *)&svc_tbl_qdsp6;
+	int i, size = ARRAY_SIZE(svc_tbl_qdsp6);
+
+	for (i = 0; i < size; i++) {
+		if (!strcmp(svc_name, tbl[i].name)) {
+			*client_id = tbl[i].client_id;
+			*svc_id = tbl[i].id;
+			return 0;
+		}
+	}
+
+	pr_err("%s: APR: Wrong svc name %s\n", __func__, svc_name);
+	return -EINVAL;
+}
+
+struct apr_svc *apr_register(struct device *dev, char *dest, char *svc_name,
+			     apr_fn svc_fn, uint32_t src_port, void *priv)
+{
+	int client_id = 0;
+	int svc_id = 0;
+	int domain_id = 0;
+	int temp_port = 0;
+	struct apr_svc *p, *svc = NULL;
+	struct apr *apr = dev_get_drvdata(dev->parent);
+
+	if (!apr || !dest || !svc_name || !svc_fn)
+		return NULL;
+
+	if (!strcmp(dest, "ADSP")) {
+		domain_id = APR_DOMAIN_ADSP;
+	} else {
+		dev_err(dev, "APR: wrong destination\n");
+		goto done;
+	}
+
+	if (apr_find_svc(svc_name, domain_id, &client_id, &svc_id)) {
+		dev_err(dev, "%s: apr_find_svc failed\n", __func__);
+		goto done;
+	}
+
+	list_for_each_entry(p, &apr->svcs, node) {
+		if (svc_id == p->id) {
+			svc = p;
+			break;
+		}
+	}
+
+	if (!svc) {
+		svc = kzalloc(sizeof(*svc), GFP_KERNEL);
+		if (!svc)
+			return NULL;
+
+		mutex_init(&svc->m_lock);
+		spin_lock_init(&svc->w_lock);
+	}
+
+	mutex_lock(&svc->m_lock);
+
+	svc->priv = priv;
+	svc->id = svc_id;
+	svc->dest_id = apr->dest_id;
+	svc->client_id = client_id;
+	svc->dest_domain = domain_id;
+	svc->dev = dev;
+	if (src_port != 0xFFFFFFFF) {
+		temp_port = ((src_port >> 8) * 8) + (src_port & 0xFF);
+		if (temp_port >= APR_MAX_PORTS || temp_port < 0) {
+			mutex_unlock(&svc->m_lock);
+			return NULL;
+		}
+		if (!svc->port_cnt && !svc->svc_cnt)
+			apr->svc_cnt++;
+		svc->port_cnt++;
+		svc->port_fn[temp_port] = svc_fn;
+		svc->port_priv[temp_port] = priv;
+	} else {
+		if (!svc->fn) {
+			if (!svc->port_cnt && !svc->svc_cnt)
+				apr->svc_cnt++;
+			svc->fn = svc_fn;
+			if (svc->port_cnt)
+				svc->svc_cnt++;
+		}
+	}
+
+	mutex_unlock(&svc->m_lock);
+	mutex_lock(&apr->svcs_lock);
+	list_add_tail(&svc->node, &apr->svcs);
+	mutex_unlock(&apr->svcs_lock);
+done:
+	return svc;
+}
+EXPORT_SYMBOL_GPL(apr_register);
+
+static int qcom_rpmsg_q6_callback(struct rpmsg_device *rpdev, void *buf,
+				  int len, void *priv, u32 addr)
+{
+	struct apr *apr = dev_get_drvdata(&rpdev->dev);
+	struct apr_client_data data;
+	struct apr_svc *p, *c_svc = NULL;
+	struct apr_hdr *hdr;
+	uint16_t hdr_size;
+	uint16_t msg_type;
+	uint16_t ver;
+	uint16_t src;
+	uint16_t svc;
+	int temp_port = 0;
+
+	if (!buf || len <= APR_HDR_SIZE) {
+		pr_info("APR: Improper apr pkt received:%p %d\n", buf, len);
+		return -EINVAL;
+	}
+
+	hdr = buf;
+	ver = (hdr->hdr_field) & 0x000F;
+	if (ver > APR_PKT_VER + 1) {
+		pr_info("APR: Wrong version: %d\n", ver);
+		return -EINVAL;
+	}
+
+	hdr_size = hdr->hdr_field;
+	hdr_size = ((hdr_size & 0x00F0) >> 0x4) * 4;
+	if (hdr_size < APR_HDR_SIZE) {
+		dev_err(apr->dev, "APR: Wrong hdr size:%d\n", hdr_size);
+		return -EINVAL;
+	}
+
+	if (hdr->pkt_size < APR_HDR_SIZE) {
+		dev_err(apr->dev, "APR: Wrong paket size\n");
+		return -EINVAL;
+	}
+	msg_type = hdr->hdr_field;
+	msg_type = (msg_type >> 0x08) & 0x0003;
+	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
+		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
+		return -EINVAL;
+	}
+
+	if (hdr->src_domain >= APR_DOMAIN_MAX ||
+	hdr->dest_domain >= APR_DOMAIN_MAX ||
+	hdr->src_svc >= APR_SVC_MAX || hdr->dest_svc >= APR_SVC_MAX) {
+		dev_err(apr->dev, "APR: Wrong APR header\n");
+		return -EINVAL;
+	}
+
+	svc = hdr->dest_svc;
+	src = apr->ops->get_data_src(hdr);
+	if (src == APR_DEST_MAX)
+		return -EINVAL;
+
+	list_for_each_entry(p, &apr->svcs, node) {
+		if (svc == p->id) {
+			c_svc = p;
+			break;
+		}
+	}
+
+	if (!c_svc) {
+		dev_err(apr->dev, "APR: service is not registered\n");
+		return -EINVAL;
+	}
+
+	data.payload_size = hdr->pkt_size - hdr_size;
+	data.opcode = hdr->opcode;
+	data.src = src;
+	data.src_port = hdr->src_port;
+	data.dest_port = hdr->dest_port;
+	data.token = hdr->token;
+	data.msg_type = msg_type;
+
+	if (data.payload_size > 0)
+		data.payload = (char *)hdr + hdr_size;
+
+	temp_port = ((data.dest_port >> 8) * 8) + (data.dest_port & 0xFF);
+	if (c_svc->port_cnt && c_svc->port_fn[temp_port])
+		c_svc->port_fn[temp_port] (&data, c_svc->port_priv[temp_port]);
+	else if (c_svc->fn)
+		c_svc->fn(&data, c_svc->priv);
+	else
+		dev_err(apr->dev, "APR: Rxed a packet for NULL callback\n");
+
+	return 0;
+}
+
+int apr_deregister(void *handle)
+{
+	struct apr_svc *svc = handle;
+	struct apr *apr = dev_get_drvdata(svc->dev->parent);
+	uint16_t client_id;
+
+	if (!handle)
+		return -EINVAL;
+
+	mutex_lock(&svc->m_lock);
+	client_id = svc->client_id;
+
+	if (svc->port_cnt > 0 || svc->svc_cnt > 0) {
+		if (svc->port_cnt)
+			svc->port_cnt--;
+		else if (svc->svc_cnt)
+			svc->svc_cnt--;
+		if (!svc->port_cnt && !svc->svc_cnt)
+			apr->svc_cnt--;
+	} else if (apr->svc_cnt > 0) {
+		apr->svc_cnt--;
+	}
+
+	if (!svc->port_cnt && !svc->svc_cnt) {
+		mutex_unlock(&svc->m_lock);
+
+		mutex_lock(&apr->svcs_lock);
+		list_del(&svc->node);
+		mutex_unlock(&apr->svcs_lock);
+		kfree(svc);
+		return 0;
+	}
+
+	mutex_unlock(&svc->m_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apr_deregister);
+
+static int qcom_rpmsg_q6_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	const char *name;
+	struct apr *apr;
+	int ret;
+
+	apr = devm_kzalloc(dev, sizeof(*apr), GFP_KERNEL);
+	if (!apr)
+		return -ENOMEM;
+
+	apr->ops = of_device_get_match_data(dev);
+	if (!apr->ops)
+		return -ENODEV;
+
+	ret = of_property_read_string(dev->of_node, "qcom,smd-channels", &name);
+	if (ret) {
+		dev_err(dev, "qcom,smd-channels name not found\n");
+		return -EINVAL;
+	}
+
+	if (!strcmp(name, "apr_audio_svc")) {
+		apr->client_id = APR_CLIENT_AUDIO;
+	} else {
+		dev_err(dev, "Unsupported srv name\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(dev->parent->of_node, "qcom,smd-edge",
+				   &apr->dest_id);
+	if (ret) {
+		dev_err(dev, "qcom,smd-edge not found\n");
+		return -EINVAL;
+	}
+
+	dev_set_drvdata(dev, apr);
+	apr->ch = rpdev->ept;
+	apr->dev = dev;
+	INIT_LIST_HEAD(&apr->svcs);
+
+	dev_info(dev, "APR service up for apr id %d  dest id %d\n",
+		apr->client_id, apr->dest_id);
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static void qcom_rpmsg_q6_remove(struct rpmsg_device *rpdev)
+{
+	of_platform_depopulate(&rpdev->dev);
+}
+
+static int apr_v2_get_data_src(struct apr_hdr *hdr)
+{
+	if (hdr->src_domain == APR_DOMAIN_MODEM)
+		return APR_DEST_MODEM;
+	else if (hdr->src_domain == APR_DOMAIN_ADSP)
+		return APR_DEST_QDSP6;
+
+	pr_err("APR: Pkt from wrong source: %d\n", hdr->src_domain);
+
+	return APR_DEST_MAX;
+}
+
+static const struct apr_ops apr_v2_ops = {
+	.get_data_src = apr_v2_get_data_src,
+};
+
+static const struct of_device_id qcom_rpmsg_q6_of_match[] = {
+	{ .compatible = "qcom,apr-msm8996", .data = &apr_v2_ops},
+	{}
+};
+
+static struct rpmsg_driver qcom_rpmsg_q6_driver = {
+	.probe = qcom_rpmsg_q6_probe,
+	.remove = qcom_rpmsg_q6_remove,
+	.callback = qcom_rpmsg_q6_callback,
+	.drv = {
+		.name = "qcom_rpmsg_q6",
+		.owner = THIS_MODULE,
+		.of_match_table = qcom_rpmsg_q6_of_match,
+		},
+};
+
+module_rpmsg_driver(qcom_rpmsg_q6_driver);
+
+MODULE_DESCRIPTION("Qualcomm rpmsg backed apr driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
new file mode 100644
index 0000000..02175e6
--- /dev/null
+++ b/include/linux/soc/qcom/apr.h
@@ -0,0 +1,163 @@
+/* Copyright (c) 2010-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __APR_H_
+#define __APR_H_
+
+#include <linux/mutex.h>
+
+/* APR Client IDs */
+#define APR_CLIENT_AUDIO	0x0
+#define APR_CLIENT_VOICE	0x1
+#define APR_CLIENT_MAX		0x2
+
+#define APR_DL_SMD    0
+#define APR_DL_MAX    1
+
+#define APR_DEST_MODEM 0
+#define APR_DEST_QDSP6 1
+#define APR_DEST_MAX   2
+#define APR_MAX_BUF   8192
+
+#define APR_HDR_LEN(hdr_len) ((hdr_len)/4)
+#define APR_PKT_SIZE(hdr_len, payload_len) ((hdr_len) + (payload_len))
+#define APR_HDR_FIELD(msg_type, hdr_len, ver)\
+	(((msg_type & 0x3) << 8) | ((hdr_len & 0xF) << 4) | (ver & 0xF))
+
+#define APR_HDR_SIZE sizeof(struct apr_hdr)
+#define APR_SEQ_CMD_HDR_FIELD APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD, \
+					    APR_HDR_LEN(APR_HDR_SIZE), \
+					    APR_PKT_VER)
+
+/* Version */
+#define APR_PKT_VER		0x0
+
+/* Command and Response Types */
+#define APR_MSG_TYPE_EVENT	0x0
+#define APR_MSG_TYPE_CMD_RSP	0x1
+#define APR_MSG_TYPE_SEQ_CMD	0x2
+#define APR_MSG_TYPE_NSEQ_CMD	0x3
+#define APR_MSG_TYPE_MAX	0x04
+
+/* APR Basic Response Message */
+#define APR_BASIC_RSP_RESULT 0x000110E8
+#define APR_RSP_ACCEPTED     0x000100BE
+
+/* Domain IDs */
+#define APR_DOMAIN_SIM	0x1
+#define APR_DOMAIN_PC		0x2
+#define APR_DOMAIN_MODEM	0x3
+#define APR_DOMAIN_ADSP	0x4
+#define APR_DOMAIN_APPS	0x5
+#define APR_DOMAIN_MAX	0x6
+
+/* ADSP service IDs */
+#define APR_SVC_TEST_CLIENT     0x2
+#define APR_SVC_ADSP_CORE	0x3
+#define APR_SVC_AFE		0x4
+#define APR_SVC_VSM		0x5
+#define APR_SVC_VPM		0x6
+#define APR_SVC_ASM		0x7
+#define APR_SVC_ADM		0x8
+#define APR_SVC_ADSP_MVM	0x09
+#define APR_SVC_ADSP_CVS	0x0A
+#define APR_SVC_ADSP_CVP	0x0B
+#define APR_SVC_USM		0x0C
+#define APR_SVC_LSM		0x0D
+#define APR_SVC_VIDC		0x16
+#define APR_SVC_MAX		0x17
+
+/* Modem Service IDs */
+#define APR_SVC_MVS		0x3
+#define APR_SVC_MVM		0x4
+#define APR_SVC_CVS		0x5
+#define APR_SVC_CVP		0x6
+#define APR_SVC_SRD		0x7
+
+/* APR Port IDs */
+#define APR_MAX_PORTS		0x80
+#define APR_NAME_MAX		0x40
+#define RESET_EVENTS		0x000130D7
+
+struct apr_hdr {
+	uint16_t hdr_field;
+	uint16_t pkt_size;
+	uint8_t src_svc;
+	uint8_t src_domain;
+	uint16_t src_port;
+	uint8_t dest_svc;
+	uint8_t dest_domain;
+	uint16_t dest_port;
+	uint32_t token;
+	uint32_t opcode;
+};
+
+struct apr_client_data {
+	uint16_t payload_size;
+	uint16_t hdr_len;
+	uint16_t msg_type;
+	uint16_t src;
+	uint16_t dest_svc;
+	uint16_t src_port;
+	uint16_t dest_port;
+	uint32_t token;
+	uint32_t opcode;
+	void *payload;
+};
+
+typedef int32_t (*apr_fn) (struct apr_client_data *data, void *priv);
+struct apr_svc {
+	uint16_t id;
+	uint16_t dest_id;
+	uint16_t client_id;
+	uint16_t dest_domain;
+	uint8_t rvd;
+	uint8_t port_cnt;
+	uint8_t svc_cnt;
+
+	apr_fn port_fn[APR_MAX_PORTS];
+	void *port_priv[APR_MAX_PORTS];
+	apr_fn fn;
+	void *priv;
+	struct mutex m_lock;
+	spinlock_t w_lock;
+	struct device *dev;
+	struct list_head node;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_APR)
+struct apr_svc *apr_register(struct device *dev, char *dest, char *svc_name,
+			     apr_fn svc_fn, uint32_t src_port, void *priv);
+int apr_send_pkt(void *handle, uint32_t *buf);
+int apr_deregister(void *handle);
+
+#else
+
+static inline struct apr_svc *apr_register(struct device *dev, char *dest,
+					   char *svc_name, apr_fn svc_fn,
+					   uint32_t src_port, void *priv)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline int apr_send_pkt(void *handle, uint32_t *buf)
+{
+	return -ENOSYS;
+}
+
+static inline int apr_deregister(void *handle)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_QCOM_APR */
+#endif /* __APR_H_ */
-- 
2.9.3
