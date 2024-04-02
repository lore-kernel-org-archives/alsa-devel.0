Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD33CD11C2
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Apr 2024 07:20:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F3E52BA7;
	Sun,  7 Apr 2024 09:20:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F3E52BA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712474447;
	bh=raqZRXpSAUQKXil8z5AtZK8I91UM9WjPAbTjuIxfsT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S8GV3BfZvpkeirRgvws5qU97MTr4WCIFn0ftAmkOly+HP5oTmvICqJyw0W6BpnJwG
	 IIqtNboCBv7xZNjO9supRlctrXFSdTARWTl0kruugj5t4Ci5/uI7fr7eAIZzMC1vlh
	 hcp/4qMhvq1g8uPkz+wmJmCykCEDya+yPvoHhDNg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71D36F8076A; Sun,  7 Apr 2024 09:17:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BEEEF80760;
	Sun,  7 Apr 2024 09:17:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E11B8F8057A; Tue,  2 Apr 2024 09:13:04 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5EEA0F80587
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 09:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EEA0F80587
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=TyJGS7gJ
Received: by mail.gandi.net (Postfix) with ESMTPA id 61BB1FF804;
	Tue,  2 Apr 2024 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryoqfTLjKn66TnerPCn7gg2/Qxg9JuXh/P0bs+WVTIc=;
	b=TyJGS7gJDTLORWyHUtik2qmgLQWu+1QobOj/bZ5fKukP7/xQkT/y7Li1gBUe9ykjzhBrof
	KvQqwPNmN8Y9cp60ztHZ9N1u5JiWbBgN5oQja5XKgv00D9eaytCihDmi4C3W0Fcvsl23Fz
	lPzMRoPKJuTsnAsGn87OX+Eb3ifq252qOl6QdrykwSYhbH6rfEDCbqj1aSGNMdAMdPcUKx
	MamDCqbugQImrX1SZIIkvqGijCUmYONdL7vrhpTQiCd+DyEYMKQgdnTyACA0QCKjShRgmE
	Oz7VXxpiGajXIq9uNf4iYAYO92EsuWb9DYst/t0FdJiM8ttu/4vHYGLkNgSKbg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 10/13] ASoC: ti: davinci-i2s: Link free-run mode to
 SND_SOC_DAIFMT_[GATED/CONT]
Date: Tue,  2 Apr 2024 09:12:10 +0200
Message-ID: <20240402071213.11671-11-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-MailFrom: bastien.curutchet@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XLSW3NKSESN6LMO7DAM2CMTQZYHKO66Q
X-Message-ID-Hash: XLSW3NKSESN6LMO7DAM2CMTQZYHKO66Q
X-Mailman-Approved-At: Sun, 07 Apr 2024 07:14:48 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XLSW3NKSESN6LMO7DAM2CMTQZYHKO66Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

McBSP has free-running mode where serial clocks continue to run during
emulation halts. This mode is always enabled by the driver.

Set free-running mode when SND_SOC_DAIFMT_CONT is selected by DAI
format, unset it when SND_SOC_DAIFMT_GATED is selected.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 82a0dfa07cec..7fb41987175b 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -280,6 +280,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int pcr;
+	unsigned int spcr;
 	unsigned int srgr;
 	bool inv_fs = false;
 	/* Attention srgr is updated by hw_params! */
@@ -288,6 +289,23 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
 
 	dev->fmt = fmt;
+
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT:
+		spcr |= DAVINCI_MCBSP_SPCR_FREE;
+		dev_dbg(dev->dev, "Free-running mode ON\n");
+		break;
+	case SND_SOC_DAIFMT_GATED:
+		spcr &= ~DAVINCI_MCBSP_SPCR_FREE;
+		dev_dbg(dev->dev, "Free-running mode OFF\n");
+		break;
+	default:
+		dev_err(dev->dev, "Invalid clock gating\n");
+		return -EINVAL;
+	}
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -452,10 +470,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	} else {
-		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
-- 
2.44.0

