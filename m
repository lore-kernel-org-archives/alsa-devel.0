Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14930C5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:52:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6210E602A5;
	Mon, 24 Aug 2026 20:51:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6210E602A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787597519;
	bh=BfbMqD8wHnmnBeo/z3H58mRnHp0U75+ajQ/aYQ9IZfM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=g8FyK8/uD2BspWQ1tSpfH9UvEu8eKWDBbdjIunmv5P8hY6rQfWDA4+2m5L8p+MtnA
	 vPUfQcG48EYABS3Z514Ffpuj5CrT0mWSEGCrIpmzPiwdlzrU7aF7fVYXLauK9ENHqq
	 Yb9Gt5mLhHawbIi6eObi2gOqV9drRUFxQKnF+BhM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D987F805EE; Mon, 24 Aug 2026 20:51:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBC57F80601;
	Mon, 24 Aug 2026 20:51:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FE7BF805A8; Mon, 24 Aug 2026 20:51:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787597474;
	b=FL7XECCmDzsiZ1d2V7YOrRtp4Z4kEpyWUt7NDAVYMrHZsSf8vdAKhierEhFh5BF948i6
	 phPUTPtVOAUeyqwoGQBb3/1qYHLtlHHjyHrSOHL/gSJaLPhJWNLw9Ke9W6PCKX1jl3o1O
	 R+hVxdAWyodoo6bnrA7/XFYZoZ4W/AVk+PuyVKOWEypsYne1Avj3CsRgohYSgXe2Ao9sx
	 ADIN3zOKswgdSwyad+ytYXYwElDFJn9zRpI7jkMXAIb7ZYwgs7K1tc4Bmr11CvG29liBS
	 TXlu7rUKX4lI9Mo8Hw+7J7aVxdSJQy4afIAuILB7S8pEPGaTohRACDp9UMzUUMwxO1w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787597474;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=BfbMqD8wHnmnBeo/z3H58mRnHp0U75+ajQ/aYQ9IZfM=;
	b=mIhqzrlvOjt6JKxPLh4d5jCbmXpk4WHDglDvXkutE85jjZpeYyxBFyB2zr2n6BpGJZFj
	 fThB5iUTHq4UCVnkoKB7k3xCynXJzk459tmHO8FxICsHJ2dEiP7/45qPM7w+Xyv46igDc
	 /JzhnaR/Rn7CXbTjaMYabkY1Cd8ZzMEff1yrcLCJ44zprfx348C4FtVcgcMZ9w6Y/FX4p
	 SdPYNeXWZorBLuuTqfAMcd91DMQdF9CiuxKJcHwWqQFAsdDGpMhBMcyeqcbLN1hoKWuhx
	 QL0a52TF1z8nUbuHbmDr0wyYhxIQovexTQG8UUG9M1umdd6hUe8h9hyNRMptblflOvA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F1A25F800B6
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 20:51:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1A25F800B6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ced26e122ddd00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/838@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/838@alsa-project.org>
Subject: HDA: HiFi-spk: define 4-channel speaker layout when Bass Speaker is
 present
Date: Mon, 24 Aug 2026 20:51:15 +0200 (CEST)
Message-ID-Hash: PK2PGKSKNLHMKIYCGAWHAQ7GXUJFX7RC
X-Message-ID-Hash: PK2PGKSKNLHMKIYCGAWHAQ7GXUJFX7RC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PK2PGKSKNLHMKIYCGAWHAQ7GXUJFX7RC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #838 was opened from melcheikh:

### Summary

Systems with secondary smart amplifiers (such as Lenovo Legion Pro 7i Gen 10 `16IAX10H`, Legion 5i, and various Yoga models with AW88399 / CS35L41 amplifiers) expose a `Bass Speaker Playback Switch` control in ALSA.

This PR adds an `If.bass` condition to `ucm2/HDA/HiFi-spk.conf` so that when `Bass Speaker Playback Switch` is present, ALSA UCM defines `PlaybackChannels 4` and channel positions (`FL`, `FR`, `RL`, `RR`).

### Benefits
- Automatically routes audio across all 4 speakers (tweeters + woofers) in modern sound servers (PipeWire / PulseAudio).
- Eliminates the need for hardcoded machine-by-machine overrides for 4-speaker HDA setups.
- Tested on Lenovo Legion Pro 7i Gen 10 (DMI Product `83F5`).

Signed-off-by: Martin el Cheikh <martinelcheikh@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/838
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/838.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
