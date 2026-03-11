Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FED1061206
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:08:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28D54601E9;
	Wed, 11 Mar 2026 12:08:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28D54601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773227328;
	bh=DWpTSnvH2/TW3bk23UKCf2UqDzSq8JxqUxSgr0rRNuo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NGvWkJkYP47rWdm93vFSK8eXB5y+JMTt0Kd8LaGIn6rKxu00BK59HPR+Po5Wz8txa
	 0WP4J2XnNDJUKz8R9MLYupPId4Z+HgOW2MW8xpGWsS8lTzNp3GDo802JJDBtINcrBb
	 vOihMtOY01p55sbABDaWLRi/4ikK/d42SAgbrbWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83383F805ED; Wed, 11 Mar 2026 12:08:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F000EF805F5;
	Wed, 11 Mar 2026 12:08:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58390F80552; Wed, 11 Mar 2026 12:08:05 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 86722F80171
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2026 12:08:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86722F80171
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189bc4d1a8975a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/32@alsa-project.org>
References: <alsa-project/tinycompress/pr/32@alsa-project.org>
Subject: Utils: cplay: Fix WAV header parsing for multi-channel (5.1/7.1)
 formats
Date: Wed, 11 Mar 2026 12:08:05 +0100 (CET)
Message-ID-Hash: USM7YW5L6BA4YBBMJKD7RPLELBKQKJCI
X-Message-ID-Hash: USM7YW5L6BA4YBBMJKD7RPLELBKQKJCI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/USM7YW5L6BA4YBBMJKD7RPLELBKQKJCI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #32 was opened from singalsu:

Multi-channel WAV files (>2 channels) use WAVE_FORMAT_EXTENSIBLE (type 0xFFFE) with a larger fmt chunk that includes a channel mask and subformat GUID. The existing parser only handled basic PCM (type 0x0001), causing several issues with 5.1 (6ch) and 7.1 (8ch) content:

 - The fixed-size fread of struct wave_header (44 bytes) misaligned the data chunk read when the fmt chunk was larger than 16 bytes, resulting in audio data being read from the wrong file offset.

 - No chunk scanning was performed, so intermediate chunks (fact, LIST, PEAK) between fmt and data caused parse failures.

 - The WAV channel mask (speaker positions FL, FR, FC, LFE, BL, BR, SL, SR) was never extracted, so firmware received ch_mode=0 and could not determine the correct channel-to-speaker routing.

Add parse_wave_file() that properly scans chunks, handles both basic PCM and WAVE_FORMAT_EXTENSIBLE formats, extracts the channel mask, and positions the file pointer at the start of audio data. For basic PCM files with >2 channels, a standard default channel mask is generated per the Microsoft WAV specification.

The channel mask is passed to firmware via snd_codec.ch_mode so it can correctly map channels to speaker positions. Also add 24-bit sample format support (SNDRV_PCM_FORMAT_S24_LE).

Request URL   : https://github.com/alsa-project/tinycompress/pull/32
Patch URL     : https://github.com/alsa-project/tinycompress/pull/32.patch
Repository URL: https://github.com/alsa-project/tinycompress
