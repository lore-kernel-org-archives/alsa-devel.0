Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CBEB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 12:19:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54C68844;
	Wed, 14 Jun 2023 14:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54C68844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686745139;
	bh=0oRcxlUokhguFqHnYzmkBRSycH+0ibSZE9Utzeg2bw4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WdwdGrlZ7F5/5ZeBw0N/Dest7l6FDPksF3Q1rNVCg0q1mZIpTTrZhC1WM2GW3cMKb
	 NzXu17hd/b4ZxWVZayktnknJ7PwSwg02W0Quu7wPxP9E2T81QO+ubI0u5KuxabMGu7
	 SVyMO9IanTnO4UlmU1XjvQ6uXGviNY5bgnSa/+PQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAB0EF805C4; Wed, 14 Jun 2023 14:16:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 115EDF805BF;
	Wed, 14 Jun 2023 14:16:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B095EF80149; Wed, 14 Jun 2023 13:34:30 +0200 (CEST)
Received: from cloudserver3200665-3200696.home.pl
 (cloudserver3200665-3200696.home.pl [46.242.240.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48076F800BA
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 13:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48076F800BA
Received: from localhost (127.0.0.1) (HELO sv086.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with
 SMTP (IdeaSmtpServer 5.2.0)
 id 99d28c93892c5d81; Wed, 14 Jun 2023 13:34:23 +0200
Received: from HEM05L.admytek.local (unknown [213.108.156.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by sv086.home.net.pl (Postfix) with ESMTPSA id B71E94211F;
	Wed, 14 Jun 2023 13:34:22 +0200 (CEST)
From: Lukasz Tyl <ltyl@hem-e.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	pgorgon@hem-e.com,
	Lukasz Tyl <ltyl@hem-e.com>
Subject: [PATCH] sound: usb: quirks: add flag for HEM devices to enable native
 DSD playback
Date: Wed, 14 Jun 2023 13:33:50 +0200
Message-Id: <20230614113350.25607-1-ltyl@hem-e.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLIENT-IP: 213.108.156.244
X-CLIENT-HOSTNAME: 213.108.156.244
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: 
 gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnfhukhgrshiiucfvhihluceolhhthihlsehhvghmqdgvrdgtohhmqeenucggtffrrghtthgvrhhnpeeghfeuhedvvefhhefghfdtjeekudevudelheekgeegjeduueefgeetfeelueehudenucfkphepvddufedruddtkedrudehiedrvdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddutdekrdduheeirddvgeegpdhhvghlohepjffgofdthefnrdgrughmhihtvghkrdhlohgtrghlpdhmrghilhhfrhhomhepnfhukhgrshiiucfvhihluceolhhthihlsehhvghmqdgvrdgtohhmqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtthhopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhgohhrghhonheshhgvmhdqvgdrtghomhdprhgtphhtthhopehlthihlheshhgvmhdqvgdrtghomh
X-DCC--Metrics: sv086.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-MailFrom: ltyl@hem-e.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: TCVHL756C4Y43RPSHZ5FFMULH4RGQKJB
X-Message-ID-Hash: TCVHL756C4Y43RPSHZ5FFMULH4RGQKJB
X-Mailman-Approved-At: Wed, 14 Jun 2023 12:16:25 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TCVHL756C4Y43RPSHZ5FFMULH4RGQKJB/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This commit adds new DEVICE_FLG with QUIRK_FLAG_DSD_RAW and Vendor Id for
HEM devices which supports native DSD. Prior to this change Linux kernel
was not enabling native DSD playback for HEM devices, and as a result,
DSD audio was being converted to PCM "on the fly". HEM devices,
when connected to the system, would only play audio in PCM format,
even if the source material was in DSD format. With the addition of new
VENDOR_FLG in the quircks.c file, the devices are now correctly
recognized, and raw DSD data is transmitted to the device,
allowing for native DSD playback.

Signed-off-by: Lukasz Tyl <ltyl@hem-e.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3ecd1ba7fd4b..1414bf15ac21 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2197,6 +2197,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0xc502, /* HiBy devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3336, /* HEM devices */
+		   QUIRK_FLAG_DSD_RAW),
 
 	{} /* terminator */
 };
-- 
2.34.1

