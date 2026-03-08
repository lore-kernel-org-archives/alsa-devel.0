Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30CCF55126
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Mar 2026 09:03:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 618F260258;
	Sun,  8 Mar 2026 10:03:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 618F260258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772960618;
	bh=5TRkxnDHmyBem1AxpIRsWjqBNHarSc7DBjOMG4HteW8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FKqDxPvD5F8DQl2akDrnzwOc+Em1RM08TzKnNlwlKTLBysyiJ8UGJLc8Q8IOALPYj
	 mA/+UKMEWa+NUEV5SVurqiTyypmRBOPEhQbn1ELbC+Wuj3v+pbzMq2cJUGawqaeD6+
	 nt389+Js9shxWMumqnWss+hMxC9iq9UYKX4sTsSA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54D83F805F5; Sun,  8 Mar 2026 10:03:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE36FF805F4;
	Sun,  8 Mar 2026 10:03:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67C85F80557; Sun,  8 Mar 2026 10:02:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 284D2F80087
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2026 10:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 284D2F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189ad23ed017ae00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/715@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/715@alsa-project.org>
Subject: UCM2: Qualcomm: sc8280xp: add Huawei MateBook E Go support
Date: Sun,  8 Mar 2026 10:02:53 +0100 (CET)
Message-ID-Hash: PS6DQLO6LL2EGBABJRTM32TGEFS6BGIV
X-Message-ID-Hash: PS6DQLO6LL2EGBABJRTM32TGEFS6BGIV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PS6DQLO6LL2EGBABJRTM32TGEFS6BGIV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #715 was opened from whitelewi1-ctrl:

## Summary

Add UCM configuration for the Huawei MateBook E Go (GK-W7X), an sc8280xp-based tablet with the same audio codec hardware as the Lenovo ThinkPad X13s (WCD938x + WSA8835 via SoundWire).

- Add `HUAWEI-MateBook-E-Go.conf` device configuration
- Update `sc8280xp.conf` to match HUAWEI DMI alongside existing LENOVO match
- Error message only emitted when no known vendor matches

## Hardware details

| Field | Value |
|-------|-------|
| Device | Huawei MateBook E Go (GK-W7X) |
| SoC | Snapdragon 8cx Gen 3 (sc8280xp) |
| Audio codec | WCD938x (headphones) + WSA8835 v2 (speakers) |
| Audio bus | SoundWire |
| `board_vendor` | `HUAWEI` |
| `product_family` | `MateBook E` |

## Test plan

- Tested on Huawei MateBook E Go with kernel 6.18.8 + Arch Linux
- Speaker playback, headphone playback, internal mic, headset mic all functional
- `wpctl status` shows correct device names (Speaker, Headphones, Internal microphones, Headset)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/715
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/715.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
