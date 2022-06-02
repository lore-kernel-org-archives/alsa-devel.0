Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA2DC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 13:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73A8817AA;
	Thu,  2 Jun 2022 15:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73A8817AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654178154;
	bh=Ri2UCYgxRMTklRg+xVI6zTk4ef+4/+SeBSaDiHxSok0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rSXBqH7Z7oElYliIp8KMq9zCjSBj4ZMcKMJYnHcCAm4GayhwvqczkT13Ane9tWato
	 NPLPFT7VzBrHhnA3hu2jGo8/g/JY+cm0UryVMl7wWOhzGBEu6rFnuBuxHHsv+ro2LS
	 UyJ9pPoy2h9WJoPVZiqmADZEpKwWkkjyP6UI9UCY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 978F4F8053E;
	Thu,  2 Jun 2022 15:53:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17B0F80538; Thu,  2 Jun 2022 15:53:33 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DE5FF80089
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 15:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DE5FF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Aa6jzAyu"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 96EDBB81ED6;
 Thu,  2 Jun 2022 13:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCB5C3411F;
 Thu,  2 Jun 2022 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654178009;
 bh=Ri2UCYgxRMTklRg+xVI6zTk4ef+4/+SeBSaDiHxSok0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Aa6jzAyuurtaZ6r9mZ2cajhyM9pZ7bCiCwFiFxYuzmdO1zSVPzwUIDeW00+uEAvGq
 lhTCmHIr7Na3XFf5DMrD3I9gAPmFC8J0KQu67j1aa3cwdBrEdKyLePI9mTyQT2Rjqb
 QjjWSKgjV4jOf6tPym1MnabcB7frG/5MYkN414+4ehOgOJjDr25WvFW6NoUTAO0Lkk
 C88rvt7Keq+kZKDkORq7vkqPIhwwY71h8BM2AyhNaCbrYkQp0VVGAhoF/NdUKLwt5g
 Qr55Pg9mQAbs0JKKCUTelmj76JXFimXMAhhO0spPYbcvbtsmLLUhUov4zWs8pn1Puj
 SRp1qhkFhdzAw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 06/20] ASoC: sti-sas: Use modern ASoC DAI format terminology
Date: Thu,  2 Jun 2022 15:53:02 +0200
Message-Id: <20220602135316.3554400-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602135316.3554400-1-broonie@kernel.org>
References: <20220602135316.3554400-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; h=from:subject;
 bh=Ri2UCYgxRMTklRg+xVI6zTk4ef+4/+SeBSaDiHxSok0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBimMCTOCckEoTaGdO/lysCFX3L6zBZxH3kC1DbGdTs
 urk25QyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYpjAkwAKCRAk1otyXVSH0BDEB/
 43fcfz+gp9Kc5IN94SvBp4rDCEdMIADX8fY+fuJE1wYY7CJdR4C/o5iQ1j6iZhM4E/w5Eqosn1OAd6
 ZNi/uKXhKE3HLVszs8xVKgi7w3LZXtNEcqy1Gnj2iaPOID8d9tZo2s4Md+8hCL89XLtsOgXFRiew37
 CqvKJEewbZI7Emiz1zhGNdMOP20mv8ID7GjodLOVqC9wIB2rmWRvS+NoezRoTR9AE8qyFh3zZEXj3l
 u5zcdruy9MKBUjQlbBjModP42DX8yQIqwCbmAupNS2t7+O2tm64esyyeh4ORVZHgmpz3bsejR/he6r
 yb3HzrWVRQTN9mjaQ5BK/LXcuADehQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

As part of moving to remove the old style defines for the bus clocks update
the sti-sas driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 3be4940e3c77..10a6a112f4b4 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -199,10 +199,10 @@ static int stih407_sas_dac_mute(struct snd_soc_dai *dai, int mute, int stream)
 static int sti_sas_spdif_set_fmt(struct snd_soc_dai *dai,
 				 unsigned int fmt)
 {
-	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+	if ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_CBC_CFC) {
 		dev_err(dai->component->dev,
-			"%s: ERROR: Unsupporter master mask 0x%x\n",
-			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+			"%s: ERROR: Unsupported clocking mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK);
 		return -EINVAL;
 	}
 
-- 
2.30.2

