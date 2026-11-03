Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD05606A32C
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=V13pHZBW;
	dkim=pass (1024-bit key, unprotected) header.d=senarytech.com header.i=@senarytech.com header.a=rsa-sha256 header.s=default header.b=C/S4kgdH
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C1C86022A;
	Tue,  3 Nov 2026 08:59:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C1C86022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793692778;
	bh=5FpWI/OQOVxMznctmNKKSGZzGlAjG3MEZTZKe7QqyZo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=V13pHZBWBnV1BaWW7W4r6J2lpIlgBh03LdHbc0XVPxM1AObk2svM8IQWkBLKiEHxH
	 nRzKRsa4HPuYO7UG/bgTzO/IdgmFuEnrAbcOPI+sotI2UX8J7uIfIY40WgfrcfzoU6
	 BXJYAxBgnxxrcKETvqjFxGSS9PdM726u3akd5Q+c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE90CF80698; Tue,  3 Nov 2026 08:58:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 449A4F80691;
	Tue,  3 Nov 2026 08:58:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E2B5F804CF; Tue,  3 Nov 2026 08:02:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=160.236.52.248
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793689326;
	b=TYkJRNz6qKrQ1eBEkYhQhj/2qMRWjyBSyMoBTRgngKH1vFigok/ZfjQHkMJafZPd6q2j
	 gupodzcWu9SAdyhCRwH2gZnAO/XeCxJ2teEBzH2zKo7BpdJ6Plu9/dNqO2zKV4Ed/X4yj
	 1mN5OiNdd5Q6ZyrFe6ejpNxik24ItBtB6j9nmvybmMB0gCD9CKG72T9NyZc5n1t8yP7Ns
	 MRcu1cOYAhfN07LNi1sM2PxF38XVLCjtEDaZgjqib12/nJ/RRny6xPn35uNkbMFRAknaF
	 rWebIVzbG92ZvFUBu2MhHLjLp4KOn/DEuAZAc11g/zkFZ6irF6SY4R5PuHOSJKZ/Hsg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793689326;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature;
	bh=5FpWI/OQOVxMznctmNKKSGZzGlAjG3MEZTZKe7QqyZo=;
	b=WAFmCVDJvPj7ohUHzitanIe5t5WhdjW4tDiX8kG3grU20A1Z79enV2C65j/ZDYKuAK3U
	 /XVK+C8KFIbDqYFHmJiALe9XquCWWf1oFzIGVcGvxI96xCWB4lnSzWAdo9qJUu5riVB14
	 /9QtEF8OZA+aO+yb+OTBdR8tx3k7PB7yPSpYW3XZ9S7ELaHoq05dnoUbg2/l+p1sHyYV2
	 aQ6C+Vk8t0tgbyR5xOLZqdsiTENt4X/un96ebEK8gsgh8vc4yXQjK35cTT3fZQJzPFj0v
	 UXV/kqDHd2SSh0w5pUODkXXFHIBYKklALOc2p92hL+3zYLIzatan/ZIYplEz/l/4PzA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=senarytech.com header.i=@senarytech.com
 header.a=rsa-sha256 header.s=default header.b="C/S4kgdH";
	arc=none smtp.remote-ip=160.236.52.248
Received: from mail-m16023652248.xmail.ntesmail.com
 (mail-m16023652248.xmail.ntesmail.com [160.236.52.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A67FDF800EE
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 08:01:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A67FDF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=senarytech.com header.i=@senarytech.com
 header.a=rsa-sha256 header.s=default header.b=C/S4kgdH
Received: from Wangqianghua.localdomain (unknown [27.38.136.171])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534bfea0d;
	Tue, 3 Nov 2026 15:01:51 +0800 (GMT+08:00)
From: Qianghua Wang <qianghua.wang@senarytech.com>
To: linux-sound@vger.kernel.org
Cc: Bo Liu <bo.liu@senarytech.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	Qianghua Wang <qianghua.wang@senarytech.com>
Subject: [PATCH] ASoC: codecs: sn624x-sdca: limit DMIC capture to 2 channels
Date: Tue,  3 Nov 2026 15:01:50 +0800
Message-ID: <20261103070150.115136-1-qianghua.wang@senarytech.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a036da3d09d8kunma5bf73f331087f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx8eVkNOTh9NHUsYGRlJGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJTFVIQ1VKSE1VSkxKWVdZFhoPEhUdFFlBWU9LSFVKS0
	hKT0hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=C/S4kgdHeBjXsLy8lnZvvMWC9MWiiOaGkOh0TckOFJ8ynU6YT2+bt2iY7HkS6YjZ0bGBuKA2H5RGZRaovRHqlb4BfxpLX6q09fctZlE+n5b3YTuRnB+kTiXDyFWJKaBniKOgeWayZQrhy+wLRCH52XmFCWnMHGFtNNGyXrCrvhM=;
 s=default; c=relaxed/relaxed; d=senarytech.com; v=1;
	bh=GFL336r8PyJB5/FWH8vrLZN0LvxwlMvARWGL4JCEU7E=;
	h=date:mime-version:subject:message-id:from;
X-MailFrom: qianghua.wang@senarytech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4UFCIB4NPF7FJI2KTJSELBLU3RFYEMTR
X-Message-ID-Hash: 4UFCIB4NPF7FJI2KTJSELBLU3RFYEMTR
X-Mailman-Approved-At: Tue, 03 Nov 2026 07:58:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4UFCIB4NPF7FJI2KTJSELBLU3RFYEMTR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The SN624x DMIC path only has two microphones. The aif3 capture DAI
advertised channels_max = 4, so userspace could open a 4-channel
capture that the hardware does not provide.

Clamp the DMIC capture DAI to two channels to match the headset
capture DAI and the sof-sdca-mic function topology.

Tested on a Wildcat Lake laptop with SN6244: hw:*,4 reports CHANNELS
2 and rejects a 4-channel arecord.

Signed-off-by: Qianghua Wang <qianghua.wang@senarytech.com>
---
 sound/soc/codecs/sn624x-sdca-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sn624x-sdca-sdw.c b/sound/soc/codecs/sn624x-sdca-sdw.c
index c9e690482..cbe0af706 100644
--- a/sound/soc/codecs/sn624x-sdca-sdw.c
+++ b/sound/soc/codecs/sn624x-sdca-sdw.c
@@ -1669,7 +1669,7 @@ static struct snd_soc_dai_driver sn624x_sdca_dai[] = {
 		.capture = {
 			.stream_name = "DMic Capture",
 			.channels_min = 1,
-			.channels_max = 4,
+			.channels_max = 2,
 			.rates = SN624X_STEREO_RATES,
 			.formats = SN624X_FORMATS,
 		},
-- 
2.53.0

