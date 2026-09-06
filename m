Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC13C79F85
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Sep 2026 10:49:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EFA1601F1;
	Sun,  6 Sep 2026 12:49:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EFA1601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788691756;
	bh=1f+2/q2qGsFI2KtGU8YsT70Hx9EUMKWY0XEQvR0I1Co=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MGy23udHUtTKYPqM4JJz793r9MQwfI8et7hggCgQGH2Kjy/cofCEFFcpNFN1rv991
	 9AQ0QpiExrtu+UnDo4uuhdH9uYhXL5Wltdb7/+qHVmITBUCgbomqJO2ednIsK2cYE6
	 KaiW4x3nJuf6jse7zJm52ovi9hDOTmOBdNvV0wvw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59573F805FB; Sun,  6 Sep 2026 12:48:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1450F80153;
	Sun,  6 Sep 2026 12:48:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 413C2F804D6; Sun,  6 Sep 2026 12:48:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788691713;
	b=g65iPPSakU+2EHGEEjqAo+B04AY0wSCOw19+YjHsasl60xiWfWxqLxvwPvNI1wuKHmuc
	 wWfjOFzwrU+jiEWKeAte52MwFF7NREADNF/GFG0buF6PyE5Y6FkF0g+4+Bbd8GJa1MkVI
	 fcCIcphQ9M8EBDyeGolE0SyD4XFPJ5ei73OEPbrADQTNRnlnTAD0e3W9cYyZcyz80mLTP
	 hQP9K6ev1XFMV3OMhO32sOxjYY5OSq2m27IurXx+SxhwLmhb2pm8M6h5kln+BFSSFL8cS
	 HhMu/ft9pjKi6GOOvoO2qAmFGpSokLuVpCp8/YAetT0GYUfHTOrY//e+Kgna+gYDU3Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788691713;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=1f+2/q2qGsFI2KtGU8YsT70Hx9EUMKWY0XEQvR0I1Co=;
	b=S5uibO3gv2jWLnhDqFKNhALb3smjQ1wXeVBf5gm9sGZRuXoB0NgCx11LOR/zJSv89ZzQ
	 wrajyz48joK4HPRMUWuCk1iof/j1rMwr1eOkfWpexfE4pDM8G4bijsLrYxnFrQzYeFHhH
	 8ojIvLiVs9y3g6lNk1MFQIV4BdoJfPhKVH0c4jpg4pyimpRA3SNF6kMESP3/evHqlFkMD
	 VpPF5sniZsU8UTOTK9KN4dW79fQ3PbKx5OlepXpre/Y8XB21iq4mcCVogp0zUN/oEEmgn
	 fORMZuH3gOXdFm/yV/9MBKElu4lV3JVEejZyuml7PtH9aS9Rf4J6fNmCgvHlnPqjorQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B2A7F800C1
	for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2026 12:48:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B2A7F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d2b5a27bb7b100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/852@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/852@alsa-project.org>
Subject: ucm2: codecs: add rt721+rt1320 companion init configuration
Date: Sun,  6 Sep 2026 12:48:34 +0200 (CEST)
Message-ID-Hash: 3XMVIBMTVCTMU3C2G6J7R7NRFLUBNIW7
X-Message-ID-Hash: 3XMVIBMTVCTMU3C2G6J7R7NRFLUBNIW7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3XMVIBMTVCTMU3C2G6J7R7NRFLUBNIW7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #852 was opened from sri-sandeep108:

Add `ucm2/codecs/rt721+rt1320/init.conf` to support machines using the Realtek RT721 + RT1320 companion amplifier combination on `sof-soundwire`.

### Problem
When the kernel SoundWire driver detects RT721 and RT1320, it emits the combined component token `spk:rt721+rt1320`.
In `sof-soundwire.conf`, `SpeakerCodecFile` remains `rt721+rt1320`. When attempting to include `/codecs/${var:SpeakerCodecFile}/init.conf`, UCM fails because `/usr/share/alsa/ucm2/codecs/rt721+rt1320/init.conf` does not exist, causing the entire soundcard use case configuration import to fail (`-2`).

### Solution
Provide `ucm2/codecs/rt721+rt1320/init.conf`. RT721 initialization is handled through `codecs/rt721/init.conf` (via the headset branch), and RT1320 mixer controls are managed directly by `sof-soundwire/rt721+rt1320.conf`.

### Verification
Tested on Lenovo Yoga Pro 7 15IPH11 (`83SN`, Intel Core Ultra Panther Lake with RT721 + RT1320). UCM imports successfully, exposing HiFi playback on speakers, headphones, and multi-channel DMIC capture.

Closes: https://github.com/alsa-project/alsa-ucm-conf/issues/851
Fixes: 196b79b04126 ("sof-soundwire: add companion amp config with rt721 and rt1320")
Signed-off-by: Sri Sandeep Sakthivel <sandyorton7@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/852
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/852.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
