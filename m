Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7DC4332B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:47:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2FD2072D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oiND6QOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2FD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kakaocorp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F05EE178D;
	Thu, 19 Mar 2020 16:46:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F05EE178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584632842;
	bh=4MWccweJbZsBSENCjQr8D9ZQoCIw8f4g0SZtSovhW6k=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oiND6QOERbXLQqRvjHxbsltec5gvi3dj49Z65Yd1nuSdp/rwgzYoxcfUiezsI0K9E
	 58jm2BFNDd9rqm2t2TYxcrkfk/vbPaqKdQxPJYqptqKguMnInFjX3+xy5Y3CfJeJF7
	 0wAXlfoijjlmfbxpHBThrwG4FmEjpTrvlPnxO1d0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37830F802A0;
	Thu, 19 Mar 2020 16:43:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FDECF8022B; Thu, 19 Mar 2020 15:02:14 +0100 (CET)
Received: from jhbirdchoi-MS-7B79 (unknown [182.227.190.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB692F800C0
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 15:02:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB692F800C0
Received: from jhbirdchoi-MS-7B79 (localhost [127.0.0.1])
 by jhbirdchoi-MS-7B79 (8.15.2/8.15.2/Debian-10) with ESMTP id 02JE1m3m006750; 
 Thu, 19 Mar 2020 23:01:48 +0900
Received: (from jhbirdchoi@localhost)
 by jhbirdchoi-MS-7B79 (8.15.2/8.15.2/Submit) id 02JE1iOs006732;
 Thu, 19 Mar 2020 23:01:44 +0900
Date: Thu, 19 Mar 2020 23:00:44 +0900
From: Jonghwan Choi <charlie.jh@kakaocorp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tas2562: Fixed incorrect amp_level setting.
Message-ID: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 19 Mar 2020 16:43:13 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

According to the tas2562 datasheet,the bits[5:1] represents the amp_level value.
So to set the amp_level value correctly,the shift value should be set to 1.

Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index be52886a5edb..fb2233ca9103 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =
 			1, 1);
 
 static const struct snd_kcontrol_new tas2562_snd_controls[] = {
-	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,
+	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
 		       tas2562_dac_tlv),
 };
 
-- 
2.17.1

