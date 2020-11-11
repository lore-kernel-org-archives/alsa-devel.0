Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E7C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 18:38:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E79205CB
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 18:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l/o7+iJL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YESGiiWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E79205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDBE4850;
	Wed, 11 Nov 2020 19:37:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDBE4850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605119922;
	bh=dDzY3+7+fZGc36nzf9usRwda312sROQEvN4Bgqaq5Jk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l/o7+iJLXN3SoM2MrqxTZJf5uSxtCqGjNA2ESPKHWeTBfZ4YpMWI32GkWBvHlx1DA
	 KAGGcXWn6OJ+U5a2ooAloaDmr7/3oOR03oiCwvhk6PQSuI2Oc3yuOUnZpLgbRcqWuq
	 JORaUCjX7T//el94R8QYx3f9ULjLPRtSjoDddvBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C5D0F804EB;
	Wed, 11 Nov 2020 19:35:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD0D5F804E5; Wed, 11 Nov 2020 19:35:33 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B9B4F804E1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 19:35:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B9B4F804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="YESGiiWm"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fac2ee70000>; Wed, 11 Nov 2020 10:35:19 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 18:35:24 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 18:35:21 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
Subject: [PATCH v5 6/6] arm64: tegra: Audio graph sound card for Jetson Nano
 and TX1
Date: Thu, 12 Nov 2020 00:04:36 +0530
Message-ID: <1605119676-32273-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
References: <1605119676-32273-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605119719; bh=zgnKJF1VjTOw8+8MA5BXzpvmueNYvLnvIUw8iNhEnkY=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=YESGiiWmhkwGbgPKqJ68byGgZSu460J/PGmmg5TF0MqSbln3y6MV7lYZvQBtvbGrv
 t1E0IQFr6x9F0vellPjssIxtXNveIE8/QsbyiLPv4AwX/8dMTZT1qeKiPyrRjKcO+e
 D4OxMQ2VWH8URyQYE4tdq2e7YD2bwFhFOnNJEaE5mr4Ui4+45HbZS/FVxPEnt/8Z4d
 Gyci0mHZKCo1f4/AaGTDHmNtAE299+q6q/yB2MAsNIrF44OlLI0Jt3ZSAj2FUHm+nW
 CLrN8vHWApgrVc7Bbrs+L7dPhwtZBoNMN/7CquSz3cBBkmSJEU5k+kcUjojNrXQbB/
 okOcNB4lf5ovg==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Enable support for audio-graph based sound card on Jetson-Nano and
Jetson-TX1. Depending on the platform, required I/O interfaces are
enabled.

 * Jetson-Nano: Enable I2S3, I2S4, DMIC1 and DMIC2.
 * Jetson-TX1: Enable all I2S and DMIC interfaces.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 262 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 146 ++++++++++++
 2 files changed, 408 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 69102dc..747ab93 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -3,6 +3,7 @@
 
 #include "tegra210-p2180.dtsi"
 #include "tegra210-p2597.dtsi"
+#include "tegra210-audio-graph.dtsi"
 
 / {
 	model = "NVIDIA Jetson TX1 Developer Kit";
@@ -127,4 +128,265 @@
 			status = "okay";
 		};
 	};
+
+	tegra_sound {
+		status = "okay";
+
+		compatible = "nvidia,tegra210-audio-graph-card";
+
+		dais = /* FE */
+		       <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>,
+		       <&admaif7_port>, <&admaif8_port>, <&admaif9_port>,
+		       <&admaif10_port>,
+		       /* Router */
+		       <&xbar_i2s1_port>, <&xbar_i2s2_port>, <&xbar_i2s3_port>,
+		       <&xbar_i2s4_port>, <&xbar_i2s5_port>, <&xbar_dmic1_port>,
+		       <&xbar_dmic2_port>, <&xbar_dmic3_port>,
+		       /* I/O DAP Ports */
+		       <&i2s1_port>, <&i2s2_port>, <&i2s3_port>, <&i2s4_port>,
+		       <&i2s5_port>, <&dmic1_port>, <&dmic2_port>, <&dmic3_port>;
+
+		label = "jetson-tx1-ape";
+	};
+};
+
+&tegra_admaif {
+	status = "okay";
+};
+
+&tegra_ahub {
+	status = "okay";
+
+	ports {
+		xbar_i2s1_port: port@a {
+			reg = <0xa>;
+			xbar_i2s1_ep: endpoint {
+				remote-endpoint = <&i2s1_cif_ep>;
+			};
+		};
+		xbar_i2s2_port: port@b {
+			reg = <0xb>;
+			xbar_i2s2_ep: endpoint {
+				remote-endpoint = <&i2s2_cif_ep>;
+			};
+		};
+		xbar_i2s3_port: port@c {
+			reg = <0xc>;
+			xbar_i2s3_ep: endpoint {
+				remote-endpoint = <&i2s3_cif_ep>;
+			};
+		};
+		xbar_i2s4_port: port@d {
+			reg = <0xd>;
+			xbar_i2s4_ep: endpoint {
+				remote-endpoint = <&i2s4_cif_ep>;
+			};
+		};
+		xbar_i2s5_port: port@e {
+			reg = <0xe>;
+			xbar_i2s5_ep: endpoint {
+				remote-endpoint = <&i2s5_cif_ep>;
+			};
+		};
+		xbar_dmic1_port: port@f {
+			reg = <0xf>;
+			xbar_dmic1_ep: endpoint {
+				remote-endpoint = <&dmic1_cif_ep>;
+			};
+		};
+		xbar_dmic2_port: port@10 {
+			reg = <0x10>;
+			xbar_dmic2_ep: endpoint {
+				remote-endpoint = <&dmic2_cif_ep>;
+			};
+		};
+		xbar_dmic3_port: port@11 {
+			reg = <0x11>;
+			xbar_dmic3_ep: endpoint {
+				remote-endpoint = <&dmic3_cif_ep>;
+			};
+		};
+	};
+};
+
+&tegra_i2s1 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s1_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s1_ep>;
+			};
+		};
+		i2s1_port: port@1 {
+			reg = <1>;
+			i2s1_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_i2s2 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s2_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s2_ep>;
+			};
+		};
+		i2s2_port: port@1 {
+			reg = <1>;
+			i2s2_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_i2s3 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s3_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s3_ep>;
+			};
+		};
+		i2s3_port: port@1 {
+			reg = <1>;
+			i2s3_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_i2s4 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s4_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s4_ep>;
+			};
+		};
+		i2s4_port: port@1 {
+			reg = <1>;
+			i2s4_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_i2s5 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s5_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s5_ep>;
+			};
+		};
+		i2s5_port: port@1 {
+			reg = <1>;
+			i2s5_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_dmic1 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dmic1_cif_ep: endpoint {
+				remote-endpoint = <&xbar_dmic1_ep>;
+			};
+		};
+		dmic1_port: port@1 {
+			reg = <1>;
+			dmic1_dap_ep: endpoint {
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_dmic2 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dmic2_cif_ep: endpoint {
+				remote-endpoint = <&xbar_dmic2_ep>;
+			};
+		};
+		dmic2_port: port@1 {
+			reg = <1>;
+			dmic2_dap_ep: endpoint {
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_dmic3 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dmic3_cif_ep: endpoint {
+				remote-endpoint = <&xbar_dmic3_ep>;
+			};
+		};
+		dmic3_port: port@1 {
+			reg = <1>;
+			dmic3_dap_ep: endpoint {
+				/* Placeholder for external Codec */
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 6a877de..0c917a1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/mfd/max77620.h>
 
 #include "tegra210.dtsi"
+#include "tegra210-audio-graph.dtsi"
 
 / {
 	model = "NVIDIA Jetson Nano Developer Kit";
@@ -870,4 +871,149 @@
 
 		vin-supply = <&vdd_5v0_sys>;
 	};
+
+	tegra_sound {
+		status = "okay";
+
+		compatible = "nvidia,tegra210-audio-graph-card";
+
+		dais = /* FE */
+		       <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>,
+		       <&admaif7_port>, <&admaif8_port>, <&admaif9_port>,
+		       <&admaif10_port>,
+		       /* Router */
+		       <&xbar_i2s3_port>, <&xbar_i2s4_port>,
+		       <&xbar_dmic1_port>, <&xbar_dmic2_port>,
+		       /* I/O DAP Ports */
+		       <&i2s3_port>, <&i2s4_port>,
+		       <&dmic1_port>, <&dmic2_port>;
+
+		label = "jetson-nano-ape";
+	};
+};
+
+&tegra_admaif {
+	status = "okay";
+};
+
+&tegra_ahub {
+	status = "okay";
+
+	ports {
+		xbar_i2s3_port: port@c {
+			reg = <0xc>;
+			xbar_i2s3_ep: endpoint {
+				remote-endpoint = <&i2s3_cif_ep>;
+			};
+		};
+		xbar_i2s4_port: port@d {
+			reg = <0xd>;
+			xbar_i2s4_ep: endpoint {
+				remote-endpoint = <&i2s4_cif_ep>;
+			};
+		};
+		xbar_dmic1_port: port@f {
+			reg = <0xf>;
+			xbar_dmic1_ep: endpoint {
+				remote-endpoint = <&dmic1_cif_ep>;
+			};
+		};
+		xbar_dmic2_port: port@10 {
+			reg = <0x10>;
+			xbar_dmic2_ep: endpoint {
+				remote-endpoint = <&dmic2_cif_ep>;
+			};
+		};
+	};
+};
+
+&tegra_i2s3 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s3_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s3_ep>;
+			};
+		};
+		i2s3_port: port@1 {
+			reg = <1>;
+			i2s3_dap_ep: endpoint {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_i2s4 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			i2s4_cif_ep: endpoint {
+				remote-endpoint = <&xbar_i2s4_ep>;
+			};
+		};
+		i2s4_port: port@1 {
+			reg = <1>;
+			i2s4_dap_ep: endpoint@0 {
+				dai-format = "i2s";
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_dmic1 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dmic1_cif_ep: endpoint@0 {
+				remote-endpoint = <&xbar_dmic1_ep>;
+			};
+		};
+		dmic1_port: port@1 {
+			reg = <1>;
+			dmic1_dap_ep: endpoint@0 {
+				/* Placeholder for external Codec */
+			};
+		};
+	};
+};
+
+&tegra_dmic2 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dmic2_cif_ep: endpoint@0 {
+				remote-endpoint = <&xbar_dmic2_ep>;
+			};
+		};
+		dmic2_port: port@1 {
+			reg = <1>;
+			dmic2_dap_ep: endpoint@0 {
+				/* Placeholder for external Codec */
+			};
+		};
+	};
 };
-- 
2.7.4

