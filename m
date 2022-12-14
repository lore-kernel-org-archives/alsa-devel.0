Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E8AC46467
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 12:39:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 682081924;
	Wed, 14 Dec 2022 13:38:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 682081924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671021539;
	bh=fbFXGz79MCEo2V9LMATGuO+NTZZ3WufEy7jSR3uq9oE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=QGgY5Avq7TFQPuimf0Wdzx5KMt0kBCZaOmhQ6QlhFkhzMPHq8TUYBvrYUWI0Hntcv
	 29AYi6Ue2gosf/J6YucdgImK0/kL8zmhwFDYLE6/pKd8vqhislTVGHcnQovZ7E3qCL
	 FrnCP5pMijuVBsIESklkx9gdSnN24mlRlVGiFUyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E481F804F1;
	Wed, 14 Dec 2022 13:38:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB8F8F804F1; Wed, 14 Dec 2022 13:38:07 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4504EF80141
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 13:38:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4504EF80141
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=jdIEWdti
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A2FE385163;
 Wed, 14 Dec 2022 13:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1671021485;
 bh=aZYpr7PdIIEjRHAo8aMLeYDllEQgPdCTCsRbDEX5RrE=;
 h=From:To:Cc:Subject:Date:From;
 b=jdIEWdtiQi/UuZ1yVszQKCK5h9Qg9GUZVF38U3I9a3Y2XQtr8QLlbCLiWSm3BV7nP
 oCLOl76rJzoC4jAo2eiOWGonPPRp/+u4cRqYV6D/Zj8+4BAcz+bdkaNYEMFfw7mL3M
 0B9UT3uoY7CNfS4fVcYe2xl1UIQuBmNxgtj8taM5JVLyfLCFqsDt0Ion9Lv5KdtttP
 nXkuWEjl7o1znyRvKvE99vnqL1qkcGKW8rtIVloAsqlb+/GeWTRggWME2od6R3dWwh
 V3jPF1jmnWAk9c5oKacT8lBUA6i/TvotzFP+kVuzWidgA8Kzk3DQy7EA/coXcsumdH
 X0xb4RA0rrVpg==
From: Lukasz Majewski <lukma@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/4] ASoC: Fixes for WM8940 codec
Date: Wed, 14 Dec 2022 13:37:39 +0100
Message-Id: <20221214123743.3713843-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch series provides fixes for WM8940 codec.

The most notable change is the clock rewrite, so this driver now
can either generate proper clock frequency by itself or use one
provided from the clock subsystem of the SoC.

Lukasz Majewski (4):
  ASoC: wm8940: Remove warning when no plat data present
  ASoC: wm8940: Rewrite code to set proper clocks
  ASoC: wm8940: Mute also the speaker output
  ASoC: wm8940: Read chip ID when wm8940 codec probing

 sound/soc/codecs/wm8940.c | 129 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wm8940.h |   6 ++
 2 files changed, 111 insertions(+), 24 deletions(-)

-- 
2.20.1

