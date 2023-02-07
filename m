Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1FBC636CC
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Feb 2023 23:34:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EECAAF3;
	Wed,  8 Feb 2023 00:33:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EECAAF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675812850;
	bh=npqt0IMTyKKxWj2IKLUrG7ISyOoM5z/+NANPBGIZ2jg=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BzJOFiUt5YCJvMZKANlJC64XCP+nOl12Jq+urwt+ayeSLy4uIpkhi0t2zHLsMYM7w
	 wnCYLVtsZb13CXay8CWPXyJVjRN++o+Rlp9qsAWC4tywkSnO0n09NmaA7FqXHaGgRT
	 2I4/WaspjLRJo2OLfocKA+GcKJatA2nSLAP95Bmo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFA28F80552;
	Wed,  8 Feb 2023 00:31:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7D56F80527; Wed,  8 Feb 2023 00:31:40 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9F82F8012B
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2023 00:31:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9F82F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=H21yTG4e
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id C913666020C4;
	Tue,  7 Feb 2023 16:25:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1675787139;
	bh=npqt0IMTyKKxWj2IKLUrG7ISyOoM5z/+NANPBGIZ2jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H21yTG4elW4u0ZyA7SwQw9QsMj3uBHskO0cyzPEEcU+/6Aijaf/FJD1r8oRqKCxAC
	 8mdajuWMvalXapr3+i5KAJmZ5DrBFZwkf9VAPTZfoCvG+7BHXRXqPO5p3GzDzoJa9H
	 6zO4C3hK7QlAn66jFCVrEKSlFmqP3HvUzlvc6eEbfkLTlpLW21T+rHxff+RCSUX3PP
	 MQBiLKFZntNir3QoUITDVKY1/gz/NgwT9WjMsrMte25kFwOMAM1r5MEH1aWOpIZtLz
	 osLvlxqYWBZ9USZ6vvKkMeDsk8sDlxjP30VB3Eprz1fjDiDyUFxvuZ+ZV5vYQCYSfO
	 2Q30PUBU7czGA==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 4/5] ASoC: cs35l41: Document CS35l41 external boost without
 VSPK
Date: Tue,  7 Feb 2023 16:25:25 +0000
Message-Id: <20230207162526.1024286-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207162526.1024286-1-lucas.tanure@collabora.com>
References: <20230207162526.1024286-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KDFCH5DAMIZLBQLJCDIDJRB2TWNFROV4
X-Message-ID-Hash: KDFCH5DAMIZLBQLJCDIDJRB2TWNFROV4
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KDFCH5DAMIZLBQLJCDIDJRB2TWNFROV4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

External Boost without GPIO1 as VSPK switch
is no longer supported, but there is laptop
models using this feature.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 18fb471aa891..8465623bbd96 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -85,11 +85,13 @@ properties:
       boost-cap-microfarad.
       External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
       enable boost voltage.
+      External Boost without GPIO1 as VSPK switch is no longer supported.
       0 = Internal Boost
       1 = External Boost
+      2 = External Boost without VPSK switch (Do not use in new systems)
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-    maximum: 1
+    maximum: 2
 
   cirrus,gpio1-polarity-invert:
     description:
-- 
2.39.1

