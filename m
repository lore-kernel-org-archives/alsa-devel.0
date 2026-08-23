Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DE8C5DF8C
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:14:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E58C560255;
	Sun, 23 Aug 2026 21:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E58C560255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787512459;
	bh=CPurG1r/MA4NgqE3pM43sZ5eX8U7x2ByrOXJUGNEWck=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bOvU8HH0H7PKZhx15OV3X4BRoxYcK/kO/+tMCN+7tyzjPFzJwS48jExYJvEri/iLq
	 c0vnY/Zc8puVbyrLgxfUt5DojoBmnPCXb5a6rH6tmIgXHH8FHUlf145+/ZpCZd9RVh
	 wYY7ntAGDBWylAUoXg2zJDy7S8C/558VStBWm0nU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F50CF805F5; Sun, 23 Aug 2026 21:13:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 805DFF805F5;
	Sun, 23 Aug 2026 21:13:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3EDDF8055B; Sun, 23 Aug 2026 21:13:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787512419;
	b=QWhixQpzU6xcMDa10QMx+Xi8OSskxsBnHeScqW+prxdQBihyNKG5sg/yHrRb5YYDNft4
	 7w3u0v2EEwkz1Dw5CRPRzlGsWM0ZzdN1SOmQjv02T5wt3nfIqfL8QO0WHo6ueW8mwrDNJ
	 lh7i9Yl7z7f+DSu+b/9JQ6yIWt2SPxIh/hD8i1O7/hSLZ7hgp1KWJaaxO413jSgGRqkjK
	 v1SbVj9J3xPRxGK53ruH7woOrjSHuPnaet5fI6hXz++uFlLuRzh4aOP6Zb9W2E7Wyymvt
	 gmE+CpJbqcl/UGWHEiRvOPAf6PFgRBQf0NWavWRejjtGqWZw6W4mqoKeqZJPy66ODSg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787512419;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=CPurG1r/MA4NgqE3pM43sZ5eX8U7x2ByrOXJUGNEWck=;
	b=BeYBGcRjyW4gNLAjK9KYDjst/ERg8Rj4cCkyyzq7a4NtDRxGUrAeNeP2SFN+QpUHlIQz
	 dUoBYJYDEbF4GsY1ux5XkkEVMI4B4U2pl/uJ7OtVBjWjFxcuLXfKUjL6V/mZ8rpiUc2bi
	 UswyDEkDPIuCXSGkYIFRiOVWpwWmjK/04QB/weFvrJdQgVEXDBSLjRhFcci32oq9wDfhb
	 Z8WkQI8IyFzWEbd3TMrDxT7vgVD5NRxn6OzUWJYOgE7Bzlg6P/NUqISJNHdEvWL67jtxG
	 VGW/HygLsrPzWVUdPmsX78QWasD0FaR9oV8k1UiOmU7B/34aWKVJ9rjPiYTIs0GT0TQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D7AEF80149
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2026 21:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D7AEF80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ce8512bcfd6600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/836@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/836@alsa-project.org>
Subject: USB-Audio: Add Audient iD14 MkI (2708:0002) profile
Date: Sun, 23 Aug 2026 21:13:39 +0200 (CEST)
Message-ID-Hash: SBDXYYS23CK566J2K22DVX7LP42BACXW
X-Message-ID-Hash: SBDXYYS23CK566J2K22DVX7LP42BACXW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SBDXYYS23CK566J2K22DVX7LP42BACXW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #836 was edited from willyp713:

Add UCM2 support for the Audient iD14 MkI USB audio interface (`2708:0002`).

The HiFi use case exposes:

- two logical stereo playback pairs (`Output 1/2` and `Output 3/4`)
- two mono analogue capture devices (`Mic/Line Input 1` and `Mic/Line Input 2`)

The Direct use case preserves the raw 4-output/10-input stream for DAWs. This follows the existing iD14 MkII profile's policy of leaving the state-dependent digital capture channels out of the ordinary desktop profile.

The device's FU12 monitor-mix volume behaves asymmetrically below unity. The card-level `FixedBootSequence` initializes all four channels to 0 dB on boot or hotplug, including when Direct is selected (Direct has no verb). The HiFi enable sequence reapplies unity. A `ControlExists` check supports both the historical `Speaker Playback Volume` control and the `Monitor Mix Playback Volume` name from the accepted kernel quirk:

https://lore.kernel.org/r/20260823015353.686080-1-mrwillporter@gmail.com

Hardware-tested on Bazzite with PipeWire 1.6.8 and kernel `7.2.0-ogc4.1.fc44.x86_64`, including both playback pairs, mono inputs, Direct access, channel isolation, software volume, and a physical USB reconnect. The current upstream validator also passes against:

- alsa-ucm-conf `00175aa645c482111d096c3d8230f182a875d286`
- alsa-tests `53d34b6`

[alsa-info.txt](https://github.com/user-attachments/files/31353347/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/836
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/836.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
