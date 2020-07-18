Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C75C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDDB2073A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z7XJvpsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDDB2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=al2klimov.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1A5E15F9;
	Mon, 20 Jul 2020 09:36:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1A5E15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595230637;
	bh=rxuif/MThSmXSFHGHZ520a/xCJ1x4CCOjuUY+TSbjfA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z7XJvpsQ3NRv7A18WvmYdn/+K0nAtupiqrkCiZLXk/aus5HT4pAcodppmMC8Pc57E
	 932FuwrNXT76C7istdD30E7a8D360OtOML+1AFahc52+TWKeXATkCgOh/dScekeu2J
	 dAypmANfth1f/wGTfJ/E5p2aOe9MNcZbaY0h5ONg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA77DF8024A;
	Mon, 20 Jul 2020 09:34:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03332F8014E; Sat, 18 Jul 2020 13:12:28 +0200 (CEST)
Received: from smtp.al2klimov.de (smtp.al2klimov.de
 [IPv6:2a01:4f8:c0c:1465::1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6525EF80141
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2020 13:12:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6525EF80141
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by smtp.al2klimov.de (Postfix) with ESMTPA id 214F8BC073;
 Sat, 18 Jul 2020 11:12:15 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: Replace HTTP links with HTTPS ones
Date: Sat, 18 Jul 2020 13:12:09 +0200
Message-Id: <20200718111209.11760-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
 auth=pass smtp.auth=aklimov@al2klimov.de
 smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
X-Mailman-Approved-At: Mon, 20 Jul 2020 09:34:10 +0200
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
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

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 sound/soc/fsl/imx-audmix.c | 4 ++--
 sound/soc/fsl/imx-audmux.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index e09b45de0efd..96980cb0497f 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -6,8 +6,8 @@
  * License. You may obtain a copy of the GNU General Public License
  * Version 2 or later at the following locations:
  *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
+ * https://www.opensource.org/licenses/gpl-license.html
+ * https://www.gnu.org/copyleft/gpl.html
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 3ce85a43e08f..25c18b9e348f 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -5,7 +5,7 @@
 // Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
 //
 // Initial development of this code was funded by
-// Phytec Messtechnik GmbH, http://www.phytec.de
+// Phytec Messtechnik GmbH, https://www.phytec.de
 
 #include <linux/clk.h>
 #include <linux/debugfs.h>
-- 
2.27.0

