Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D1C64EC7
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Feb 2023 13:30:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06D20847;
	Wed, 15 Feb 2023 14:29:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06D20847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676467832;
	bh=Sh4IjgaHokJgqHxuz69NNaDzjOc7kjI45TUUvWgBqN8=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EwZrNlOk0OqqNLH0dFj69XUebj5lyZq1g0rWKoQTEr3LkC8ArW17CRJnDhGtbYYJC
	 S9//8D6zA29P6LIoOSZVUGki1v/T61bc00WTBP3165qco/QKu0918sPG1MucOjauej
	 E8SzPsdFyNCtD6ETSWlKnHj9n5NAZfbRrEih0DX8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4286F8047C;
	Wed, 15 Feb 2023 14:29:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F85CF8047C; Wed, 15 Feb 2023 14:29:13 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14C42F80083
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2023 14:29:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14C42F80083
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=ZsoQDgIk
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 181B0660218B;
	Wed, 15 Feb 2023 13:29:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1676467744;
	bh=Sh4IjgaHokJgqHxuz69NNaDzjOc7kjI45TUUvWgBqN8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZsoQDgIkrIcWTRcE4vZCQzUkyJidWRL35fXuYH8HRY7tkeG8cy60wOgJc0R1PwuHs
	 +FtFzU5FhoP24BuLSZKKCLDHvovyGtqwZYomcY3u/ZO9vMqCM1JnjwCMmuNFcbj+ir
	 4jl/+mVDQLnRQwqY9LiFsbxjQJfEA52wUS4hBahheD7kBAEPVuBI/GsABKgNdYUFNi
	 LZnTNHXPhf8a7rsXWVgvfhmWLlGRP5YenhbaQRlsW5hpC3mB3UOaN/gCwXXDwP+XK4
	 /8L0HM+9ovPxUiWKWhOJy1b851URODxuMwAtVcCuhJabbVZVH54k2AFEQK8h/seh7D
	 ZJ6G679yk6JHw==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream
 not declared
Date: Wed, 15 Feb 2023 13:28:51 +0000
Message-Id: <20230215132851.1626881-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WF3EGLLULY2SMCFBA6MOMLLLFKNSLKGA
X-Message-ID-Hash: WF3EGLLULY2SMCFBA6MOMLLLFKNSLKGA
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WF3EGLLULY2SMCFBA6MOMLLLFKNSLKGA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add struct snd_pcm_substream forward declaration

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
Changes since v1:
- Use forward declaration instead of header sound/pcm.h
---
 include/sound/soc-dapm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 77495e5988c1..64915ebd641e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -16,6 +16,7 @@
 #include <sound/asoc.h>
 
 struct device;
+struct snd_pcm_substream;
 struct snd_soc_pcm_runtime;
 struct soc_enum;
 
-- 
2.39.1

