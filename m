Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2094C25B47
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Oct 2023 10:02:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29A3AA4C;
	Fri, 27 Oct 2023 12:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29A3AA4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698400976;
	bh=4e5dhx6W/LNRDl50RsAPnIkiULLX7dnsUWUcl2bZ74k=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hoFSSLD0ovlOWub0BVyQUgKlDrS0/ZR5VDWcpFDHEEdapZ6WTMEB9espxjh3MV+1y
	 WZgwzzeHLI86xjoMKcsvlMZbyGbbLmEOXT1NHwg+egbmxqPitTau3Z1oWkitnVhBju
	 V1+7sRrTEd56bFTFtonhJ31+tiqn1/1PNeERu6HY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7E62F80557; Fri, 27 Oct 2023 12:01:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99181F8028D;
	Fri, 27 Oct 2023 12:01:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13693F8019B; Fri, 27 Oct 2023 12:01:33 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC7D1F8014B
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 12:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC7D1F8014B
Received: by m.b4.vu (Postfix, from userid 1000)
	id 9580E6147BB8; Fri, 27 Oct 2023 20:31:21 +1030 (ACDT)
Date: Fri, 27 Oct 2023 20:31:21 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: scarlett2: Add missing check with firmware version
 control
Message-ID: <ZTuKcXajVnuelBEb@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: C3UVLQYRHLZVXUNTQEEPW4MQYZUILBPE
X-Message-ID-Hash: C3UVLQYRHLZVXUNTQEEPW4MQYZUILBPE
X-MailFrom: g@b4.vu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C3UVLQYRHLZVXUNTQEEPW4MQYZUILBPE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

scarlett2_add_firmware_version_ctl() may return an error, but the
return value was not being checked. Add the missing check.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index f6d1fdfa88e1..9803f3e426c6 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -4424,6 +4424,8 @@ static int snd_scarlett2_controls_create(
 
 	/* Add firmware version control */
 	err = scarlett2_add_firmware_version_ctl(mixer);
+	if (err < 0)
+		return err;
 
 	/* Read volume levels and controls from the interface */
 	err = scarlett2_read_configs(mixer);
-- 
2.41.0

