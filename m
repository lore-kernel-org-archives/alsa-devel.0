Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCA606A334
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=GPQwpcm8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E13C601F0;
	Mon, 23 Nov 2026 09:59:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E13C601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795424409;
	bh=MlaIheFWHf1pZDCBYnqioiMugAg18VUWrCsrFA/7DAA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GPQwpcm8BmiYhLpyM2FsdPypyGdqyOoNnQCeF5XOgtUHRn1l+OoicIqd6lsY++i+7
	 KnZf4zAWb+36/6KDt/70KE7ShkERUdrDyNBiJgLvOQOHcNiMbutm/VM6q6gUEuSfA5
	 MYB+PWp3JN+7IXkhJWE1tJpWXSbNAw9yI3O4Lv4Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9687F805F6; Mon, 23 Nov 2026 09:59:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28EBFF805FE;
	Mon, 23 Nov 2026 09:59:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF5DDF80552; Mon, 23 Nov 2026 09:59:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795424366;
	b=BtPXePAa7c6LzyaYqWP0MbO5LV3x3C0rxFKVhBjjAViwXlKu0DIoiEcp3QaiX+eXv+P6
	 xl/XgMeskxyfZLJa8PqJRmYJRuqVPtKU7y+Af+T4+xHw2RoDgR489Q1iJsqyS+l3l/LkC
	 XBHiL7YR/tTn1b5R7wFKSCjOcafZGSlC7Pwo9NSeNuI7jOxwlTP3f968QDknPcEoRxH+L
	 NoUvgRigMry/+5gMeofkaSqc+evokJGcA5+MzFQuc5nYAakLnfaeElTTU5BvuUvxnAC5d
	 H9U0GFsHeZhXXJ28Ty7BR3QjfsnIaS+K+zXe4qpjJdzT940mT91OuMGFik3ehB6SgSg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795424366;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MlaIheFWHf1pZDCBYnqioiMugAg18VUWrCsrFA/7DAA=;
	b=an5aCkui6ayZQPX/a5dfyq6G+eHEm1eG45TGI57JfmtLKFYN4Kf7kxGhRTKPei9Emt3V
	 OfzbaYjKe8WqO6zs6EmTejXdvTOyQpNtCWLEKXmpx2bAHb7XgtR+B1dBq6YbH0FrTh+dc
	 76a8gKtZarPYVhDVGVb3O6nX2LwJe0VaO5A14BqkNcOoUU1+mWEFMbFlDQRQx7FgoykjZ
	 NKDW3T2Gl+vh8s0SdLywcEAXyCQlYHvlEY743b8Ae9GagaeBT9r4TnaNFh7fNynKMG1R6
	 Qsllz0ESK1IC9W79WIMhgoo9qn2b07mR7Fz5I14XgEm+1m20IASgcgZbHjZC2XDVBiA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B19BF80495
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 09:59:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B19BF80495
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eaa0f260b88300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/923@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/923@alsa-project.org>
Subject: ucm2: Qualcomm: RubikPi3: Fix HiFi routing and codec controls
Date: Mon, 23 Nov 2026 09:59:27 +0100 (CET)
Message-ID-Hash: N7AJGS6UWKX6FRK7R2QNM4ZY2NJNTVHU
X-Message-ID-Hash: N7AJGS6UWKX6FRK7R2QNM4ZY2NJNTVHU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N7AJGS6UWKX6FRK7R2QNM4ZY2NJNTVHU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #923 was opened from hongyang-rp:

Match the headset jack and mixer names exported by the ES8316 codec and the Qualcomm machine driver. Use separate headphone and microphone jack controls so each device follows its detected availability.

Enable the ES8316 DAC mixer paths for headphone playback and select the analog microphone input wired to LIN2/RIN2. Add device enable and disable sequences for the three AudioReach routes while retaining the verb-level routing needed for PCM probing.

Use S16_LE for all three PCMs, including HDMI, matching the updated RubikPi3 AudioReach topology. Initialize the codec gains and set the AudioReach Q13 playback stream gains to unity (8192).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/923
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/923.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
