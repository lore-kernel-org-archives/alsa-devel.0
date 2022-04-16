Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17930C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Apr 2022 12:55:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1BB91707;
	Sat, 16 Apr 2022 14:54:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1BB91707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650113719;
	bh=vAQgtJeb7+OIweYBHbnV8mzchpWFHuDxrbNsxaDJ9s0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NPgsyWwjF2wt4ye29RSPuXYgk6loT9+tjY3hLFclJWbNGvIVWJ9ujHeEPEZPzbTss
	 wsgE3PxBPc7NkhD9Ckg6MVWVjnNt1cmqgoRAlpIXUs5Hohoyx7Miaxt0nEu7s68+vK
	 nQT1hLoDqOnM1HSH5lRE7AJk0GA2JMTjMO8+d0BA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73659F8012C;
	Sat, 16 Apr 2022 14:54:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA0CF80161; Sat, 16 Apr 2022 14:54:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4479F80095
 for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2022 14:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4479F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kXCgS75G"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE4460F0E;
 Sat, 16 Apr 2022 12:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130CC385A3;
 Sat, 16 Apr 2022 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650113661;
 bh=vAQgtJeb7+OIweYBHbnV8mzchpWFHuDxrbNsxaDJ9s0=;
 h=From:To:Cc:Subject:Date:From;
 b=kXCgS75Gu8SYMrogzL4tpqVf4XuIHtdcgnN+HDRahovgJBfsfIV10eXHZvG8jznc3
 +6q3HmKUTy2caxNvmrO77e0A6tR6osqVDrAA62M7KdLEm2ZBFOGzauPb17uAu8xC7R
 blUZzeghh7J0iB1utMFZ26wLnc1878fDt7brxLHxhGNY7Xmi9q+ULLc4nDnDUpb0iv
 aQH+NV/cdSeMUpY/bt1tdIV/CcKxReWltFYbdjX2KiHYr3bh0oVAUhhLTx9DQ8i4ox
 f8a+cyQBCxvg0ROpCyQvG9Ocqf6YczEPf4Yezmxz6TAUCMKKeRH1AIgZX1zj6X1kv/
 9SvD89A4lFXzg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	patches@opensource.cirrus.com
Subject: [PATCH] ASoC: wm8958: Fix change notifications for DSP controls
Date: Sat, 16 Apr 2022 13:54:08 +0100
Message-Id: <20220416125408.197440-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; h=from:subject;
 bh=vAQgtJeb7+OIweYBHbnV8mzchpWFHuDxrbNsxaDJ9s0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiWrxFquVGEG4qukE43PbX+CkeM8LMEga8rYZE/Bn+
 Sbf1kg+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlq8RQAKCRAk1otyXVSH0HakB/
 kBEcXlL8gXn69rBg+t/sNxenbpT/uPB67HAzt1vss6WYOr4G9FYq8iu3nF5fET9POp+75oFBNP2rlf
 ebJxPb5MuLGBnnKSh8mb4tzGai7nOIfeMNXYmmUwyqT6wRNssgDCEyElPtsLr9T3WywDJWLy6CwJeD
 IUTux5ncLE2SCTsvqOm//4KeAwCcDrV2PjPZmXc8DjTQzOZ408iOoCyfovUMUlbfRMgLwBStgX4T+8
 qOIclwL8nJyAakkrfVeJqtu1zuxqAZpxPCKNkl5neEL5GPpiGD8FuTL555hDmwp6bncGPeRMWtE5th
 /xIZMIDmXV2ugPjPRIo3j9ujASSfcU
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

The WM8958 DSP controls all return 0 on successful write, not a boolean
value indicating if the write changed the value of the control. Fix this
by returning 1 after a change, there is already a check at the start of
each put() that skips the function in the case that there is no change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8958-dsp2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index e4018ba3b19a..7878c7a58ff1 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -530,7 +530,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(component, mbc, wm8994->mbc_ena[mbc]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_MBC_SWITCH(xname, xval) {\
@@ -656,7 +656,7 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(component, vss, wm8994->vss_ena[vss]);
 
-	return 0;
+	return 1;
 }
 
 
@@ -730,7 +730,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(component, hpf % 3, ucontrol->value.integer.value[0]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_HPF_SWITCH(xname, xval) {\
@@ -824,7 +824,7 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 
 	wm8958_dsp_apply(component, eq, ucontrol->value.integer.value[0]);
 
-	return 0;
+	return 1;
 }
 
 #define WM8958_ENH_EQ_SWITCH(xname, xval) {\
-- 
2.30.2

