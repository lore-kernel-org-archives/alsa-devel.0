Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47536FED3F2
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:29:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 451C460205;
	Fri, 24 Apr 2026 21:29:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 451C460205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777058965;
	bh=wPYMwnikED87qo4n8PdD8k2EhQRriCpbTvJp6XvxhFk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=E1XBvzW8hlBqU5mSLwfgfQm59paMwQfGs/g0mcyFvNt4OD+bmxp6s/r36FdoqcOeN
	 Nu2/sCJvN0H2T5vg18+dAZojx5E3BjMPS1uxOy1N+W5QMczc+1Dez5Ii9ExOPAGpST
	 3ohb38lTwqxHAX1UzHFoKCQPOTJ8UBvVGv/9WfzM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23E64F805F7; Fri, 24 Apr 2026 21:28:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7670AF805F4;
	Fri, 24 Apr 2026 21:28:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECE52F8055A; Tue, 21 Apr 2026 15:20:53 +0200 (CEST)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6DBFAF80100
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2026 15:20:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DBFAF80100
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 8B7BE2338E;
	Tue, 21 Apr 2026 16:20:48 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] ALSA: usb-audio: fix null pointer dereference on
 pointer cs_desc
Date: Tue, 21 Apr 2026 16:20:47 +0300
Message-Id: <20260421132047.38233-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: kovalev@altlinux.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IAY374HCUL3W74DPYDJW3OSXB6NLGTXB
X-Message-ID-Hash: IAY374HCUL3W74DPYDJW3OSXB6NLGTXB
X-Mailman-Approved-At: Fri, 24 Apr 2026 19:28:45 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IAY374HCUL3W74DPYDJW3OSXB6NLGTXB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Chengfeng Ye <cyeaa@connect.ust.hk>

commit b97053df0f04747c3c1e021ecbe99db675342954 upstream.

The pointer cs_desc return from snd_usb_find_clock_source could
be null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
Link: https://lore.kernel.org/r/20211024111736.11342-1-cyeaa@connect.ust.hk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Fixes: 1dc669fed61a ("ALSA: usb-audio: UAC2: support read-only freq control")
[ kovalev: bp to fix CVE-2021-47211; added Fixes tag; the null
  check was added into both UAC2 and UAC3 branches since the
  older kernel still has the clock source lookup split between
  snd_usb_find_clock_source() and snd_usb_find_clock_source_v3()
  (see upstream commit 9ec730052fa2) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/usb/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 197a6b7d8ad6..3d5d4f3aafce 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -646,11 +646,17 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 		struct uac3_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source_v3(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return 0;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else {
 		struct uac_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return 0;
 		bmControls = cs_desc->bmControls;
 	}
 
-- 
2.50.1

