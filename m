Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C2C3DA7D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 13:48:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1888F10EF0;
	Thu,  5 Jan 2023 14:47:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1888F10EF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672926495;
	bh=q5fQna0b2+wUwPltDmolUYGF06HuBjRD0D0iAWYomeI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=I8zyjvGcjaXJabsBq2dYyZhaMekKiqLHTR4ZxowA3qktpXHWyxvLJqNGlX2a0CBYE
	 7CfU8aD1M/eOtGiOW1OA5GM1cdyD8yPZD/skU0uYDlQDrUc93lljYw2HGbiUNM0Jcu
	 JmcTskDN9YNM0okB70e3Pna14a3Q64QWe6Jstmgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C41EFF8047B;
	Thu,  5 Jan 2023 14:47:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9BA3F8022B; Thu,  5 Jan 2023 14:47:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DD76F8022B
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 14:47:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DD76F8022B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OP6AjCLp
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADCC61A8D;
 Thu,  5 Jan 2023 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CDC433EF;
 Thu,  5 Jan 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672926438;
 bh=q5fQna0b2+wUwPltDmolUYGF06HuBjRD0D0iAWYomeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OP6AjCLpRBdGcAkjcJuoGvOwpNugnKKQFzn0iNMsnw2NzypoLleV9nENGgeSe29E0
 v0YprYjXsoOHTxZC0shUxalBcXBvaQWxRp3CbtpycvQwoEGCXGZcCwaqpg3zJcBh7M
 JFQC7LMBW5LFEhwt7EE9Yrql7Rz/EaEJY7TTcnhcZnRU7piNOH2twIQywYBkH3snhB
 rQ4KvNMQAMe8Hasyxo4JyuKKI3rSIHnfs9eZkXQtFFymdC7uZDuZDTCG+XQK5WmfC8
 kMiPrPn5+URPRVOTqBkigc6R1jUHUChA5GFKm4RsYhCH8SOn6ONFTOS5FOQ77utabk
 34B2mrnox9Q6w==
From: Arnd Bergmann <arnd@kernel.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 14/27] ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable
Date: Thu,  5 Jan 2023 14:46:09 +0100
Message-Id: <20230105134622.254560-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Arnd Bergmann <arnd@arndb.de>

When building a PXA kernel without legacy board file support,
the AC97 code is not built, so none of the AC97 drivers
can be used.

Add a Kconfig prompt to let users turn it on, and have it
enabled by default.

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a045693d5bc2..2036d368c08d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -16,7 +16,10 @@ config SND_PXA2XX_AC97
 	tristate
 
 config SND_PXA2XX_SOC_AC97
-	tristate
+	tristate "SoC AC97 support for PXA2xx"
+	depends on SND_PXA2XX_SOC
+	depends on AC97_BUS=n
+	default y
 	select AC97_BUS_NEW
 	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
-- 
2.39.0

