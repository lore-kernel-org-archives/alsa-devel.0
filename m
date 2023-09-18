Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF4C46CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 13:18:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0292BBC0;
	Mon, 18 Sep 2023 15:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0292BBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695043084;
	bh=lFI2eSXDI/MauwP+d3JoGjHLWZPx6y0eM7DV/cuMMcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=k8OkgoClR3fpYrEuH+fHqMQ8dIuI+FrVTkVwDhR25ysO4+IAitk8uTNXKklgKXHB4
	 6k9qpdbmflej3KR23qGHhnln6U7CcRyDoCsSC6C8SUW22r6FgPsCxlwWdMWF9z9ozh
	 i8/STNrOzeH5cqYZWbG7oWW07i3soxH6gdkVrvzc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 093DAF805A8; Mon, 18 Sep 2023 15:16:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC8C0F80587;
	Mon, 18 Sep 2023 15:16:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2210EF80587; Mon, 18 Sep 2023 15:16:12 +0200 (CEST)
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com
 [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BA38F80571
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 15:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BA38F80571
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=jookia.org header.i=@jookia.org header.a=rsa-sha256
 header.s=key1 header.b=TfnB1Khl
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1695042967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4JO3nPtbJqM3dkylLDmImTDJGUU/OSMwJOj0UlM/Ak=;
	b=TfnB1KhlXidh22YPceMlN18+XrH4ujdCm5j8lJg6uxN9ms0aAHROG1HXUcT4YkltlOJYLO
	2w/YjChRnnByz+GDdIo2GwmjAWlDJQ9o/B9oH4KB4OfdZmieUCqQmQ1HEbS5cPDi7LtbCJ
	HBuCUmHtOmgGynv7u0KrBIZa0MiGkRbf17IqPjTyywqjqk2q7nE5Gwsb2av5HPRDzgCGWW
	3MBUHEsF441/67YtaMlH+THdpg/Fl/c6W5oWMLtmrokAbdoKqH/8rEDl6aoHn3ObzKrVRU
	KME44FGXd8fiFy9DDfRf4mF4sFeU0OTXzGEz3Eqz4FLX99d2CViK9O2/bAW7zg==
From: John Watts <contact@jookia.org>
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	John Watts <contact@jookia.org>,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Date: Mon, 18 Sep 2023 23:15:32 +1000
Message-ID: <20230918131532.2257615-4-contact@jookia.org>
In-Reply-To: <20230918131532.2257615-1-contact@jookia.org>
References: <20230918131532.2257615-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: RRZLW6BLPB42CQAUVKPI65I6T3ADHUR2
X-Message-ID-Hash: RRZLW6BLPB42CQAUVKPI65I6T3ADHUR2
X-MailFrom: contact@jookia.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RRZLW6BLPB42CQAUVKPI65I6T3ADHUR2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The WM8782 can safely support rates higher than 48kHz by changing the
value of the FSAMPEN pin.

Allow specifying the FSAMPEN pin value in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/wm8782.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
index 256cdec6ec4d..1a28f3280972 100644
--- a/Documentation/devicetree/bindings/sound/wm8782.txt
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -8,10 +8,17 @@ Required properties:
  - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
  - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
 
+Optional properties:
+
+ - wlf,fsampen:
+   FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected.
+   Defaults to 0 if left unspecified.
+
 Example:
 
 wm8782: stereo-adc {
 	compatible = "wlf,wm8782";
 	Vdda-supply = <&vdda_supply>;
 	Vdd-supply = <&vdd_supply>;
+	wlf,fsampen = <2>; /* 192KHz */
 };
-- 
2.42.0

