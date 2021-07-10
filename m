Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1AC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:55:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF7F613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF7F613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5497C17B9;
	Sat, 10 Jul 2021 04:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5497C17B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885725;
	bh=ZooaiZP7gBJNc5eCoLevqjyTXnHImwqSvzTDDGcJCE0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rh14j53ptS823VyODcRd3nLguK7c4F1DHvodTvsFpHBDONJOsp2zN4EabAP9v16Ft
	 NpXp8Tz73hwmcsITX6hW6tMpl+Z164BuKu3/XJ7FA2DkOvswPGAXVntsBM5HEjSpGR
	 HkOhAa9vIub4fKaIBDfNViUjtPy1C+29zNYYaKA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCC29F804E4;
	Sat, 10 Jul 2021 04:39:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6033F80566; Sat, 10 Jul 2021 04:39:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D56EF8055B
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D56EF8055B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WcBfs9zi"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0143D613CC;
 Sat, 10 Jul 2021 02:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884756;
 bh=ZooaiZP7gBJNc5eCoLevqjyTXnHImwqSvzTDDGcJCE0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WcBfs9zi0QkVhJ00Y4by/t2kON582TWuLf9Kzrfu2YKNXVd3VhgEyX4c8wFNmbdvZ
 XnSEuXTQweej24lFth3sd7boC3kF81d9XY5dpPNgGiUdSZQKdJhFuEeZhKwsGwtHlz
 cs+WT5QBNDohukdaG+eLhNXvNd8thqMzWPq0SU02jerEcCmmbuidD1EiAjv/3CsjIv
 lP+GhajqUENquIqTn6/Hc9GOS1vrWaXfbhtV1/4g8NN+v5KEJtC/RfLkItBrjCR5ii
 M7mzs3tUHL+LLqW0TEJOEdJwXRB85/A7LS8ehtoW1KmO4Bp4oCgsK3ujPxHkkcR+PT
 ziUbk7wa4avEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/23] Revert "ALSA: bebob/oxfw: fix Kconfig entry
 for Mackie d.2 Pro"
Date: Fri,  9 Jul 2021 22:38:52 -0400
Message-Id: <20210710023912.3172972-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023912.3172972-1-sashal@kernel.org>
References: <20210710023912.3172972-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 5d6fb80a142b5994355ce675c517baba6089d199 ]

This reverts commit 0edabdfe89581669609eaac5f6a8d0ae6fe95e7f.

I've explained that optional FireWire card for d.2 is also built-in to
d.2 Pro, however it's wrong. The optional card uses DM1000 ASIC and has
'Mackie DJ Mixer' in its model name of configuration ROM. On the other
hand, built-in FireWire card for d.2 Pro and d.4 Pro uses OXFW971 ASIC
and has 'd.Pro' in its model name according to manuals and user
experiences. The former card is not the card for d.2 Pro. They are similar
in appearance but different internally.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20210518084557.102681-2-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/Kconfig       | 4 ++--
 sound/firewire/bebob/bebob.c | 2 +-
 sound/firewire/oxfw/oxfw.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index fdc01466d143..4199cfc4a96a 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -36,7 +36,7 @@ config SND_OXFW
 	   * Mackie(Loud) Onyx-i series (former models)
 	   * Mackie(Loud) Onyx Satellite
 	   * Mackie(Loud) Tapco Link.Firewire
-	   * Mackie(Loud) d.4 pro
+	   * Mackie(Loud) d.2 pro/d.4 pro (built-in FireWire card with OXFW971 ASIC)
 	   * Mackie(Loud) U.420/U.420d
 	   * TASCAM FireOne
 
@@ -91,7 +91,7 @@ config SND_BEBOB
 	  * PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
 	  * BridgeCo RDAudio1/Audio5
 	  * Mackie Onyx 1220/1620/1640 (FireWire I/O Card)
-	  * Mackie d.2 (FireWire Option) and d.2 Pro
+	  * Mackie d.2 (optional FireWire card with DM1000 ASIC)
 	  * Stanton FinalScratch 2 (ScratchAmp)
 	  * Tascam IF-FW/DM
 	  * Behringer XENIX UFX 1204/1604
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 088250ff2429..64dca7931272 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -362,7 +362,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049, &spec_normal),
 	/* Mackie, Onyx 1220/1620/1640 (Firewire I/O Card) */
 	SND_BEBOB_DEV_ENTRY(VEN_MACKIE2, 0x00010065, &spec_normal),
-	// Mackie, d.2 (Firewire option card) and d.2 Pro (the card is built-in).
+	// Mackie, d.2 (optional Firewire card with DM1000).
 	SND_BEBOB_DEV_ENTRY(VEN_MACKIE1, 0x00010067, &spec_normal),
 	/* Stanton, ScratchAmp */
 	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001, &spec_normal),
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 2d310bf2f2b2..c700e11ab327 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -320,7 +320,7 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	 *  Onyx-i series (former models):	0x081216
 	 *  Mackie Onyx Satellite:		0x00200f
 	 *  Tapco LINK.firewire 4x6:		0x000460
-	 *  d.4 pro:				Unknown
+	 *  d.2 pro/d.4 pro (built-in card):	Unknown
 	 *  U.420:				Unknown
 	 *  U.420d:				Unknown
 	 */
-- 
2.30.2

