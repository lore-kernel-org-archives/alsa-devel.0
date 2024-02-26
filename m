Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44B6C54E41
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:15:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23E83868;
	Mon, 26 Feb 2024 15:15:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23E83868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708956953;
	bh=fSTzcUF5sHUEjJHYfFVvz/uuRwWIZE1RVfZE3SjND5c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YuSPKtp5xpy1IEoVquay9vjO+rscGVeAG3VDkmW4XiZJF8W5fpHHd2NApX1mnKXgr
	 PMwyuSDF0Td4tUz1rqUMEM4UU22P2JsI3Ykyj9WICPA4RAx9Vbo8BbOrhN+f88Oope
	 3Mr2VOcgrEP5JroMqGQhrpg3OHSYq3RspwFgZItM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF1ECF80579; Mon, 26 Feb 2024 15:15:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 78EF9F8057A;
	Mon, 26 Feb 2024 15:15:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EADFAF80246; Mon, 26 Feb 2024 15:15:06 +0100 (CET)
Received: from out3.rolmail.net (out3.rolmail.net
 [IPv6:2a02:2e8:0:2:0:25:e25:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46FE9F800EE
	for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2024 15:15:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46FE9F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=rolmail.net header.i=@rolmail.net header.a=rsa-sha256
 header.s=rol header.b=Amzlidpf
Received: from mf3.rolmail.net (mf3.rolmail.net
 [IPv6:2a02:2e8:0:2:0:25:1025:1])
	by out3.rolmail.net (ROL Relay Out) with ESMTP id 8FA8D16A093;
	Mon, 26 Feb 2024 15:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rolmail.net; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=rol; t=1708956899; bh=fSTz
	cUF5sHUEjJHYfFVvz/uuRwWIZE1RVfZE3SjND5c=; b=AmzlidpfloyAfBFr8uII
	uCtZ6+U0ayU2RwOVn2GCuHqcsiNosn4U1Md67B7yqtLs0WZHM9C+UWi04UHTs0+b
	+tqxLQJThhDLY1YMF0vFU7IW2jkfXcSmi4SDcgVDyuLpdvjPh17hKi1Ebcr54IXS
	wzcEcRdsp54qy+4URV05GNk=
Received: from relay-out1.konmail.net ([195.254.252.217])
	by mf3.rolmail.net (mf3.rolmail.net [195.254.252.162]) (ROL Spam Gateway,
 port 10022)
	with ESMTP id ksBqS1AodMKm; Mon, 26 Feb 2024 15:14:59 +0100 (CET)
Received: from fedora.. (srv-116.vc-graz.ac.at [193.171.126.116])
	by relay-out1.konmail.net (Konverto AG Relay In) with ESMTPSA id 23C0C169F71;
	Mon, 26 Feb 2024 15:14:59 +0100 (CET)
From: David Senoner <seda18@rolmail.net>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	David Senoner <seda18@rolmail.net>
Subject: [PATCH] [alsa-lib][PATCH] conf: USB-Audio: Add Corsair HS60 Pro to
 the IEC958 blacklist
Date: Mon, 26 Feb 2024 15:14:03 +0100
Message-ID: <20240226141403.13948-1-seda18@rolmail.net>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 4NWSQU5MM3SVZNLXVQD74P2FBJQFENOC
X-Message-ID-Hash: 4NWSQU5MM3SVZNLXVQD74P2FBJQFENOC
X-MailFrom: seda18@rolmail.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4NWSQU5MM3SVZNLXVQD74P2FBJQFENOC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This device is just an external USB soundcard with a female 3.5mm jack
for a headset, no S/PDIF | IEC958 connector. Add it to the blacklist to
prevent it being opened.

Signed-off-by: David Senoner <seda18@rolmail.net>
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.con=
f
index 80631b2e..08346a1b 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -53,6 +53,7 @@ USB-Audio.pcm.iec958_device {
 	"Blue Snowball" 999
 	"C-Media USB Headphone Set" 999
 	"Cmedia Audio" 999
+	"Corsair HS60 PRO Surround USB S" 999
 	"DELL PROFESSIONAL SOUND BAR AE5" 999
 	"HP Digital Stereo Headset" 999
 	"GN 9330" 999
--=20
2.43.2

