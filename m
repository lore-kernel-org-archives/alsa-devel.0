Return-Path: <SRS0=1MT+=LV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91130C48BC2
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 13:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCD961477
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 13:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCD961477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D0FD16A0;
	Sun, 27 Jun 2021 15:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D0FD16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624800254;
	bh=wrzUBLu7vv0SMBlSJhAOY13vhYnIBZsl16kprsEqckQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8fJqVEMimlYhfXSTe9dkMsDmPm80V8Lh42qT/ScHxCcEiMYk6aFfsU57uZsdE2lf
	 +HNAw5ETQOYIMKzqRBz6crlNDoUDjPUAY7KyFfjSBauAdMqvl8xCYz25LNxROeQpha
	 P55SP+sooocOw86pvWC1ydbsQvPOg56sY1o8NsHM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1DB3F802D2;
	Sun, 27 Jun 2021 15:22:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82FDFF804AE; Sun, 27 Jun 2021 15:22:37 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ED1CF80240
 for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2021 15:22:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ED1CF80240
Received: by m.b4.vu (Postfix, from userid 1000)
 id D930461E5F02; Sun, 27 Jun 2021 22:52:26 +0930 (ACST)
Date: Sun, 27 Jun 2021 22:52:26 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: scarlett2: Fix pad count for 18i8 Gen 3
Message-ID: <29a6ce412a42373daab7c96c395560461fcf08c6.1624798436.git.g@b4.vu>
References: <cover.1624798436.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624798436.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Aaron Wolf <aaron@wolftune.com>,
 Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

The 18i8 Gen 3 has 4 inputs with a pad control, not 2. Update
s18i8_gen3_info.pad_input_count.

Reported-by: Aaron Wolf <aaron@wolftune.com>
Tested-by: Aaron Wolf <aaron@wolftune.com>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fcba682cd422..a6387d5c1888 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -702,7 +702,7 @@ static const struct scarlett2_device_info s18i8_gen3_info = {
 	.line_out_hw_vol = 1,
 	.has_speaker_switching = 1,
 	.level_input_count = 2,
-	.pad_input_count = 2,
+	.pad_input_count = 4,
 	.air_input_count = 4,
 	.phantom_count = 2,
 	.inputs_per_phantom = 2,
-- 
2.31.1

