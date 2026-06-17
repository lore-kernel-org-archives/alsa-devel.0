Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE9CD98F2
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:04:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 071A3601F2;
	Wed, 17 Jun 2026 21:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 071A3601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781723063;
	bh=bbowo7F1PbtHvCipP2hniNy8pEJ086d7Z3jtCilcjI0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SDIobziVZGj0l+UZC72JK/WmCUcHZkZDD6CxP78DkcZHtzJIhQ43rp21rJpJqbUL5
	 jTzMoWNn0qsAO2gofm/nm0FJbL/mTC+Ja2myXnGCp7itFqPxTaB+HMZ/RxTE5Jc0d5
	 xfb4gtvXyih0H/xbc8fLJbL1rW61XfHpSIEpmOe8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E51BF80600; Wed, 17 Jun 2026 21:03:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCBC5F80600;
	Wed, 17 Jun 2026 21:03:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABA75F8055A; Wed, 17 Jun 2026 21:03:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781723018;
	b=D5z2KIEktpjsmJs2JDq8INF7y1qQW9CXT4eRI6IYq/J9zslZ0L7cMRxr3sc5FYt1rO5h
	 /zhq8k6U2onB4S5daVT1et6Q3UDVm0ouQBViKG9EtGcEcQsaa6JMcdl1Q5AFpR43y4FgK
	 phnVknQcyzVM6/oNlBrq2F/hbCXQhhI6C5OXizIPm7Hx8opVXxnFc1WBhRE/vbkASdlHI
	 xN7tNTp1f5JpksNNUfyHmnWHPeVZwvsOYOV1U5LgpTEQay++nsCw9KXHNP6h87YxKvus3
	 u4t5kcQCGvy5zcH1ITY9KgBCYlVI/Fw5NPBddEwb4gk49ALpfDuDnuLuCQxS2+0brTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781723018;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=bbowo7F1PbtHvCipP2hniNy8pEJ086d7Z3jtCilcjI0=;
	b=RmzG6YAHlEPllpw2n/9ZOtNSAluwwgXlhs8jPrBjJ7aen96QZMZbudkNRXemwZr5Mi/0
	 StD2IYy1dWQBxsC0Sxbrggv8king6J+JadOsPGCzZyRpM40Ud3DziI+FQO4IocYpNh8tR
	 ofQ4gl9Il8KerZPyKFSUSK8lMMZgJPuKZdIQtk4QfA5HQU3Vz8spqb6nU5IxZTyhS4fPE
	 gwnmFnhBLnBGSwDRfRmxVQCbryZXKzJJezeZyllAZASsTsnjoInNKBv42N2WSKRHHvVya
	 ORYm0J79QCBC8JePjngEo2uG9KXQLpkw8tDre9Z1bvlHTuJg8SnYegSO1NX0t/M7xyg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 48015F80038
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2026 21:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48015F80038
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b9f3a4bd663e00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b9f3a4bd485500-webhooks-bot@alsa-project.org>
References: <18b9f3a4bd485500-webhooks-bot@alsa-project.org>
Subject: No sound from internal speakers on Tecno Megabook K16S AMD with
 ALC269VC (Subsystem ID: 0x1f5c0018)
Date: Wed, 17 Jun 2026 21:03:42 +0200 (CEST)
Message-ID-Hash: EY4ZHEIAYUECXJXGUPRJNL3T2ROABVXF
X-Message-ID-Hash: EY4ZHEIAYUECXJXGUPRJNL3T2ROABVXF
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EY4ZHEIAYUECXJXGUPRJNL3T2ROABVXF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #512 was opened from lemirantos:

Hello,
I'm experiencing no sound from internal speakers on Tecno Megabook K16S AMD (2024 model) with Realtek ALC269VC codec.

Hardware:
Laptop: Tecno Megabook K16S AMD 7000
CPU: AMD Ryzen 7 7735HS with Radeon Graphics
Audio codec: Realtek ALC269VC
Subsystem ID: 0x1f5c0018
Kernel: 6.19.10-300.fc44.x86_64
Distribution: Fedora 44 KDE Plasma 6.6.4

Problem:
Internal speakers produce no sound. Headphones work when connected. Bluetooth audio works.
Diagnostic findings:
Codec detects speakers (Node 0x14: "Speaker at Int N/A")
Speaker playback volume control exists and is set to 80%
However, the amplifier on pin 0x14 shows: Amp-Out vals: [0x00 0x00] (muted/zero)
Manual attempts to enable amplifier with hda-verb don't produce sound
EAPD is present but enabling it doesn't help

What I tried:
options snd-hda-intel model=auto - no effect
options snd-hda-intel model=laptop - no effect
options snd-hda-intel model=alc269-dmic - no effect
options snd-hda-intel model=dell-headset-multi - no effect
options snd-hda-intel model=hp-dv7-4000 - no effect
options snd-hda-intel model=lenovo-101e - no effect
options snd-hda-intel model=asus-mode1 - no effect
options snd-hda-intel model=alc269-vieo - no effect
options snd-hda-intel power_save=0 - no effect
options snd-hda-intel dmic_detect=0 - no effect
options snd-hda-intel enable_msi=1 - no effect
Manual hda-verb /dev/snd/hwC1D0 0x14 SET_AMP_GAIN_MUTE 0x7f - no effect
Manual hda-verb /dev/snd/hwC1D0 0x14 SET_EAPD_BTLENABLE 0x2 - no effect
Tested with latest mainline kernel 6.19 - no effect
Additional info:
Bluetooth audio works fine
HDMI audio works
Headphone jack detection works (system detects when headphones are plugged in)
USB audio cards work
This appears to be a missing quirk for Tecno laptops with ALC269VC. The amplifier on the speaker pin needs to be properly initialized.
Full ALSA info: https://alsa-project.org/db/?f=726c125be3aa830e4c8c9c454596b9b6abaf739c

[codec-info.txt](https://github.com/user-attachments/files/29062481/codec-info.txt)

Thank you!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/512
Repository URL: https://github.com/alsa-project/alsa-lib
