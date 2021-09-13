Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D03C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 02:12:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0677761056
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 02:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0677761056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6CCF1607;
	Mon, 13 Sep 2021 04:11:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6CCF1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631499120;
	bh=MIwpFqCdt+TJY8/YEL+u1sUpQDA4MMD7H+d+ZgSgen0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hh6Dxirka3J4NBxsqKtbnu7njC8cTlujnD/vfkdC+ttnqqNS8VlZcwE7B6K2kiqXr
	 0U1D3fSUam3RJQ/OwtoWgJMs4ibieFdJKI9gi99HSm+Nz8I1aK/SiLfl1YbDWN7BIp
	 VLH2kBbqK3nxuo7xqXTedCNzMsNIvGpA7yWEnxOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A8BCF80227;
	Mon, 13 Sep 2021 04:11:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5BFCF8027C; Mon, 13 Sep 2021 04:11:07 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A2FFF80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 04:10:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A2FFF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="k2LjFXWf"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="k4KMuzIf"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 508625C00E0;
 Sun, 12 Sep 2021 22:10:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 12 Sep 2021 22:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=AJ+ZuWAoL+cpgeBUsySm2RM0//
 lGaEV1A8DrAgj7olA=; b=k2LjFXWfJ53ysStcjpCSIeLf9FIc5spEeWrCg+ojNB
 TbjBPMdGZzBrFvLqNnEe96LalZYGTUkef0VnYKAAj+16+zEyMdAtu/1sGq9ncMDa
 8UFTP2odQTpQaPeJa372KrCmnfpp1DBsul6LDijVIBfGoIZy3gHrxtWGOrrzR5vn
 8KmvzT+IvB8RCycs722FMBNx3CGBYsTtiPTrrboe5+TlvI8sTtMbdevXPdPS8Zt4
 qWyQyegzdsUcnngnvbIlaCMy5bKO0tIsLrhJ/Np57zhBidK1xTkX9SI1hash4pOy
 6QJDCoTpx4ytsWAMz2uov9sFq9dpMVL+PZk3mzSzJpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AJ+ZuWAoL+cpgeBUs
 ySm2RM0//lGaEV1A8DrAgj7olA=; b=k4KMuzIfMId6IDqTHP5WyxrnaZrS6NrO+
 0Fm+4oEnBmUghGV0Xuhw0JaVxqPJq74TIRL2JziYdROLU4U81X+mxIIQrxiUqYco
 utNArm3BbqLhKb6TeiNGNDJgKMppLVlANToSl9qvBMOahy7nKlifdScSO76y1L9u
 +73dOfXP0cAWOXk+gEcgy+48nx3LW8HsfOrTU9mXFaC0v3LbT/D0uCzJrJicnRFV
 TQz9Jvl2LS2I1jEFMQafQjGdZ5x9OGZ2i+9TgNehUXEXWmgejb8KNZoQNj4fN+DY
 ttVFO3qaagH7qJ3akoYVTtE/MXSOIWL6MujG92w8h162soQD05UNQ==
X-ME-Sender: <xms:J7M-YRF9PnRQoWBJziJPMsQKy6a-Wcdxt9N7W4kcJf-E62e_psR90A>
 <xme:J7M-YWWimvRX7UrWNore4_GD7eYHydMKW_F-C9LS3Q4rxb4nnN9EAaNXnv3nN0PpR
 75iJjiRhb2bOhYynUs>
X-ME-Received: <xmr:J7M-YTI7OlZ-99kZcIfUaAapvzWEtDPAUFJ-HXxCdlgPTk10kMO03oHyYE9a_gGjT09pfHXDq4ezYZx5g0uqN1b0WYXjQB0uc5i1Uf--SHh5hr6pmcAx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegiedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecuvehluhhsthgvrhfu
 ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
 grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:J7M-YXGM9TpLUESim4BFkOLFnDHnwbLgd6oyev4cA0yK2dGggyKvAg>
 <xmx:J7M-YXUWKmkZwsP-3wnkmMR7Q8mhGA6c4Ny3jY7dxrErLktKx9z_qA>
 <xmx:J7M-YSNK20HC9rA-3NS2O8Zs0V62I4y3Fy9zyjoZJE_5ZFQn1A_0pA>
 <xmx:KLM-YedUjbKqZeqPhOOONF-qRrGnDMAv_BO74ETp1qk49VtXqScTWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Sep 2021 22:10:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: oxfw: fix transmission method for Loud models based on
 OXFW971
Date: Mon, 13 Sep 2021 11:10:42 +0900
Message-Id: <20210913021042.10085-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

Loud Technologies Mackie Onyx 1640i (former model) is identified as
the model which uses OXFW971. The analysis of packet dump shows that
it transfers events in blocking method of IEC 61883-6, however the
default behaviour of ALSA oxfw driver is for non-blocking method.

This commit adds code to detect it assuming that all of loud models
based on OXFW971 have such quirk. It brings no functional change
except for alignment rule of PCM buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index cb5b5e3a481b..daf731364695 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -184,13 +184,16 @@ static int detect_quirks(struct snd_oxfw *oxfw, const struct ieee1394_device_id
 			model = val;
 	}
 
-	/*
-	 * Mackie Onyx Satellite with base station has a quirk to report a wrong
-	 * value in 'dbs' field of CIP header against its format information.
-	 */
-	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
+	if (vendor == VENDOR_LOUD) {
+		// Mackie Onyx Satellite with base station has a quirk to report a wrong
+		// value in 'dbs' field of CIP header against its format information.
 		oxfw->quirks |= SND_OXFW_QUIRK_WRONG_DBS;
 
+		// OXFW971-based models may transfer events by blocking method.
+		if (!(oxfw->quirks & SND_OXFW_QUIRK_JUMBO_PAYLOAD))
+			oxfw->quirks |= SND_OXFW_QUIRK_BLOCKING_TRANSMISSION;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

