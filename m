Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D7FC5DF8C
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:03:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B28B60250;
	Sun, 23 Aug 2026 21:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B28B60250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787511813;
	bh=UWVhzYPFDyzoxS600DIbmt+oywJSLcKWvCVruiX6e74=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XrIpB1AbWcmxYs3ajYo9ztpdqAS9I9vfFBTreyKMJ0oalX5ogOBFluWTSVkUuI/9l
	 vsvTdXtAaqgXG5FpCPE9MpQg8MaA3PDczBTw2af0dswy3GJbLruJF7prCrXAKm9LAk
	 6RbGQ6RBKNXoLvFKxftmkQ3Ei2LYrPE5NONpA35I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5B98F805FF; Sun, 23 Aug 2026 21:03:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B907F805FF;
	Sun, 23 Aug 2026 21:03:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0628F8055B; Sun, 23 Aug 2026 21:02:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787511773;
	b=TlTWmD/NGusFMQLr8xDmdjFyBATO6XTuClhGCqq0AV9sjVB80flHlqqFdagKsQFHNU2Y
	 NxDeV8mtSFPT8iZqxaAe8avUjE2ca+YTnigN6CpWW3zrAT4zzJ8gcDf6MF7jBqkOfSt5Z
	 /3i9V7/Zu7uC36TqYN+cdD1TC5YwAnI27mAp9nfuhyAyrNSo05QPWsymhJkVqqRz+a4PT
	 iauUFbNJ8m94I0mX00pEUyz/12tH/HTwK2uRnclR4OPKXbZGqVrH0wNiNH9nwic5c5evh
	 rdWFgUd8F/L4VEEHEee00bjQ5jwWwRd2eQ7u8ldi9FTe2QkGqmdkMNWD+3KzJYJTlIA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787511773;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=UWVhzYPFDyzoxS600DIbmt+oywJSLcKWvCVruiX6e74=;
	b=EnzQ8j4mtXzT/52Bv260iauqs5Kps3vd6Af59sNiS79w60RCAtbvftnXevHtVQWwSga9
	 2uIDYQSfjXX3JZANVvPmFu47vUOsnedLMZCjooldBVB5UNUNGY14N0N4glywxt5+N1Z1G
	 wH6SVCCFiD1Jf4VatSLxkm4+GCsm6YDMHlJ16O1KyepuQ3ogqohCq3zbjWW76m/fDglyT
	 hsPHwolmg9aNMvQUFH3LwidEZV4OHL9nGo/o+ZyaR3ncejvjLPPhFze7afYQLd/eskEF8
	 lY3HRqiO5nXdHJOi8NLHCiXKsjowtc7PX15dzUZUtTWrjeGd3pQ0kAlXgFOcLwIP6GA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1347CF80075
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2026 21:02:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1347CF80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ce847c53b4eb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/836@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/836@alsa-project.org>
Subject: USB-Audio: Add Audient iD14 MkI (2708:0002) profile
Date: Sun, 23 Aug 2026 21:02:53 +0200 (CEST)
Message-ID-Hash: YKXLQ2ODMDJV7UCEDHK3UCQX46XRK7SR
X-Message-ID-Hash: YKXLQ2ODMDJV7UCEDHK3UCQX46XRK7SR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YKXLQ2ODMDJV7UCEDHK3UCQX46XRK7SR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #836 was opened from willyp713:

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

The required `alsa-info.sh` output will be attached to this PR.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/836
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/836.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
