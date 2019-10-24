Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17206CA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:17:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129D72166E
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qG/NPn6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129D72166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96D8A16E6;
	Thu, 24 Oct 2019 17:16:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96D8A16E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571930224;
	bh=g6kFH/ZYhh4Mib4i654Iuqk8RUkyHrogeeKirfHeDDs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qG/NPn6oRbfFj2hmoPLcvO0QEVjXfc9P1l+NS8awcexjShKcY5fQoqaoB7beAVraE
	 P00a5pKN9j0H/HJQYnsx0T044/XIChZa1HXOlE08eS37gosvnTeTJa+c6rbaHc+P7t
	 7hwr3H6dlgOOrL2DJme4TPgzZxFScp5P6gTKORRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 138ADF80367;
	Thu, 24 Oct 2019 17:16:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74846F80112; Thu, 24 Oct 2019 17:16:13 +0200 (CEST)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E239EF80112
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 17:16:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E239EF80112
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id HTG92100Z5USYZQ06TG9U7; Thu, 24 Oct 2019 17:16:10 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iNeqP-0006xc-8R; Thu, 24 Oct 2019 17:16:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iNeqP-0007ZC-62; Thu, 24 Oct 2019 17:16:09 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Kosina <trivial@kernel.org>
Date: Thu, 24 Oct 2019 17:16:03 +0200
Message-Id: <20191024151603.29043-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [alsa-devel] [PATCH trivial] ASoC: Spelling s/configr/configur/
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

Fix misspellings of "configuration" and "configure".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/sound/wm8904.h     | 2 +-
 sound/soc/codecs/cx2072x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 14074405f5012f9a..88ac1870510ec063 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -120,7 +120,7 @@
  * DRC configurations are specified with a label and a set of register
  * values to write (the enable bits will be ignored).  At runtime an
  * enumerated control will be presented for each DRC block allowing
- * the user to choose the configration to use.
+ * the user to choose the configuration to use.
  *
  * Configurations may be generated by hand or by using the DRC control
  * panel provided by the WISCE - see  http://www.wolfsonmicro.com/wisce/
diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 1c1ba7bea4d81969..2ad00ed21bec6c59 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1507,7 +1507,7 @@ static int cx2072x_probe(struct snd_soc_component *codec)
 	regmap_multi_reg_write(cx2072x->regmap, cx2072x_reg_init,
 			       ARRAY_SIZE(cx2072x_reg_init));
 
-	/* configre PortC as input device */
+	/* configure PortC as input device */
 	regmap_update_bits(cx2072x->regmap, CX2072X_PORTC_PIN_CTRL,
 			   0x20, 0x20);
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
