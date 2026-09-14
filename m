Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4978AC88E50
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:17:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26F49601E1;
	Mon, 14 Sep 2026 15:17:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26F49601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789391864;
	bh=8KSsQSgLZE0ywOXKAErIankbv816xUxPEh3eA02UeKU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Qar9XMJ1yQSN/U5IUpdpkSWXZQLjnxab5mwGeLbvOxHpEQSN/BW4ikq28rsoNKfHy
	 ANqyphjiz8ay6hWkFD6ZiSX/qC/vf/O4gXFX4pQUAkkzVl4nmimhcr/LWaGoz8zhe+
	 Y29okdmcvxXAm9TWHrb8qGpntCAs3BFz11tjWrMo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F8C4F80602; Mon, 14 Sep 2026 15:17:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E6F41F805F1;
	Mon, 14 Sep 2026 15:17:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 292FEF8049C; Mon, 14 Sep 2026 15:17:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789391824;
	b=am/qyE98P5EWdgKM8c9YIbuXTMpeiDI6o1XJINIEI3QUr9qRI7m2fZ6tdjtIrAfgG/KK
	 kvPZArP2ap5TBnnH8fzAd6yD5zogqgQkcnXu5tigQRtGPC9ta28r0F9yefqT8Ex0ji2bg
	 j0qo8gMygDyCp0oY2B2PSVcnDCQvIsYrQMAFg3sgxfQd7rmcs9o2wpBi2yp/djwPcOxFf
	 IAvKRFylFDpqKH6DfLyHTyquY5I2l7/BzTiOqKF2hpMpWMHhKrU1QL8X6xCFmrjj6T/xI
	 dAUe/XnmTBFXbqzRYk6baXc0qTFPCIW1Rt6PvBytM1t/cZdOYntjtjyHzcWC8/2sD7w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789391824;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=8KSsQSgLZE0ywOXKAErIankbv816xUxPEh3eA02UeKU=;
	b=IIzeSpU9Xins2/A/IhmYXfaIbFYYEEDMoKRQkT3+DbPBuRQIgfE1Z9WW/rVkgytyLvR4
	 0aiQzkq7etwKYJgOxdOVjAmEtbma2nsQfgfDhzAqO6lClAeBjKL3X3T5MK4//mKl3crQ2
	 d7s96DBTqiNWiTrTRnaZ8LxPoQLziUCyv3hJYvgCiy9VLq5wS4ch4+4PMxVhVFDHOM+Ja
	 6ZM/X67C6l+lyNx+0TKbfP53x/TgP5UulsghmDVGjhDavfLRjzdn3iTlrv+RwVNk+1CtI
	 Ab7LQIzWqWwl+9ayDlv5d2OLo3g1gMvJoVuAjmC57rsZS5Ei6Ihn2Kl6072+DKeFU9w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F59CF8027B
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 15:17:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F59CF8027B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d53261ecfae100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/855@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/855@alsa-project.org>
Subject: sof-soundwire: fix speaker init include for combined codecs
Date: Mon, 14 Sep 2026 15:17:05 +0200 (CEST)
Message-ID-Hash: 37UMWBDKXJH7UUWMR7IQ3427MZVXSOVK
X-Message-ID-Hash: 37UMWBDKXJH7UUWMR7IQ3427MZVXSOVK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/37UMWBDKXJH7UUWMR7IQ3427MZVXSOVK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #855 was opened from pgavin:

Since commit cd342774cd02 ("sof-soundwire: cleanups for codecs with multiple functions") the speaker init filter regex is not anchored, so a combined speaker codec string like rt721+rt1320 or rt712+rt1320 also matches the single codec names from MultiCodecRegex. The config then tries to include codecs/rt721+rt1320/init.conf, which does not exist, and the whole UCM configuration fails to load:

  could not open configuration file .../ucm2/codecs/rt721+rt1320/init.conf
  failed to import hw:1 use case configuration -2

PipeWire falls back to a stereo profile on PCM 0 and the internal speakers (PCM 2) are never used.

Guard the regex with "=" like the other multi-codec checks, so only exact codec names with a codecs/<name>/init.conf are included. The combined codecs keep using sof-soundwire/<spk>.conf from HiFi.conf, and the rt721 codec init is still included via the headset codec, as before the cleanup.

Tested on Razer Blade 16 (RZ09-0581) with components:
  cfg-amp:2 mic:dmic cfg-mics:2 iec61937-pcm:7,6,5 hs:rt721 spk:rt721+rt1320

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/855
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/855.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
