Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3EC3F2CD
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA17124658
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XASSNo0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17124658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iwr.uni-heidelberg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51AF31655;
	Wed,  4 Mar 2020 16:34:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51AF31655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583336113;
	bh=adJvCWPbOltS3C4TifpkLpEV71SOXadjXyOsg1o2OmM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XASSNo0VzZ5kO4JpPd6G+koIqEzwp+dSzGX0/Nx7h/OWI3x7X1p6344AtSL6Prvk5
	 cKfc2Xd33nguEJjBqVWYp5iikSxUtn1196vimLqplWvgYWg5egytK2xcODDl9IJ3V3
	 MLWfQOJEu8JLZzIz3+b7o3JWtx9S0Ov/iOH/1Lz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2675F801EC;
	Wed,  4 Mar 2020 16:34:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9580F801ED; Wed,  4 Mar 2020 16:34:21 +0100 (CET)
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
 [129.206.100.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45714F8011C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 16:34:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45714F8011C
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BvBwCYyV9e/1BozoFmgkGCKVmBGiq?=
 =?us-ascii?q?EFY8Am1SCBAEBAQEBAQEBAQgsAQIEAQGGRiQ0CQ4CAwEBCwEBBgEBAQEBBQR?=
 =?us-ascii?q?thWKGDTBbAgUhAhEFKDSGIq06gTKJAoE+gQ4qjCcPgUw/hGOFGIJEMoIsBLA?=
 =?us-ascii?q?cB4FJdnyVXgwcjwmMJwGqZYFSOYFYMxokgztQGA2NcwGOckMwAoEEAQGNQAE?=
 =?us-ascii?q?B?=
Received: from lemon.iwr.uni-heidelberg.de ([129.206.104.80])
 by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Mar 2020 16:34:18 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
 (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
 id 1j9W2L-0002AD-12
 for alsa-devel@alsa-project.org; Wed, 04 Mar 2020 16:34:17 +0100
Date: Wed, 4 Mar 2020 16:34:17 +0100
From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: tas571x: use symbolic register offsets
Message-ID: <20200304153416.GA8262@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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

convert the numeric register offsets in tas5711_reg_defaults to the defined constants TAS571X_* from tas571x.h
Tested with a tas5713 chip for which the driver works, too.

Signed-off-by: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -424,13 +424,13 @@
 };
 
 static const struct reg_default tas5711_reg_defaults[] = {
-	{ 0x04, 0x05 },
-	{ 0x05, 0x40 },
-	{ 0x06, 0x00 },
-	{ 0x07, 0xff },
-	{ 0x08, 0x30 },
-	{ 0x09, 0x30 },
-	{ 0x1b, 0x82 },
+	{ TAS571X_SDI_REG,		0x05 },
+	{ TAS571X_SYS_CTRL_2_REG,	0x40 },
+	{ TAS571X_SOFT_MUTE_REG,	0x00 },
+	{ TAS571X_MVOL_REG,		0xff },
+	{ TAS571X_CH1_VOL_REG,		0x30 },
+	{ TAS571X_CH2_VOL_REG,		0x30 },
+	{ TAS571X_OSC_TRIM_REG,		0x82 },
 };
 
 static const struct regmap_config tas5711_regmap_config = {


