Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33086C4332D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 18:03:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E18664F4D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E18664F4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BB4D165E;
	Thu,  4 Feb 2021 19:02:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BB4D165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612461804;
	bh=QYq0g+CSAiUq3fPInarEFKS4fPRC5AUviZrNEEtYEVM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GJpzDCxUzk1+zLzUv4PvcoOhv15uAyuR7yxGhvuapBv2CnbOEi+kib0uweTdZiA5V
	 E8731Dqm5CwifqRplxyhFsyORqtv6OrtyhT3gv9dgPTXpQGGdWrjnoTxf1jPwxUFIx
	 EmOP/JZcnheRc04Ua2ByvdJrsaZBhMSbGWSyp5Rg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1F4AF80155;
	Thu,  4 Feb 2021 19:02:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F278F80139; Thu,  4 Feb 2021 19:02:32 +0100 (CET)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60335F80139
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 19:02:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60335F80139
Received: from ramsan.of.borg ([84.195.186.194])
 by xavier.telenet-ops.be with bizsmtp
 id R62K2400P4C55Sk0162K3Z; Thu, 04 Feb 2021 19:02:20 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1l7im7-003Fgj-Bz; Thu, 04 Feb 2021 18:50:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1l7eFE-006uK3-GU; Thu, 04 Feb 2021 14:00:24 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: dt-bindings: renesas,
 rsnd: Group tuples in playback/capture properties
Date: Thu,  4 Feb 2021 14:00:22 +0100
Message-Id: <20210204130022.1646427-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
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

To improve human readability and enable automatic validation, the tuples
in "playback" and "capture" properties in sound device nodes should be
grouped using angle brackets.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 0fd37aa84947aa89..2e1046513603ed01 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -404,7 +404,7 @@ examples:
         /* DAI base */
         rcar_sound,dai {
             dai0 {
-                playback = <&ssi5 &src5>;
+                playback = <&ssi5>, <&src5>;
                 capture  = <&ssi6>;
             };
             dai1 {
@@ -430,8 +430,8 @@ examples:
                 bitclock-master = <&rsnd_endpoint0>;
                 frame-master = <&rsnd_endpoint0>;
 
-                playback = <&ssi0 &src0 &dvc0>;
-                capture  = <&ssi1 &src1 &dvc1>;
+                playback = <&ssi0>, <&src0>, <&dvc0>;
+                capture  = <&ssi1>, <&src1>, <&dvc1>;
             };
         };
     };
-- 
2.25.1

