Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31757C3DA4A
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:34:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A9053E8;
	Tue, 20 Aug 2024 13:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A9053E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724153652;
	bh=pqXRzZbXp3ohVKvscuk3VydgdgbRtcYSht2vlfwDIkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fK0tW4lZR2wRGk1QOWyuIhG14zyWIw06WYeU7ADCzp8QFjAFpL5BslreWv+16y+dY
	 tK1+xGqA9T+Wj9OUsjSBFZKHmcI13YdQP4GJLm6k+IC5J+B1dEoKQyiegSXv7AFMAH
	 LyYclYgy8rdjo/WhbUpbpgIJD5WBsv/3p5CU8H00=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A6A4F805BB; Tue, 20 Aug 2024 13:33:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A26A3F805B5;
	Tue, 20 Aug 2024 13:33:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60C9BF8049C; Tue, 20 Aug 2024 13:33:26 +0200 (CEST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78997F8014C
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2024 13:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78997F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com
 header.a=rsa-sha256 header.s=DFC430D2-D198-11EC-948E-34200CB392D2
 header.b=IgW6Spdz
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6A7599C5F35;
	Tue, 20 Aug 2024 07:28:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id oggzsanuln4N; Tue, 20 Aug 2024 07:28:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CB9B19C5DDB;
	Tue, 20 Aug 2024 07:28:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CB9B19C5DDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724153334; bh=+315METsLqMXPK6zrYbhgCdutPDOUB5ivpLkv3mll1s=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IgW6SpdzuAVp5ptOPNI12zaXpQH5hDli76IYrcf0LshRiDEWWCksj9SlSccn5y1RL
	 xvovYTPRX2USGYij0cIcsE10j3fLYSXYZl7w2UBlj7a878+CzU0FwxCETyC9ojiYXF
	 fkfONOgHM+BzG1bk8H8Id9n1fp9zHwNBwcb5eYsXyfKjlErKUPsjD5Pmg+e+V8gkPp
	 uzYraR2HzOhdySXbHw4FLRgnEQerXMR6LJYVSZNGTbd8Skx++1DaJiN0zbvGpg/FjB
	 ghciDMSzd7OqhysPGIgmpZN6O8Hyk3QSQa6o7rMca6Mns04NTGEhspzOHvxx41oENR
	 HDLyLVmQJp5SA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JpKrB2TZJkUh; Tue, 20 Aug 2024 07:28:54 -0400 (EDT)
Received: from gerard.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net
 [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D70599C5E78;
	Tue, 20 Aug 2024 07:28:52 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Subject: [PATCH v7 1/2] arm64: dts: imx8m: update spdif sound card node
 properties
Date: Tue, 20 Aug 2024 13:28:26 +0200
Message-Id: <20240820112827.126380-2-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820112827.126380-1-elinor.montmasson@savoirfairelinux.com>
References: <20240820112827.126380-1-elinor.montmasson@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: BCD7VFUN42KNMMT3FXL5SGJVXYNEZTBV
X-Message-ID-Hash: BCD7VFUN42KNMMT3FXL5SGJVXYNEZTBV
X-MailFrom: elinor.montmasson@savoirfairelinux.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BCD7VFUN42KNMMT3FXL5SGJVXYNEZTBV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The merge of imx-spdif driver into fsl-asoc-card brought
new DT properties that can be used with the "fsl,imx-audio-spdif"
compatible:
* The "spdif-controller" property from imx-spdif is named "audio-cpu"
  in fsl-asoc-card.
* fsl-asoc-card uses codecs explicitly declared in DT
  with "audio-codec".
  With an S/PDIF, codec drivers spdif_transmitter and
  spdif_receiver should be used.
  Driver imx-spdif used instead the dummy codec and a pair of
  boolean properties, "spdif-in" and "spdif-out".

While backward compatibility is kept to support properties
"spdif-controller", "spdif-in" and "spdif-out", using new properties has
several benefits:
* "audio-cpu" and "audio-codec" are more generic names reflecting
  that the fsl-asoc-card driver supports multiple hardware.
  They are properties already used by devices using the
  fsl-asoc-card driver.
  They are also similar to properties of simple-card: "cpu" and "codec".
* "spdif-in" and "spdif-out" imply the use of the dummy codec in the
  driver. However, there are already two codec drivers for the S/PDIF,
  spdif_transmitter and spdif_receiver.
  It is better to declare S/PDIF Tx and Rx devices in a DT, and then
  reference them with "audio-codec" than using the dummy codec.

For those reasons, this commit updates in-tree DTs to use the new
properties:
* Rename "spdif-controller" property to "audio-cpu".
* Declare S/PDIF transmitter and/or receiver devices, and use them with
  the "audio-codec" property instead of "spdif-out" and/or "spdif-in".

These modifications were tested only on an imx8mn-evk board.

Note that out-of-tree and old DTs are still supported.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++----
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mm-evk.dtsi
index 930e14fec423..5f8336217bb8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -180,12 +180,21 @@ cpu {
 		};
 	};
=20
+	spdif_out: spdif-out {
+		compatible =3D "linux,spdif-dit";
+		#sound-dai-cells =3D <0>;
+	};
+
+	spdif_in: spdif-in {
+		compatible =3D "linux,spdif-dir";
+		#sound-dai-cells =3D <0>;
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
 	};
 };
=20
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mn-evk.dtsi
index 9e0259ddf4bc..33d73f3dc187 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -124,12 +124,21 @@ sound-wm8524 {
 			"Line Out Jack", "LINEVOUTR";
 	};
=20
+	spdif_out: spdif-out {
+		compatible =3D "linux,spdif-dit";
+		#sound-dai-cells =3D <0>;
+	};
+
+	spdif_in: spdif-in {
+		compatible =3D "linux,spdif-dir";
+		#sound-dai-cells =3D <0>;
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
 	};
=20
 	sound-micfil {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 7507548cdb16..a87d0692c3bb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -125,19 +125,33 @@ link_codec: simple-audio-card,codec {
 		};
 	};
=20
+	spdif_out: spdif-out {
+		compatible =3D "linux,spdif-dit";
+		#sound-dai-cells =3D <0>;
+	};
+
+	spdif_in: spdif-in {
+		compatible =3D "linux,spdif-dir";
+		#sound-dai-cells =3D <0>;
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
+	};
+
+	hdmi_arc_in: hdmi-arc-in {
+		compatible =3D "linux,spdif-dir";
+		#sound-dai-cells =3D <0>;
 	};
=20
 	sound-hdmi-arc {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-hdmi-arc";
-		spdif-controller =3D <&spdif2>;
-		spdif-in;
+		audio-cpu =3D <&spdif2>;
+		audio-codec =3D <&hdmi_arc_in>;
 	};
 };
=20
--=20
2.34.1

