Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B2C47253
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4B424953
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NwBVj9KA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSoJaBgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4B424953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F65B16A6;
	Thu, 30 Apr 2020 15:59:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F65B16A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588255249;
	bh=MPyBt+js+ZFj7/UkvTMgEb63O/0/GYa3hNOG0libZHE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwBVj9KAKyPpWi4ZeQ8OOblrBLCfJurU6pANoHMZmh0XsunFrFLB+915Dwm7GVn/r
	 2rgzmjKAfy2BS4Gml6rpZxs4vg9+QNf4zqt59lxyAyYavYMiPSoE9xjHe6gTX4JxsV
	 WCqU0F488o+GtzlnNUdvDb8Tqid3qpzIXpbGNNYg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CDBCF80337;
	Thu, 30 Apr 2020 15:51:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8798AF80334; Thu, 30 Apr 2020 15:51:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE6ACF8032A
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:51:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE6ACF8032A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cSoJaBgy"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB0A824959;
 Thu, 30 Apr 2020 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254696;
 bh=MPyBt+js+ZFj7/UkvTMgEb63O/0/GYa3hNOG0libZHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cSoJaBgyuKYwHRQS974aKdgIks3CKwh04cDs6HOJOLOdXT3ZJ6DmtJqT1RZ1nyHV3
 +gCrH+DMZfoDZak2NcQdwE+rHXKGrdFWHefQUVxvQErQEqiN/aRHu0CjuR4Xz8kO95
 iX6JkZfP4sLs/9k19VtdnvsB40BOyBnKPNXoB2Zs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 46/79] ASoC: rsnd: Don't treat master SSI in multi
 SSI setup as parent
Date: Thu, 30 Apr 2020 09:50:10 -0400
Message-Id: <20200430135043.19851-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Matthias Blankertz <matthias.blankertz@cetitec.com>,
 Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

From: Matthias Blankertz <matthias.blankertz@cetitec.com>

[ Upstream commit 0c258657ddfe81b4fc0183378d800c97ba0b7cdd ]

The master SSI of a multi-SSI setup was attached both to the
RSND_MOD_SSI slot and the RSND_MOD_SSIP slot of the rsnd_dai_stream.
This is not correct wrt. the meaning of being "parent" in the rest of
the SSI code, where it seems to indicate an SSI that provides clock and
word sync but is not transmitting/receiving audio data.

Not treating the multi-SSI master as parent allows removal of various
special cases to the rsnd_ssi_is_parent conditions introduced in commit
a09fb3f28a60 ("ASoC: rsnd: Fix parent SSI start/stop in multi-SSI mode").
It also fixes the issue that operations performed via rsnd_dai_call()
were performed twice for the master SSI. This caused some "status check
failed" spam when stopping a multi-SSI stream as the driver attempted to
stop the master SSI twice.

Signed-off-by: Matthias Blankertz <matthias.blankertz@cetitec.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20200417153017.1744454-2-matthias.blankertz@cetitec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index d51fb3a394486..9900a4f6f4e53 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -407,7 +407,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	 * We shouldn't exchange SWSP after running.
 	 * This means, parent needs to care it.
 	 */
-	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
+	if (rsnd_ssi_is_parent(mod, io))
 		goto init_end;
 
 	if (rsnd_io_is_play(io))
@@ -559,7 +559,7 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 	 * EN is for data output.
 	 * SSI parent EN is not needed.
 	 */
-	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
+	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
 	ssi->cr_en = EN;
@@ -582,7 +582,7 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
-	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
+	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
 	cr  =	ssi->cr_own	|
@@ -620,7 +620,7 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
+	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
 	if (!rsnd_ssi_is_run_mods(mod, io))
@@ -737,6 +737,9 @@ static void rsnd_ssi_parent_attach(struct rsnd_mod *mod,
 	if (!rsnd_rdai_is_clk_master(rdai))
 		return;
 
+	if (rsnd_ssi_is_multi_slave(mod, io))
+		return;
+
 	switch (rsnd_mod_id(mod)) {
 	case 1:
 	case 2:
-- 
2.20.1

