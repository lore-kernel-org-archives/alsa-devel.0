Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F7FFF8875
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:50:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 544D1601F8;
	Wed, 29 Apr 2026 11:50:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 544D1601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777456243;
	bh=kTKO4mS6pLo0hPtTdjmbJINOyF8SaLtAwPrQmQPenAM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RkoL1TMiLhgibqIq/mXkLzDNfMJczqTmdy0DJ9VIgo5CwEJKO28FM7yaVUZLx311q
	 e+QgCppnO4TMS3uiomymW5plxsNGYIGwLffkXnWw4UBi3wyV2Nx2vKXOPA+v+MYQEU
	 s7fXL98pFF5MJieKNdED8FY/OdLXo434ASS5hNm8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2536BF805F4; Wed, 29 Apr 2026 11:50:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1672F805EA;
	Wed, 29 Apr 2026 11:50:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8FDBF80544; Wed, 29 Apr 2026 11:50:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DE0CAF8016D
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 11:49:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE0CAF8016D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18aacafefdad9900-webhooks-bot@alsa-project.org>
In-Reply-To: <18aacafefd7ab900-webhooks-bot@alsa-project.org>
References: <18aacafefd7ab900-webhooks-bot@alsa-project.org>
Subject: amixer: amixer.c:1706: sevents: Assertion `res >= 0` failed.
Date: Wed, 29 Apr 2026 11:50:01 +0200 (CEST)
Message-ID-Hash: WCPZ6YNA7O4VXZRT3JEGLNWUN5BEMZHV
X-Message-ID-Hash: WCPZ6YNA7O4VXZRT3JEGLNWUN5BEMZHV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WCPZ6YNA7O4VXZRT3JEGLNWUN5BEMZHV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #327 was opened from mgedmin:

I'm seeing this assertion error if I run `amixer sevents` very soon after pipewire daemon startup:

    $ amixer sevents
    Ready to listen...
    Poll ok: 0
    amixer: amixer.c:1706: sevents: Assertion `res >= 0` failed.
    Aborted (core dump)

Background: I'm trying to mute the speaker during an automated Ubuntu 26.04 LTS desktop installation process.  I don't know what the best approach is, but what I settled on is to write a curting early-command that creates a /home/ubuntu/.config/systemd/user/mute-sound.service that runs a little shell script during GUI sesison startup, with an After=pipewire.socket, so that amixer can talk to the default sound card (which is 'pipewire').  This happens a bit too early (amixer prints `amixer: Unable to find simple control 'Master',0`), so I've added a wait loop that looks like this:

    stdbuf -oL amixer sevents | while IFS= read -r line; do case "$line" in "event add: 'Master',0") amixer set Master mute; exit;; esac; done

and, well, this one gets me the above-mentioned assertion error.

Adding a `sleep 1` before I invoke `amixer sevents` makes the assertion go away and then the muting works (but the exit doesn't terminate the bash pipeline and leaves amixer sevents running forever, or until the end of the autoinstall session, which is not a problem for me).

I'm testing all of this inside a Hyper-V virtual machine, for reasons.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/327
Repository URL: https://github.com/alsa-project/alsa-utils
