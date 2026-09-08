Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94823C79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:42:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3370760359;
	Tue,  8 Sep 2026 20:41:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3370760359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892911;
	bh=VPXs8lvIsA9bvQTJ/c/tqiLS8AygmJoObd8lEynnagU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pi+ui9L9gz6ku6LQeTwgYNTRLRCwOIIoqCk06iFTT5w1YVcbpN4bwp7+t6wEO0jz4
	 0vGGBzg5rZbbefERLulUD7YpOY9RXDh7VSLZwO34sLyZPTo9mBy36JM28AzEdngmP/
	 B5c8KilDKALCoHfMauxtrHpUrSs7GgQaHvQjzl80=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2A20F8974F; Tue,  8 Sep 2026 20:36:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BA15F8974F;
	Tue,  8 Sep 2026 20:36:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85EF9F80518; Tue,  8 Sep 2026 19:58:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788890288;
	b=o6jcuNWjayu902UNSma8DzxijDl+IG2B6/LsLft1Fxha4C95N+8ZbK/EbAmj9MAdYkVQ
	 m3GFFiW5O189URTe4eDNGTy7gSbLhsOxLS1qhrUghkDjo4pmdKx1PphK6mYWK3i+2S0xh
	 QLB6KLPxhy1dYLHw3gZFimpQAAoSPLxiMID6DBYUO9Fqr9Xmezqyps4ZXErNnDpOhjq1T
	 zvKEfPZPX4CuI4C+0Nuxli1l3Q9jeqTqKdvWCallxst08HC7R7zQdg4xQCdm8qnsm9qNW
	 cqf8L7EbTo5rMgK9Zj7LAgu+xNyeQxE4WlJLLUUebR8227x/8osTiihjCFzpoZ/bsXg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788890288;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VPXs8lvIsA9bvQTJ/c/tqiLS8AygmJoObd8lEynnagU=;
	b=LdbXMVZWjwqHXKYggAi9kgak36k9euwIz1ZyiEsQeOCMVYQjKPopbCxhm+j6OxjhxtT3
	 1JKjmCHVbroXQdrj4XIhMOZTX/+/KrBgIn3zaA4ScWNgkB/hNFieBF2pjM3o70QT8VFOz
	 OIiU7E36haJiX2sWc0uNKgzdFskS0eXsQt5kcAG/lmJlmlcYt1f03tsTO/97/wFAt+a2O
	 b2AR61qSiIMbqNQBj6NTrAS9kgj04VEuEgxqJrCjUBCrk5gxMsKOJBgRQDvUzYEUDtWn2
	 cHk1uYB2418iDB8tUwea1T/moDCH3VrymtEdThKZSFREzSYB+RP52ED9oyesV0TGB0Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="AXz//VZS";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69171F800FA
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 19:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69171F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AXz//VZS
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so5485778f8f.1
        for <alsa-devel@alsa-project.org>;
 Tue, 08 Sep 2026 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890286; x=1789495086;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UX8L/BtZO7H1FbvBOVuWTf8zSaxbJy2FpKxDe96gDGI=;
        b=AXz//VZSGUjmpdaHMn1ta7bGxp9LDpRzJr08/oW9cA2q5HbptbVTmCM+fy+bT1lUFK
         VU23CNiTZBROJ67RaR4mLSDcYH+G0r3XsHCWLC8oLJsg9y9J7bnlG7gvcE4M2J+BJ9eS
         wDFH9Bb3h4tEgNZNp3d4fhhT8jVB4bNan/E17b5o+5PetT6C8r76hWP30mxVLNewwPWK
         4CHftoyjGwyulC0cGM8Mb74bYMYSzseIedlhRMb3yi6fzRJc92uTJnwK64z3+wUaObpz
         6Vq9sV3AABbpPfwJIvfjFqnu1npNrC+8UH660GcOgab8D9EqKgN+bb6Zk2R9WHiLZ5Ac
         odPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890286; x=1789495086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UX8L/BtZO7H1FbvBOVuWTf8zSaxbJy2FpKxDe96gDGI=;
        b=LqaBD/bUOhQ0y6ck9hwwi4VCmRPc/4nRpsih29dJN21Vzabd7qOEZ+yyplNQpdPS2B
         yQtgJ+CNas+qzPiwNIJY9gN8x8n3pfsIzaU5kaS3Xbeq9gq4FceUTsICBLE7kI9aM6gT
         UPYWDT1s0RDQtaawDvUbPrnOxrTTizN10LBcaB/hXuH2QoNIMkB2ynp/zgS9GqY7wv8x
         a6eol7KBWqyrmTeZUDj++hVLeBnqpTBu18I2yW/wyRbNRACg1ZUGETjpt63u6hPGJ8et
         A098qRmURZjkIAFhe0xRo4h4TpoAYUEzHt1mQWC5TFLZsQPShyDiLtf9tCAODkqdxEDJ
         U48A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwczdOKDl8qev3rF27y1C2PArbM+5BTKi42i39/F81lAj66tU5kVJpQRz/sbb615NHooMd9CNew+cEX@alsa-project.org
X-Gm-Message-State: AFuF++ku+xcz4A1tLQMW4F/6sUmQ4mu6h491HSW5r6oHlyYaWx7D6ZLc
	xtCLzBPcKEfE0q5W7Q6NNafBhi6rk3DOv/+i10mxwGU5foITbKX3J09s
X-Gm-Gg: AYBFou16FxgDIARaactPdAw5YKsm9Dm62SXy8VSXdKO6D1MfJvBDHmYdgSmzTluBmxQ
	lAMEH61X2G3QY2uuMQrCFbHnxqnseg92w8WJFbnhlJciJKO+3ztTi3iZZSqlDrLaWIApD2PwpQa
	1QVGCMBktvzQLav7eABvPf0/ONCScYKOGXyOWhZo6glLjcQ4tllRCo/6aDSoM4uqLwAD1BYXGzr
	L4EN98aaKw/h/G6YOJJ3Ja1G36qHL9zNyBgAawA2qOPrnRaiwUkJgXFEFzShK+FQOwoOKwyDHYh
	+a9IcOiD1g+FiqxRfg1WbpFk9S5hwMgaa7DVAdsqjl5iQA5/DKmtWBaxuxg6zkfsl2sGfiTEc41
	zlO2mrSTbLqjKRpk+5BdcrrxIkpsGksjPiIpHMX1vThFGg/tYPHku0mq3MIF44Ii77eWhG/WMOH
	yJ2OUXnIEzEeUiLr2QnuPPhreOu2rBLAX5+p5A3sxW7yX99KQDVa8GKBfJKF8OeZUDpxkkxIC6O
	9AD9O6bD/9JsYoVl4Q7ciI/hKJFUuY=
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id
 ffacd0b85a97d-48587099a2dmr57344271f8f.24.1788890286214;
        Tue, 08 Sep 2026 10:58:06 -0700 (PDT)
Received: from dd-home.home ([2a01:cb1c:922:a700:4e5b:d129:8f46:873d])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm42561836f8f.25.2026.09.08.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:58:05 -0700 (PDT)
From: Maxime Douailin <maxime.douailin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	Maxime Douailin <maxime.douailin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Do not clear SYSCLK_ENA owned by DAPM in
 configure_bclk()
Date: Tue,  8 Sep 2026 19:58:02 +0200
Message-ID: <20260908175802.604262-1-maxime.douailin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: maxime.douailin@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WJ2KNA75AIV7UUDJNYSC5Q3XL53CDWCO
X-Message-ID-Hash: WJ2KNA75AIV7UUDJNYSC5Q3XL53CDWCO
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJ2KNA75AIV7UUDJNYSC5Q3XL53CDWCO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

wm8962_configure_bclk() provisionally sets SYSCLK_ENA so that the
read-only DSPCLK_DIV field becomes valid, then clears it again whenever
the bias level is below SND_SOC_BIAS_ON. It never checks whether the bit
was already set.

It can be: the "SYSCLK" DAPM supply widget owns that bit, and
wm8962_mic_detect() force-enables the pin. On boards that call it (the
Tegra machine driver, i.e. Microsoft Surface RT and Surface 2) DAPM sets
SYSCLK_ENA once at card init and, because the widget then never changes
power state, never writes it again. The first stream's transition to
SND_SOC_BIAS_PREPARE runs configure_bclk(), which clears the bit behind
DAPM's back. From then on every stream plays with SYSCLK off: the DACs
do not run, CP_ENA refuses to latch, hp_event() reports "DC servo timed
out", and the codec is silent although every register DAPM believes in
looks right.

Remember whether SYSCLK_ENA was set on entry and only undo our own
provisional enable.

The bug was located with the help of an LLM coding assistant, by diffing
the driver's regmap cache against raw I2C reads of the chip during
playback; the assistant also drafted this patch and the changelog. The
analysis was confirmed, and the fix written and tested, on real hardware.

Verified on a Microsoft Surface 2 (Tegra 4, WM8962 rev F): with the bit
forced on over I2C during a stream the DC servo completes in ~56 ms and
audio is heard; with this patch applied the DC servo completes on every
stream and there is no more "DC servo timed out".

Fixes: 75704ecfbb41 ("ASoC: wm8962: Enable SYSCLK provisonally before fetching generated DSPCLK_DIV")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Maxime Douailin <maxime.douailin@gmail.com>
---
Notes:
 - Found and verified on a Microsoft Surface 2 (Tegra 4); the same silence
   is reported on Microsoft Surface RT, whose machine driver is the same.
   Background and the full register-level analysis (regmap cache vs. raw
   I2C reads during playback):
   https://github.com/grate-driver/linux/issues/141
 - Boards that do not call wm8962_mic_detect() are unaffected: there
   SYSCLK_ENA is never already set below SND_SOC_BIAS_ON, sysclk_was_ena
   is false, and the sequence is bit-identical to the current one.
 - The deeper question is whether tegra_wm8962 should be calling
   wm8962_mic_detect() at all on these boards, but the codec should not be
   clearing a bit DAPM owns regardless, so this fix stands on its own.
 - Tooling, per Documentation/process/generated-content.rst: an LLM coding
   assistant did the register-diff analysis that found the bug and drafted
   this patch and changelog, over an interactive session on the affected
   hardware rather than from a single prompt. Every register claim above
   was checked against the chip over I2C, and the fix was built and
   listened to on the machine before sending. I understand the change and
   stand behind it.

 sound/soc/codecs/wm8962.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index af471605122..c314af2c860 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2472,6 +2472,8 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	int clocking2 = 0;
 	int clocking4 = 0;
 	int aif2 = 0;
+	int sysclk;
+	bool sysclk_was_ena;
 
 	if (!wm8962->sysclk_rate) {
 		dev_dbg(component->dev, "No SYSCLK configured\n");
@@ -2504,8 +2506,19 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	/* DSPCLK_DIV can be only generated correctly after enabling SYSCLK.
 	 * So we here provisionally enable it and then disable it afterward
 	 * if current bias_level hasn't reached SND_SOC_BIAS_ON.
+	 *
+	 * SYSCLK_ENA is owned by the "SYSCLK" DAPM supply widget, which may
+	 * already have it set even below SND_SOC_BIAS_ON: wm8962_mic_detect()
+	 * force-enables that pin, so on boards using it (the Tegra machine
+	 * driver) the bit is set once at card init and DAPM never writes it
+	 * again. If we unconditionally clear it here, SYSCLK stays off for
+	 * every stream, DAPM still believes it is on, and the codec is
+	 * silent with "DC servo timed out" errors. Only undo what we did.
 	 */
-	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
+	sysclk = snd_soc_component_read(component, WM8962_CLOCKING2);
+	sysclk_was_ena = sysclk >= 0 && (sysclk & WM8962_SYSCLK_ENA);
+	if (!sysclk_was_ena &&
+	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
 
@@ -2519,7 +2532,8 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	usleep_range(500, 1000);
 	dspclk = snd_soc_component_read(component, WM8962_CLOCKING1);
 
-	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
+	if (!sysclk_was_ena &&
+	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, 0);
 

base-commit: 0e2bf66c2f6326c0626c9db22530954ef5c64b08
-- 
2.53.0

