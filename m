Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E615F588C6
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:17:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 700AA60207;
	Mon, 20 Apr 2026 15:17:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 700AA60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776691031;
	bh=rin35+9vT4DY1bInuQye8vN8xXn//w1ChbUG8r247Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KMy9LlUDLed8tq8hgGSBKK2xG4QJe2+KpRcHZp2VE4qIQSlNlOhkQO0QzKOTlAto3
	 /o0DlOyZ1pz0ZiVcoi5pDVgjU+5ahI+NLuD8zQXhgARPen5jzwRERJPX+hK7B4Swvq
	 4E7PeBxsVQBz8WvdIFBXNU5y+lt8LCDBYVrnOwgM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A0BBF8062D; Mon, 20 Apr 2026 15:16:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F87F8061A;
	Mon, 20 Apr 2026 15:16:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 439F2F805F8; Mon, 20 Apr 2026 15:15:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A77BBF805F5
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2026 15:15:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A77BBF805F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BPNVlaTW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 72401409F6;
	Mon, 20 Apr 2026 13:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DFBC2BCB8;
	Mon, 20 Apr 2026 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690955;
	bh=rin35+9vT4DY1bInuQye8vN8xXn//w1ChbUG8r247Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPNVlaTWsFZ/jwjEvM67TuhUTqIEzAJDLUsUkyRoQmk2Uv2hT1ZYdimLlGSp3Wj2n
	 /vShBNrXjn/neUcR0poTg3m4D64ISD+MkekpmKVYS1EV6oy2hbuTUci9ZRfqE6Mwtz
	 8HDa2dRGUHicloTIleKMDh/9+vMNWbpsmQrcKWN0F7tadj02xITau0rAlqAUWUpDsn
	 qYTWrcMLwlqifM8cbuA2oqrd7HtdKN+uRq5BM87N/CxTgNo9+SEvtCXFY6JszeVp3x
	 8i86mQ3sxCyCwrxn3WCMvJn31YXiU/8pLmn1myx38ON4tMPKFLHvqegOA9jiu9MOe3
	 cNOb8YojF9nJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hasun Park <hasunpark@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ASoC: amd: acp: add ASUS HN7306EA quirk for
 legacy SDW machine
Date: Mon, 20 Apr 2026 09:07:56 -0400
Message-ID: <20260420131539.986432-10-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MELPOE5XW46T5TCH5ZQHL6XYONQRV66E
X-Message-ID-Hash: MELPOE5XW46T5TCH5ZQHL6XYONQRV66E
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MELPOE5XW46T5TCH5ZQHL6XYONQRV66E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Hasun Park <hasunpark@gmail.com>

[ Upstream commit 2594196f4e3bd70782e7cf1e22e3e398cdb74f78 ]

Add a DMI quirk entry for ASUS HN7306EA in the ACP SoundWire legacy
machine driver.

Set driver_data to ASOC_SDW_ACP_DMIC for this board so the
platform-specific DMIC quirk path is selected.

Signed-off-by: Hasun Park <hasunpark@gmail.com>
Link: https://patch.msgid.link/20260319163321.30326-1-hasunpark@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 86c534d827448..504b700200660 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -111,6 +111,14 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HN7306EA"),
+		},
+		.driver_data = (void *)(ASOC_SDW_ACP_DMIC),
+	},
 	{}
 };
 
-- 
2.53.0

