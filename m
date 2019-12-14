Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ADC43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:57:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351A12072B
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BVr102ob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="E1iamzbf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="E1iamzbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351A12072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5879165F;
	Sun, 15 Dec 2019 00:56:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5879165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576367830;
	bh=1POjPEtEflTMyjkwffusj3P5dmZtSMh1nqAFHluxFKA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVr102obftZXkNqCcE1kuVWpS3or2stDTRc2zTKE6eK9F26AjLFqelhuoaDMJw+O4
	 ls1cVYp5HjWtg40O9RJf1k1cDXOG763LBtCjTqDGOse7JKqK6YSOBK7/9j05IhyUn7
	 NJiHhVJpUYuApTwKClAztA0R+teEpAwOLWDMB7yo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64254F801D8;
	Sun, 15 Dec 2019 00:56:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE930F8022D; Sun, 15 Dec 2019 00:56:16 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A40DF8014F
 for <alsa-devel@alsa-project.org>; Sun, 15 Dec 2019 00:56:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A40DF8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="E1iamzbf"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="E1iamzbf"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id C9C0E4E200E;
 Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576367770; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E1iamzbfDFUgiQVjPZ5VUjG6MRahIpppFp2Gt/CcK2VlOBIhQP0Goa5ztQLQEu8sV
 9CEzEEufMBp4gv6YUv5XsJH+rZMwa0gAXSfOF0HPyIusv7ofiR13wL2+vX2kAfKRJI
 k4I7GPY8ilZjYP4sMjU7WRdf/FR6SDUSa9FT+1KQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3F5Ef6DWhwm; Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net
 [70.66.86.75])
 by node.akkea.ca (Postfix) with ESMTPSA id 54F364E2003;
 Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576367770; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E1iamzbfDFUgiQVjPZ5VUjG6MRahIpppFp2Gt/CcK2VlOBIhQP0Goa5ztQLQEu8sV
 9CEzEEufMBp4gv6YUv5XsJH+rZMwa0gAXSfOF0HPyIusv7ofiR13wL2+vX2kAfKRJI
 k4I7GPY8ilZjYP4sMjU7WRdf/FR6SDUSa9FT+1KQ=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: Mark Brown <broonie@kernel.org>
Date: Sat, 14 Dec 2019 15:55:50 -0800
Message-Id: <20191214235550.31257-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
References: <20191214235550.31257-1-angus@akkea.ca>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 "Angus Ainslie \(Purism\)" <angus@akkea.ca>, kernel@puri.sm,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [alsa-devel] [PATCH v2 2/2] dt-bindings: sound: gtm601: add the
	broadmobi interface
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The Broadmobi BM818 uses a different sample rate and channels from the
option modem.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/gtm601.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
index 5efc8c068de0..efa32a486c4a 100644
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ b/Documentation/devicetree/bindings/sound/gtm601.txt
@@ -1,10 +1,16 @@
 GTM601 UMTS modem audio interface CODEC
 
-This device has no configuration interface. Sample rate is fixed - 8kHz.
+This device has no configuration interface. The sample rate and channels are
+based on the compatible string
+	"option,gtm601" = 8kHz mono
+	"broadmobi,bm818" = 48KHz stereo
 
 Required properties:
 
-  - compatible : "option,gtm601"
+  - compatible : one of
+	"option,gtm601"
+	"broadmobi,bm818"
+
 
 Example:
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
