Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF500C43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:51:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4978B6021C;
	Mon,  6 Jul 2026 15:51:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4978B6021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783345891;
	bh=u/Ab46wuYODifvRZEl2F6L6fz5vurxV3fwCtoNRKFjM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sAbAlJFGUjsHbKakY+Ud9oJl8TgZEL08zvzQpnX0bH5LQrSFKW9UAmVlrVjSK/n/S
	 IdLmDvRhUCFRGE6Qjh7mes33ukXnXafSdephkqxGD0ct3KcdFmOB3kVrRhc7A6ZHd6
	 ql2ZGSnCE2u701nq37du4KvogT0AobL3JmYVJ5hU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D38FF805F6; Mon,  6 Jul 2026 15:50:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE624F80601;
	Mon,  6 Jul 2026 15:50:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10ABCF804FF; Mon,  6 Jul 2026 15:50:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783345851;
	b=EHvdZON94HqFjn88nHhInzWfPdJz4VV07HXiiY3oYEyYa64NXSQE9ecA82HPVTR0vg5l
	 AlVnutAU8AXiBI2F4h7oWb7dbVoJeqG9o3gELgAIEH6K2G9TqtEY4GdxGIhy32frRVuy3
	 GbrCGGepGON8cyNczIHkvQ+aPFEuL/Q6V0CxgJtJoGlrvJQpGgBxQ8BLBiRfAvnAA9HEN
	 H2NKh1KtZ+3oIXmm4vhq7yFejzaKbmO3m2wqrGshF5cLyGNZm1Gr6hmhA6a16yTq7suPy
	 Kl90r97djr4MDLbmA80Qn1i/rogVn7Y3dr7+Xt8ad9ygdR33VUXL11872fGqTVxUxPg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783345851;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=u/Ab46wuYODifvRZEl2F6L6fz5vurxV3fwCtoNRKFjM=;
	b=Vj0cxb+xFpeCuG23XO/3l+ijVVJBYFEupjAYQ7RgJxXEeMqLlnv1g5Ypo4diOhU65yGQ
	 Yor5VQZ667/U5qhx41GmaDf1ydjoRqwJSwolMGwanN2InqQchuJY54Fpn/eNJGK+B87oN
	 Tg3BjNmXyQY/x0HjbKrJDU6NYc8jdSyaSX3FS+KH8l/qJZltIQtLod4dW8JSPnnbHmSqv
	 eOeQPQpw8UsGmA6hVYrw3tGndjyg9PcyVhp9pqpBIqBvul1Hg4nvPgDIImlBE0UHYqV3D
	 4eLPBG2BtxEDhQR0Iw/65JOaa8YgowNO686o++meoi5acngq9GzhPQnd8ZoC7Evy0FA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 451D8F801F7
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 15:50:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 451D8F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfb79a0bb01800-webhooks-bot@alsa-project.org>
In-Reply-To: <18bfb79a0ba56500-webhooks-bot@alsa-project.org>
References: <18bfb79a0ba56500-webhooks-bot@alsa-project.org>
Subject: rt721: capture switches (FU0F/FU1E) default to OFF on AMD SoundWire
Date: Mon,  6 Jul 2026 15:50:52 +0200 (CEST)
Message-ID-Hash: 5YXELHFWBHGWX4SBIXA6JXUGGFUNUQ4M
X-Message-ID-Hash: 5YXELHFWBHGWX4SBIXA6JXUGGFUNUQ4M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YXELHFWBHGWX4SBIXA6JXUGGFUNUQ4M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #805 was edited from BenSharir:

The RT721 codec capture switches for ASUS ProArt PX13 (AMD SoundWire) default to OFF, which mutes the DMIC microphone.

**Symptom**: Microphone records silence despite being selected in system settings.

**Cause**: The following ALSA mixer controls are off by default:
- `rt721 FU0F Capture Switch`: off,off
- `rt721 FU1E Capture Switch`: off,off,off,off

**Proposed Fix**: The UCM profile should enable these switches by default in the HiFi verb, similar to how other codecs handle capture enablement.

**Hardware**:
- Laptop: ASUS ProArt PX13 HN7306EAC
- Chipset: AMD ACP70 SoundWire
- Codec: Realtek RT721
- Amplifiers: TI TAS2783 (x2)
- Card components: `cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721`

**System Info**:
- OS: Fedora 44
- Kernel: 7.0.13-200.fc44.x86_64
- alsa-ucm: 1.2.16.1-1.fc44
- PipeWire: 1.6.7

**Workaround**:
```bash
amixer -c 1 cset name='rt721 FU0F Capture Switch' on,on
amixer -c 1 cset name='rt721 FU1E Capture Switch' on,on,on,on
```

**Verification**:
```bash
# Record 5 seconds of audio
timeout 5 arecord -D hw:amdsoundwire,4 -f S32_LE -r 48000 -c 2 /tmp/mic-test.wav
# Play back
aplay /tmp/mic-test.wav
```

---

**Related**: This system also required a TAS2783 firmware symlink fix for speaker audio. That issue was already addressed upstream in kernel commit [e26bb459d0f3](https://git.kernel.org/broonie/sound/c/e26bb459d0f3) ("ASoC: tas2783: Update loaded firmware names to linux-firmware 20260519"), merged for Linux 7.2.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/805
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
