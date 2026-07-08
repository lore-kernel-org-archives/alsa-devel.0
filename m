Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB6C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:09:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 103C860228;
	Wed,  8 Jul 2026 08:09:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 103C860228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783490965;
	bh=vDA+i3Va7xW4Y1EguS2pa3/pCicQk6/3oUVjqBGvEpw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gJxN3aNR53PB3wBAhi7v+eJoNUR1kgsL9oP4pGtq0TLodXfniVIRtN2OqMNK5gJzA
	 vphkoSwx80OtiG02+D/LrFtEFbNR2B03KOkPca4VzJiA/k0QRrge2tB+WpjvUD0VKE
	 PRvlnB9ft4DXr5z0CL/KVoFjyo9gEJ2HzaL4+npE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D616F805F1; Wed,  8 Jul 2026 08:08:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 726D5F80601;
	Wed,  8 Jul 2026 08:08:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52B13F8055B; Wed,  8 Jul 2026 08:08:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783490922;
	b=kG2aqvvxFx201JgdJsvrOZJfNEYj25FOOiXBM21GutY4F0y/eZM463nBZOcdjtp+6xtB
	 XoKvXGO+3Id4ObsAbtOn8YXcqnvJVCVaFIGygYKxxYRVfeVEmN0fk+OslLbZjRHjUh7XI
	 tvc686d7gzwHZmsRV1Mglxn6LPVjimOmyRF5r+KZZdZQI04sXh/iDS5Qjlf8O07+1w+SV
	 KgBFAkQyvU7Q3UcHmeWcu4aEcYR1So59+vEWjEEu+A243b7z0ZI1/ts4CaTusbP6I2oIi
	 i+7JyxCaxUu4yRV9m7QV4SEgcbq3PpVPkUdiSGp4sHGhcLGi14zbUzM3aQcrubcxr2g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783490922;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=vDA+i3Va7xW4Y1EguS2pa3/pCicQk6/3oUVjqBGvEpw=;
	b=L79RxDS0FP82X1InDRtZ/jRYp+bXzjwYRWdahbpElmfqaERaTFqfB8mQFQ19p6M/QYyC
	 qXfA6VBqyhSLIg2q62ZeTzHUXxm8mR5r5GQZELgD5de0/KLkdgZ3LeappYmWh6QEE9TVJ
	 4Y5R1JRgcSdwbWmtmbhgEcicZNLfmC257PeS6Fp0rCkacciu5ngjWXqqA+3OU3lkDIJSL
	 q4CWz++twT5a2x4OISiXxvBScHQrGigVQsFuO9hDlsT0jikxOK40qlX5OgHhwkZ+fQPOz
	 jvvqe5f4OE0swxvIRgO0uJkJK4K/j7wb0G18/X8TuayQzgtX/Kn/v8eSw9lQOP4/+8g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EEE4EF80224
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 08:08:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEE4EF80224
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c03b8af5dc6400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/808@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/808@alsa-project.org>
Subject: ucm2: sof-hda-dsp: Add Lenovo ThinkPad E16 Gen 1 (Conexant CX11880)
Date: Wed,  8 Jul 2026 08:08:43 +0200 (CEST)
Message-ID-Hash: TRIWI2OWX4LHWURGYQRH753GVHTKI5XN
X-Message-ID-Hash: TRIWI2OWX4LHWURGYQRH753GVHTKI5XN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TRIWI2OWX4LHWURGYQRH753GVHTKI5XN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #808 was opened from lavicitor:

Adds Headphones/Speaker ConflictingDevice pairing so ACP treats them as ports of one profile rather than two separate profiles, enabling automatic output switching on headphone jack insert/removal.

Also corrects the Mic:hda device's capture controls: this codec has no Input Source/Capture Source enum and no Internal Mic Boost Volume control, so the generic mic heuristic in HDA/HiFi-mic.conf falls back to a branch that references nonexistent 'Mic Switch'/'Mic Volume' controls. Point it at the actual 'Capture Volume'/'Capture Switch' controls with 'Mic Boost' as CaptureMasterElem instead.

Tested on real hardware: confirmed automatic profile switching (Speaker <-> Headphones) on jack insert/removal via pactl, and functioning mic capture volume control, both previously broken.

Board: Lenovo ThinkPad E16 Gen 1 (Intel), model 21JN00DLSC
Card long name: LENOVO-21JN00DLSC-ThinkPadE16Gen1
Codec: Conexant CX11880
[alsa-info.txt](https://github.com/user-attachments/files/29786109/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/808
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/808.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
