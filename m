Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DDBC4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:41:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAC616020A;
	Sat, 18 Jul 2026 11:41:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAC616020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367692;
	bh=iDJsjNtS8kreu28kbSYJ1ouTrFQtyvx0DmxkpocRS1s=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fQjOk+CvmcVVlSbOyae1M3plLiND6/pql3TRZyLuIPb1eB3LpkmRyGKXX+ah0nceq
	 gg1fx3srubX9k8Hfqqz4VuLDiENL6QERXGskjK8+hIPp4ZfVCAQgfBGNY+AG0X8ZoE
	 gJiJYzK99lex/j8XMUbwFTBpvcURStKmI4kvEIiI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB5F2F80604; Sat, 18 Jul 2026 11:40:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A16A7F8057B;
	Sat, 18 Jul 2026 11:40:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34DF5F80526; Fri, 17 Jul 2026 00:20:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784240412;
	b=VEVbYlj51WgHWC7rcj4LwlSoeUj8LmSq+z/OcxWw6/+NWGc98BRm0bovBU0R7/viGPm8
	 FpZi+9mJ7UMkghkS7bJzzh6aypCdiHwtwExY1bxZj+P019w7m9cu4GNnRQhZNHzZ7QKI/
	 7p+d4Ot2OkWfUDcM8xH7PNh794ufUy863MUBNlRrjakyRhlY+/Nmzw2VavhsLr8MM4xcb
	 z1Z987EdpE/8PDGELlgcwmpgKDuKHw7zwLTlRLP9qm2q36xLnhKBKDfKPVN6/dMlcRQ7C
	 iD/g7vzvz8wt1j31zV6bGhn+lP/9iQ9f81vtRY48JavmH9ho4gQCYOk0kf2J/e9FVrw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784240412;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=iDJsjNtS8kreu28kbSYJ1ouTrFQtyvx0DmxkpocRS1s=;
	b=pEjNh+ACwlt2kFWDph52ksxNCKNv1BUjWbJoh3L66bnr53Q95gziuDY7JjTR8UAKHnJt
	 T+fDhwBQnT8Qe7cBA5iin5cYFFBJrHw2Dx/ACJcDOYqZ7ZXnQfYEKg3mvOOf0iY38bOnc
	 9gjML7coNwSHqN2+qIRlnc69WgJ9/WEaD0YwBnXkFQhhLOdRB3wU4TxU0oNTKuINv+1Aq
	 ZI124qcyjAnZE3g0R8+cBcIADdBOhN7bTCt1bLXYNmR1tnRGCe3D05LP6aRI+lTtghvnX
	 yLEqNScajqdKuySvwXdYHXi7a7GLY1LDqF09XxcYplW+7yRbgsg+ZiqzCgo1AbU9DSQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="lBSv/6k8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7523F801F7
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 00:20:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7523F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lBSv/6k8
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5aeb98460c6so4370806e87.2
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Jul 2026 15:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240409; cv=none;
        d=google.com; s=arc-20260327;
        b=kLDMvuoHXJaPuVsEux/KbaqOItPhyywK8DSsgvlA8AxCmHQyS+Clcww5gVcLe0Aayv
         mAd+dVFwULp0fSy8HgnA7fgN9TkaHt1GxU6SOmCSG1H2NqE3lZoiTR04dx6G7DXeyeSx
         q08aqcC3h6NKyX14SuPEnTVr478EBNvVWxyXlNU32ToGml4GqT9j8V3BR7KYx102GP4g
         8Gk2kOJjyh0pD47dy7Q52SmDNXSXijEwNgOIZTYXdHfBlO7m7/BDZolhdgekUAZGLCui
         mD7J+zsEwgAlMv6f/om7yrc/dHyogL+Bp6FCWTWhHeMB9eK9YpAVsZCZFOd/KF9RqKOj
         eYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=35+R1s9qTf5horVtcrNim4EB7QFCaumPuQ07ReLrFdo=;
        fh=gS0NTHKzQKeqQmFok5pwF8BTWIAec9YQDVfDAgU5APQ=;
        b=HPW86zePD6Iqg8Oeb4OkEAUHFuSK9Nuvf7bMizJt5KPhBhCTl9UfBbRDD0d2w0nHb6
         x6jyCmJPAKbSfrHNWI0Q0q/yvAQfKAcAjTDLzEYevJmOSurja4gtR7eJ7ay53qeDVdZY
         Tf916h6IDdk7FrXaJpkPTG2FztcDXb5LAdFRjeXP5dHz+o7lApZMNS1fbypvNpt7iNIS
         SPtFeHiKsPoiHd68Mf4r2QVD95G0XHFEPwhcZ4dVsJ9mEyrtaz2f1TRQGIm11XwKG7aE
         +TCv+QDgAneIXo5rxVBwZ6xZIWuoCxOcS57yBomZ9PEOiPLWnNnUCPDqV9hslpmUYNqm
         qFGg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240409; x=1784845209;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35+R1s9qTf5horVtcrNim4EB7QFCaumPuQ07ReLrFdo=;
        b=lBSv/6k8tHwMmwOTum4V+1jcBk50FhdvEfDv7mdQN/H4XEDRPCId6p4dH6Nl3XCA9r
         8KoM/QExvU9BYcBhxpfTs4NQOQhEw5hLbdhMFO2UyThxC5OWdvZTKS/Za5okqgDB11o7
         VeJHskhur2GVt7IqhZWoH4JLwA91/L6g+mLVlI7WWVF75eIB+gxnTsx4saKRjpWA2zYj
         /519KIRuMfFHLJQ6hrrj2rYP1qU8oIOP5J+3f54jULPwXcg2ofOCBtkGTAfsXwsAPNq+
         HECi0SKPSR/osH5ZfzrvmJoOkemRMVPu67vH1bDQWxsifWukbTMtEbyfaCYNnX9mvl1j
         zK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240409; x=1784845209;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=35+R1s9qTf5horVtcrNim4EB7QFCaumPuQ07ReLrFdo=;
        b=ZoNRjsovCRCBsw9/fMI2iK80ZdKu+JjYFtwcVN0mD2UjmhT9qJ1K7d7YKyKcfDtJvs
         BT+3ty1QRbHx461ihb97kHBDqQbyEw7sBObLbLAI2x9MJnDzvNjaEvhouR/rrFj3M6ro
         ntzv7wzmdO+hwz2EVYJWC7AXcfjlXzqp8RwqXr2Biotwvu0KO41q0Ph5eTYIVm6mL7dL
         563EOma6vuJmzP6fEq/mvm9quhokZ3kX/1pyguFrRru8eheTJa5WGhT3ihB5Ohj2h6+z
         x41w+0NorLkzMGEKoDLAF4s+ANmsgdgkswIFxLI43nXKDwc2nW9j8aoUe0htHf1uygFQ
         df5g==
X-Gm-Message-State: AOJu0Yz/b6cFZrWBIvWNVjbBEaHvlaSZ3jKQQU3CcDlfE/V+X9Jy07nS
	MT/NUf4OzeSzOxrHXSrOM9lMv1OEqorSl8LS6PYIM5+vtGg7ZseBl9DBaT5rGimpkj3SQA+UlEG
	tFAj/rfQa4P2CmhM9lmx4TdIij814Y5fa4DmO
X-Gm-Gg: AfdE7ck8DU7a5mV8FsFoG0Rvw2k11X8Jls7zzYTwhlasM+qm0XG+AWyh2MO90SUfBlR
	t79gC0wdguZy9Vfy2+Exdm/jf+qtVekFy6OaFVkdkd62HOhyZCvc+nQ/C0Iv2T5fm+rgzjhPH6D
	LKL05SsAxKTV3OMB+cHlJY7z40qLPC4xdYccHXtesRYeecb3K+CLOqDvp+is9KTBpYmskSbVgZT
	GbS4CStAFSDLctiZ2wSwRm0a1PpqpAB4jCpMQEvkGLvQ22ttG/pGSpFB+8DT/jY/7qhEBXXG3Qh
	jGfeFGzzMKi+B8PUSguYFmsDM0RasE0mgb/kI2cBdXxIiGk=
X-Received: by 2002:a05:6512:3e14:b0:5b0:1ecc:119d with SMTP id
 2adb3069b0e04-5b28fabb958mr5721e87.50.1784240409147; Thu, 16 Jul 2026
 15:20:09 -0700 (PDT)
MIME-Version: 1.0
From: Adam Powell <apowell41@gmail.com>
Date: Thu, 16 Jul 2026 18:20:00 -0400
X-Gm-Features: AUfX_myrMTpS21UFO9935fDbjdTB0CR4AcY2aktuNgdX1KezHB76T9itKSztr_w
Message-ID: 
 <CAO7fKs0Siwg1EmWjCUvaDDsR1V6E=rhT5WiCSMf8q8r0B-LBAQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/cs35l41: Support ASUS Zenbook 14 UM3405GA
To: alsa-devel@alsa-project.org
Cc: sbinding@opensource.cirrus.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: apowell41@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DZHHSPXD5RU4Z4JR6P4YTOFTG57ZANA7
X-Message-ID-Hash: DZHHSPXD5RU4Z4JR6P4YTOFTG57ZANA7
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:40:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DZHHSPXD5RU4Z4JR6P4YTOFTG57ZANA7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ALSA: hda/cs35l41: Support ASUS Zenbook 14 UM3405GA

Add SSID 104319F4 to the config table for the ASUS Zenbook 14
UM3405GA (AMD Ryzen AI variant). This board uses two CS35L41
amplifiers over I2C with external boost, matching the same
reference design as the UM3402YA/UM3402YAR (10431E12/10431683).

Verified: with this entry, both amplifiers bind correctly, read
ACPI DSD properties, and respond over I2C (Revision: B2 on both).
Model-specific DSP tuning/calibration firmware for this SSID is
not yet available in linux-firmware; playback has not yet been
verified end-to-end pending that firmware.

Signed-off-by: Adam Powell <apowell41@gmail.com>
---
 sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index 416d7bf3e..ec288c4eb 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
@@ -98,6 +98,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
  { "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1,
2, 0, 1000, 4500, 24 },
  { "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1,
-1, 0, 1000, 4500, 24 },
  { "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0,
1, -1, 0, 0, 0 },
+ { "104319F4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0,
1, -1, 0, 0, 0 },
  { "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1,
2, 0, 0, 0, 0 },
  { "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1,
2, 0, 0, 0, 0 },
  { "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1,
2, 0, 0, 0, 0 },
@@ -530,6 +531,7 @@ static const struct cs35l41_prop_model
cs35l41_prop_model_table[] = {
  { "CSC3551", "104317F3", generic_dsd_config },
  { "CSC3551", "10431863", generic_dsd_config },
  { "CSC3551", "104318D3", generic_dsd_config },
+ { "CSC3551", "104319F4", generic_dsd_config },
  { "CSC3551", "10431A63", missing_speaker_id_gpio2 },
  { "CSC3551", "10431A83", generic_dsd_config },
  { "CSC3551", "10431B93", generic_dsd_config },
-- 
2.55.0
