Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF0DC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:50:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7CE6162A
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7CE6162A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A542216A0;
	Tue, 15 Jun 2021 17:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A542216A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623772243;
	bh=0AKQtTRFvAwNMONmcazVEqnc07a98wVeWAFq771hv1c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tyYmIjb9U7jphoPehoOtKtC/Li96yqpGwwYk/hpbA4xniHoI7Aatl7R41sGeuMxzd
	 AsNSmm2tajpHv1ytGoVRkWYCEXnsP4LCvNC/X4MuVt/UGWKmn6MDPVc9OFJXND5McK
	 OgFXsZnaSuf52e8GwxvYqGDocGGl/xI6MU9kp6CU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EAD2F804EB;
	Tue, 15 Jun 2021 17:48:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05A9BF804EC; Tue, 15 Jun 2021 17:48:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82966F804DF
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 17:48:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82966F804DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j27JiNCj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B1961627;
 Tue, 15 Jun 2021 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623772118;
 bh=0AKQtTRFvAwNMONmcazVEqnc07a98wVeWAFq771hv1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j27JiNCjEoJD2Wh32SyHmKwCjhTjjzsCpAzcEhCzvJs/SyYzxg2ljykoiiWdSL/x3
 i4k7gz8Q1j2nMtdloLPP0z/UNuuo6G7N/TQ+/R+FJQcwWnWzUacUdtdp9+oNAcM8aN
 jBVm9TftHrk4U2Ri0sL/DHfDsFMHwSbvb1bkpCy7AKE1T5viWhFkD2v+CaRQHNvp61
 DCHD8h43obyxWUQ6u8yaciVUlg0GtSm1bpjQqzs8FLdxWvaKFI5RIF2A2sEKMoNPmY
 QDnTB0ifccNRJAlU2LroFdt4xEm400TGn/9phE1/LiEkSfssjYF5NcpPW7i8tmlTsC
 9GwqBfFbEaG3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 11/33] ASoC: AMD Renoir - add DMI entry for
 Lenovo 2020 AMD platforms
Date: Tue, 15 Jun 2021 11:48:02 -0400
Message-Id: <20210615154824.62044-11-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615154824.62044-1-sashal@kernel.org>
References: <20210615154824.62044-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Mark Pearson <markpearson@lenovo.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Gabriel Craciunescu <nix.or.die@gmail.com>
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

From: Mark Pearson <markpearson@lenovo.com>

[ Upstream commit 19a0aa9b04c5ab9a063b6ceaf7211ee7d9a9d24d ]

More laptops identified where the AMD ACP bridge needs to be blocked
or the microphone will not work when connected to HDMI.

Use DMI to block the microphone PCM device for these platforms.

Suggested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Signed-off-by: Mark Pearson <markpearson@lenovo.com>
Link: https://lore.kernel.org/r/20210531145502.6079-1-markpearson@lenovo.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 050a61fe9693..47a4dfd81a46 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -199,6 +199,41 @@ static const struct dmi_system_id rn_acp_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "20NLCTO1WW"),
 		}
 	},
+	{
+		/* Lenovo ThinkPad P14s Gen 1 (20Y1) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20Y1"),
+		}
+	},
+	{
+		/* Lenovo ThinkPad T14s Gen1 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20UH"),
+		}
+	},
+	{
+		/* Lenovo ThinkPad T14s Gen1 Campus */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20UJ"),
+		}
+	},
+	{
+		/* Lenovo ThinkPad T14 Gen 1*/
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20UD"),
+		}
+	},
+	{
+		/* Lenovo ThinkPad X13 Gen 1*/
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20UF"),
+		}
+	},
 	{}
 };
 
-- 
2.30.2

