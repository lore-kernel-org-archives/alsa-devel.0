Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B4C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 23:26:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35CAD18DD;
	Fri, 26 Nov 2021 00:25:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35CAD18DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637882809;
	bh=Hu4VT6pQTRz1kDWfdBUOllKsCNvq5ZBb6BYmfid0H04=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LupR5fnKhniJ2J2LHRtqxOGyck8bxgxZu/hoE6MaJHE6f/j/mKSFzhyG/myfjyy9y
	 ITc2NVsKnXaq9pid/qQ/mqlwvIPl0lq4HB3Rf1sGNe+LxFY0BP6mwet93ebjFhIKfN
	 V6qrqEOhdhYRkC09ty73fh7XQ8VCkKHi/4qdoJb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1FA8F80430;
	Fri, 26 Nov 2021 00:25:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 029E4F8049E; Fri, 26 Nov 2021 00:25:56 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34094F8007E
 for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2021 00:25:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34094F8007E
From: Paul Cercueil <paul@crapouillou.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: codecs/jz4770: Add missing gain control after DAC/ADC
 mixer
Date: Thu, 25 Nov 2021 23:25:43 +0000
Message-Id: <20211125232543.117074-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org,
 list@opendingux.net, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
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

The capture and playback paths both have a configurable gain after their
respective mixer, which can be set from -31 dB to 0 dB in 32 steps.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 6b60120f59a6..1d0c467ab57b 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -307,6 +307,7 @@ static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
 static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
+static const DECLARE_TLV_DB_MINMAX(mixer_tlv, -3100, 0);
 
 /* Unconditional controls. */
 static const struct snd_kcontrol_new jz4770_codec_snd_controls[] = {
@@ -319,6 +320,14 @@ static const struct snd_kcontrol_new jz4770_codec_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Line In Bypass Playback Volume",
 			 JZ4770_CODEC_REG_GCR_LIBYL, JZ4770_CODEC_REG_GCR_LIBYR,
 			 REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, linein_tlv),
+
+	SOC_SINGLE_TLV("Mixer Capture Volume",
+		       JZ4770_CODEC_REG_GCR_MIXADC,
+		       REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, mixer_tlv),
+
+	SOC_SINGLE_TLV("Mixer Playback Volume",
+		       JZ4770_CODEC_REG_GCR_MIXDAC,
+		       REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, mixer_tlv),
 };
 
 static const struct snd_kcontrol_new jz4770_codec_pcm_playback_controls[] = {
-- 
2.33.0

