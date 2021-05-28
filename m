Return-Path: <SRS0=FleP=KX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F73C2B9F7
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 14:17:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32AE610A6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 14:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32AE610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 626BD16CD;
	Fri, 28 May 2021 16:16:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 626BD16CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622211422;
	bh=OKYKG4Td/pA0tworGfD316KejA0heP4GSr6nhVKZgcs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1vKk2Dd3C5fMFJ08doIv9fmd7BPADHow1GFcSP6Hk/s2YBn4/XF6QTEZvUQj1XKd
	 uNk6bJYyMU9mJ6jXXw+C+zAf6WW56vl8Ul85qh1MB5hqcmO8dqrQ0EqfCcR39G5mvN
	 fd8AmJON9N3LvpEZDKLqJ5GAedfs7P0mWwPvwcDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E775FF804A9;
	Fri, 28 May 2021 16:14:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4ABB9F80274; Fri, 28 May 2021 12:51:47 +0200 (CEST)
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C6ACF800B7
 for <alsa-devel@alsa-project.org>; Fri, 28 May 2021 12:51:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C6ACF800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org
 header.b="UYvqC49Z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
 t=1622199080; bh=OKYKG4Td/pA0tworGfD316KejA0heP4GSr6nhVKZgcs=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=UYvqC49ZWz4nm0Y1EtH5rHaV1xRpaQ+VN8UVELAzhxID/VTaAGtPAiKqABHdXGuK2
 or/Jx0RaAdcMskZToqzytonRjSdqbD0lZDbJWqMieI4fydfaigwT3Lv1O/jwnppc2O
 qaW5YdolLlLO7v4gWfv/+LOKvXLUYvEPNY4DXf0g=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
 via proxy.mailoo.org [213.182.55.207]
 Fri, 28 May 2021 12:51:20 +0200 (CEST)
X-EA-Auth: RDFPup0CGiESeT4DRztaa5d7F5htMiWQg095Z1QC++mxU6PK1lhKWwIAhJjRsHxp1a4svIiKucHduZJ0mIH4rDg0SdWoDPTbey18SIlWnPU=
From: Vincent Knecht <vincent.knecht@mailoo.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] ASoC: dt-bindings: nxp,
 tfa989x: Add vddd-supply property
Date: Fri, 28 May 2021 12:51:00 +0200
Message-Id: <20210528105101.508254-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 May 2021 16:14:26 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>
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

Add optional vddd-supply property to allow regulator control.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 46ddc1f3fc0c..ffb8fcfeb629 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -27,6 +27,9 @@ properties:
       Used as prefix for sink/source names of the component. Must be a
       unique string among multiple instances of the same component.
 
+  vddd-supply:
+    description: regulator phandle for the VDDD power supply.
+
 required:
   - compatible
   - reg
-- 
2.31.1



