Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8495C3DA6F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 21:14:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1B9F84A;
	Thu, 24 Aug 2023 23:13:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1B9F84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692911667;
	bh=vsZjxZKBlZMhSRXOzu8mrKyj1JWGYCHbK5x56y67Cfs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sMVyZpAkwHlGJVEOAvwDN/7U81sVf7OqmgKj2vry9XrkRHmEk4173g/eJx27KLSED
	 eX3Hgo/87IQoMUEA83T1Aw6A2u+PJvtCN3NGbJmDEahDQqFnKpISwIwZEeFIuJSrm0
	 6EUtaBlWUGtkzwKQr6KAuJRTnOLS1QzY0Z03WlNI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03962F80536; Thu, 24 Aug 2023 23:12:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6394DF80074;
	Thu, 24 Aug 2023 23:12:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B3E2F8023B; Thu, 24 Aug 2023 23:12:55 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57037F80074
	for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2023 23:12:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57037F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=L1LD/DDb
Received: from localhost (unknown [81.18.92.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 26DD86607273;
	Thu, 24 Aug 2023 22:12:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1692911565;
	bh=vsZjxZKBlZMhSRXOzu8mrKyj1JWGYCHbK5x56y67Cfs=;
	h=From:To:Cc:Subject:Date:From;
	b=L1LD/DDbOrhOTCIHAKxqBxFTDbW/OGSM0zjW6EDa8awd8bkd6e55N/MTzE3zdswne
	 1X7aki+O65K8/+ncgFeuJQNcBPG5IJaISLcO321nUB/GoS3nxrrUdS7m4+htmMsM0N
	 sCeEHuVDk/K56MaTi98WE/snahRPZgPQGYZxzUVAHQrkg4TrNvhcdpcqLBy6KZ5bF7
	 On6eNcBcsR3OifvT4kL7WfFJFerMTkbe0r9+EQfrnTQWLZP5pzH/bcEPMiyT9K9lVa
	 8OB5YycrKji92VRdJBlP7vCEKleAxVh7m/wraKTLRVvvh3Q+K7xfYphQ5IobfV51Ls
	 bCiwyXmoitIWg==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] A couple of ASoC core fixes
Date: Fri, 25 Aug 2023 00:12:39 +0300
Message-ID: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6NEXLORJY5ZSSZSLEBOPPEMXE4L2SM55
X-Message-ID-Hash: 6NEXLORJY5ZSSZSLEBOPPEMXE4L2SM55
X-MailFrom: cristian.ciocaltea@collabora.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6NEXLORJY5ZSSZSLEBOPPEMXE4L2SM55/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is just a split version of the initial patch [1], as requested by Mark.

[1] https://lore.kernel.org/all/20230824193837.369761-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  ASoC: core: Do not error if a DAI link component is not found
  ASoC: core: Rename component_not_find label

 sound/soc/soc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0

