Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680FCC636CC
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Feb 2023 23:33:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CCA31E1;
	Wed,  8 Feb 2023 00:32:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CCA31E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675812825;
	bh=31IOxFAe/uIvuzK/A+EiEaSGYIq/CqYNbT9qcYN/ap0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SiOOigbYNzRVJoXoPT5e367lYMTe44OTHgYVzsuiwLKg2oBKx1IkL4AfetjCX5IS4
	 sY8AVk0pXleCbnn4KPPoFubvMj49F2dPJrf4+BM35htm9RSwJUwWodXSdTfjVS72BK
	 0JSUNhRS+RcKP/8je2/H3nwc32jbAlBSAfZiCrzM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53C9AF80549;
	Wed,  8 Feb 2023 00:31:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 364D1F8051E; Wed,  8 Feb 2023 00:31:40 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9E0CF80095
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2023 00:31:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9E0CF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=WJexhMKV
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 691776602083;
	Tue,  7 Feb 2023 16:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1675787137;
	bh=31IOxFAe/uIvuzK/A+EiEaSGYIq/CqYNbT9qcYN/ap0=;
	h=From:To:Cc:Subject:Date:From;
	b=WJexhMKVMZ42nwHjTQdqi004u44KDYcawU/7IqdygN4EMpd5qH5ZvSJPPT0R5RdQv
	 9sPMvgY6ElcZ5bhQX1PHm4bo9A3J3j8xzgDc8R3q+x6CsbKvFxS+SuWFfumO8zXHkb
	 tHcn+/sLVJ/bngvCdxCf6rUk9c/oeNIv0qdUBybgAdo708mZt9HaaNnlsqeQiFLHeW
	 FlOU/Wr+ygpAuejKCE7hFspSAyXjXiKcZmNgTH58XCb80ZJDF5I7ONjBRT2g4vdZ/B
	 kIZr0HypTv2zVl4G4qf3pyk7y1zVkdtgLjNDIpgP3xrWIcVaTAJWXAcIgE9voyfSkX
	 pjmS8p1Y9pdDA==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 0/5] Add CS35L41 shared boost feature
Date: Tue,  7 Feb 2023 16:25:21 +0000
Message-Id: <20230207162526.1024286-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AQ7HZBSQNJ4CZQA4Y7VC6XIY2JFEOL3G
X-Message-ID-Hash: AQ7HZBSQNJ4CZQA4Y7VC6XIY2JFEOL3G
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AQ7HZBSQNJ4CZQA4Y7VC6XIY2JFEOL3G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Valve's Steam Deck uses CS35L41 in shared boost mode,
where both speakers share the boost circuit.
Add this support in the shared lib, but for now,
shared boost is not supported in HDA systems as
would require BIOS changes.
Based on David Rhodes shared boost patches.

Also, fix boost config overwriting in IRQ found
in the review and do a small refactor of the code.

Changes from V1:
 - Fix Documentation patch subject
 - New patch for External boost without VSPK Documentation
 - New patch to fix boost IRQ overwriting issue
 - New patch to refactor IRQ release error code
 - reinit_completion on pcm_startup
 - fix DRE switch overwriting
 - return IRQ_HANDLED in PLL_LOCK case

Lucas Tanure (5):
  ASoC: cs35l41: Only disable internal boost
  ASoC: cs35l41: Refactor error release code
  ALSA: cs35l41: Add shared boost feature
  ASoC: cs35l41: Document CS35l41 external boost without VSPK
  ASoC: cs35l41: Document CS35l41 shared boost

 .../bindings/sound/cirrus,cs35l41.yaml        |  12 +-
 include/sound/cs35l41.h                       |  10 +-
 sound/pci/hda/cs35l41_hda.c                   |   6 +-
 sound/soc/codecs/cs35l41-lib.c                |  56 +++++++-
 sound/soc/codecs/cs35l41.c                    | 125 +++++++++---------
 sound/soc/codecs/cs35l41.h                    |   1 +
 6 files changed, 139 insertions(+), 71 deletions(-)

-- 
2.39.1

