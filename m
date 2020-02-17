Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69129C3B1BF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:29:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E918C2086A
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JuxAbbfP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hoqWU1mu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJW1BZoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E918C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53DB2169F;
	Mon, 17 Feb 2020 03:28:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53DB2169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581906552;
	bh=C+XOYSR2CX294AzmYx5M/2RpBhyqgfM9Nan179y8nkU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuxAbbfPwfYg0AkYF2GX02sBIiTsTGGcNSF0OTH1X9ELz30XzDjFiG/jo17Rn7GUS
	 /GAIzQ8+GnOeUZRLjlP7EPMt8qnj4e5oekV2U/82HqaiAxvouXvAAaNdOzfwqSaPkS
	 RsOoIiRp8dHRZaT9XeMnMluLaRU75GhepCBQFnoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC634F8033E;
	Mon, 17 Feb 2020 03:18:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45571F80336; Mon, 17 Feb 2020 03:18:31 +0100 (CET)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B798F8027C
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 03:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B798F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="hoqWU1mu"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="EJW1BZoO"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 988936D76;
 Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=rZE5jshbl3oVN
 3i0+/l30LzdznQBowgsQ8ja5ppeVIc=; b=hoqWU1muNZelcwgOlCbeT9L4n5rCR
 Ohn1r90wQHvmG4wDlzgpczd0md0Pwm9dHAPiQV2BuD0SiycaA413v+HO3QKSqAKy
 hlTYHE+m2O6GBxKNOEYQr251XqvKer1UHiv03MpnHKrK4CnGrOSnKTyuBr/lZmRV
 nPpOdauXzU/sh8fmFnnHSqLR1OmhhDMlPs/p7n8UjbhVQU3gsjJasTrdruVgxEDd
 ajCxtbww+OQXWwa0XiTln0wMjQMo1f5aIgvj7cksVGfej7WjT6ZW/nd7IUhSAiEF
 rk4CBlitRt8AoMBDWs1jlEeENppd/4x/toflXgpc9I59jI3dlJh3oCjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=rZE5jshbl3oVN3i0+/l30LzdznQBowgsQ8ja5ppeVIc=; b=EJW1BZoO
 h6QEndVtxj+KipqxkP5LB2i+xZXU+csYOMU7pLw4gWR6y2qCQnaMo02MHh4a35Xx
 VJEZ2TmTQnkvBcI4APVJRdlAyYOkHZrhUWM9nRi6d+R3nKSVt3gjfoAII49oooxB
 yO9Ag4N72/N18llH+eDZBrsxPcDDWurQ712XV+vTGQsRPP/FaSJUU3i1G/APX4np
 wgzMDCRtNyyJIPqpCnfz91MMQVj1zVM60o+H8gULcs5TjpY5ysre9iOkV/AHkStk
 FqEMw8PiAzMKycsTQzwubQSfUpae05WNEVc0bc9CoUnAixRLTMGAAoUMK1aYWZEE
 LMmqI7v85YKh2A==
X-ME-Sender: <xms:6vdJXtHTavFPOASuajjgaeRzrmiPyVksByFLs3BLSWfEM-5qfr1pkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6vdJXj4zJHrwOcMTT9QfePBqGmtiI8bYduxZJX7O1libaHFgk7zS-A>
 <xmx:6vdJXuYbJs8SoOA6Hr9_NJChDEJ_ewwTb-ipByL5u9agWLeS3bJo-A>
 <xmx:6vdJXphWUccKgvbt3VlAQfzNK0xJnAxsTNfpLsEDzfv84Xv3vuAnUQ>
 <xmx:6_dJXowvWCjWFhD4mWQWfWL_iRpqfjXm5T86dNUGM9pa0U-ftZK7SQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2B0FC3060FE0;
 Sun, 16 Feb 2020 21:18:18 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 16 Feb 2020 20:18:13 -0600
Message-Id: <20200217021813.53266-9-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Samuel Holland <samuel@sholland.org>
Subject: [alsa-devel] [PATCH 8/8] ASoC: sun50i-codec-analog: Enable DAPM for
	earpiece switch
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

By including the earpiece mute switch in the DAPM graph, both the
earpiece amplifier and the Mixer/DAC inputs can be powered off when
the earpiece is muted.

The mute switch is between the source selection and the amplifier,
as per the diagram in the SoC manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 84bb76cad74f..6c89b0716bbd 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -232,11 +232,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		       SUN50I_ADDA_EARPIECE_CTRL1,
 		       SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
 		       sun50i_codec_earpiece_vol_scale),
-
-	SOC_SINGLE("Earpiece Playback Switch",
-		   SUN50I_ADDA_EARPIECE_CTRL1,
-		   SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
-
 };
 
 static const char * const sun50i_codec_hp_src_enum_text[] = {
@@ -295,6 +290,11 @@ static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
 		      sun50i_codec_earpiece_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_earpiece_switch =
+	SOC_DAPM_SINGLE("Playback Switch",
+			SUN50I_ADDA_EARPIECE_CTRL1,
+			SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0);
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -341,6 +341,8 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 
 	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
+	SND_SOC_DAPM_SWITCH("Earpiece",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_earpiece_switch),
 	SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
 			     SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
@@ -462,7 +464,8 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Earpiece Source Playback Route", "DACR", "Right DAC" },
 	{ "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
 	{ "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
-	{ "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
+	{ "Earpiece", "Playback Switch", "Earpiece Source Playback Route" },
+	{ "Earpiece Amp", NULL, "Earpiece" },
 	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
