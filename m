Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75833C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 12:26:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBB6018FD;
	Thu, 23 Dec 2021 13:26:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBB6018FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640262417;
	bh=LXX3MFVqexxT0uUsfagwo+4AZS+2/jKu1QZcGiXfkEw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r5lNJGmQ6eSfU0eTeYjYKGUm4UM+4IVy7OCFqRo7TU5ud21d2Z0DO820ibFhjGuzl
	 Dt4IwpFPSNJ6zg9AtoL+TmSBEFlV98tw8z5RR4Jbu6uzo/UEASOCv/cHmerB16hCX0
	 8kaKuwT6yrpeRtxza0ea+vSE+9E9RaWVlmU05T9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26FF7F804FB;
	Thu, 23 Dec 2021 13:25:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1773AF8011C; Thu, 23 Dec 2021 13:25:05 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050::465:101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0738FF8011C
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 13:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0738FF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="pBEv7ALi"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JKTsf5kkFzQlMr;
 Thu, 23 Dec 2021 13:24:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1640262292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AJpoRdexrnOtBRI2pfsPR3ucnnbUQrgNa/5ZNXlnTw=;
 b=pBEv7ALiG6Hg1wxHFU+oU6uBhU51v7lwcvW3Rkap/aFAesWIN7GDgAL8AlON5cYrj2k9AD
 dKLysegDxC3ZQozdGI6yC0dXZb4tIengZ7xk/5we8n9/hHu8d6g2xaKdydhgYsRQtxiFPb
 Dn5D0byw8ImsqMkGoWspgtj+Cg/44uhpi+l/F+gXLYJYbI7G8rnnhzgIAxrK+NIQEbPBuq
 657lc9ckNInGEdt99GeoJNprbBYs5luLpQoKR+USAa7sbs676IP1rVd47YTiyLyKL2Vdpl
 g0aJnmf5H35IIAjfdRDINN8XtUlPle+11RnzjF5dp8fd3LCoFvGNFnuK9PqntA==
From: Alexander Stein <alexander.stein@mailbox.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ASoC: dt-bindings: aiu: spdif-dit: add missing
 sound-name-prefix property
Date: Thu, 23 Dec 2021 13:24:34 +0100
Message-Id: <20211223122434.39378-4-alexander.stein@mailbox.org>
In-Reply-To: <20211223122434.39378-1-alexander.stein@mailbox.org>
References: <20211223122434.39378-1-alexander.stein@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alexander Stein <alexander.stein@mailbox.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
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

This is used in meson-gx. Add the property to the binding.
This fixes the dtschema warning:
audio-controller@5400: 'sound-name-prefix' does not match any of the
regexes: 'pinctrl-[0-9]+'

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
---
 Documentation/devicetree/bindings/sound/amlogic,aiu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
index f50558ed914f..0705f91199a0 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
@@ -9,6 +9,9 @@ title: Amlogic AIU audio output controller
 maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
+allOf:
+  - $ref: name-prefix.yaml#
+
 properties:
   $nodename:
     pattern: "^audio-controller@.*"
@@ -65,6 +68,8 @@ properties:
   resets:
     maxItems: 1
 
+  sound-name-prefix: true
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.34.1

