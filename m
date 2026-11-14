Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CF606A327
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OTY9S2GB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 745F060201;
	Sat, 14 Nov 2026 13:54:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 745F060201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794660904;
	bh=jTjKynREd0BfOt5/9bFsD4guCNCyHql6f6b1jFZUcbw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OTY9S2GB8X++Uom6+QA09MEkE3fjRQAF/UPD2oMxY4juOLWev7y24sQaVRhWzY3ps
	 EcEropLL8ZRaB3SDUG6Ju3JcCKWzZ/Hg2Cys1i+QuWXx7tcfeKTcyqsfjImpOG7DW0
	 +fuoOn6JVggZ3Nj7UmIAlyq2K4AX7JBka3PnIqOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BC9EF805F9; Sat, 14 Nov 2026 13:54:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17AE8F80601;
	Sat, 14 Nov 2026 13:54:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECF24F80580; Sat, 14 Nov 2026 13:54:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794660860;
	b=pxBLilaHcRzfdJ18QTw829s76CG2UQ8/hQEUNPLHSoHnM3xxg+I8piXHrVlRIB/oM/wG
	 /K7OQIEfYK9LjOwe/gyKYzeJ69+Ds63MMg0LbSdCRbXsDNTh2RAQJlynLeovdR/1evkzq
	 4VAHbIfSQ5fwrTsxnlPHRhypcwq16HxcpCigre59Wgua5cAeTimZbhj2cRV2liRYNC4zf
	 Iu5ajfyaVSzHUpQG4ffGDZ6/eM8or6FvA5d783aylSy72Mw7zr5UNzgFAggzu75XYak3Q
	 4jZPeu8sXlH6YhxIxiNUHTQQnyXZIcWvAw8RL9mxQniGTBVSKyJxRv+JtaaehyvJUww==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794660860;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=jTjKynREd0BfOt5/9bFsD4guCNCyHql6f6b1jFZUcbw=;
	b=q7V/hTacU4tK6ofAdEJyiKKTv7QR7o3gf4Cee6fqK3L6OkZbuinETsJEURq0lssf2i+3
	 0Ba8WlfTxJSjKHHlzU/m2jaw7Xvcn5szyqUTvH5UPHLHmxKV+kcOdnbvOd4P3foX6/vnY
	 XMmD2hGOpHdvPE41ijYeYAHYr2nGI5QhP4UoocHL1TEJLMgHrCCyL11aS1Rm0aKY0f8pr
	 Of3Zst2+DQiCARIGHKf4L2dll5dY0QLLuD+TFjI1NgsVP+7Rg7LnwMuVWtxJfUdXa3Dtu
	 XOo9LKFUSefFkVsV27PL9plKzn98ZDor0RjpZxLpUcfMg9f03/WZ6c/S7XRqXSGuS6w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F3F6CF80095
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2026 13:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3F6CF80095
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7ea8acd1cf700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/912@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/912@alsa-project.org>
Subject: sof-soundwire: es9356: default the DMIC gain to +12 dB
Date: Sat, 14 Nov 2026 13:54:20 +0100 (CET)
Message-ID-Hash: LFQVGTG5S45DNLTSACY7WOWOKLIIZ2T5
X-Message-ID-Hash: LFQVGTG5S45DNLTSACY7WOWOKLIIZ2T5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LFQVGTG5S45DNLTSACY7WOWOKLIIZ2T5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #912 was opened from kannoy2024:

The internal DMIC capture gain control (FU11) starts at 0 dB, which is too quiet for normal recordings: the four steps are 6 dB apart (0/6/12/18 dB) and 0 dB leaves the voice well below the noise floor, so the internal microphone is unusable until the mixer is adjusted by hand.

Set +12 dB in the EnableSequence of the Mic device, following the pattern used by the other codecs (for example cs42l43-dmic sets its DP1TX inputs in the device EnableSequence).  The value is still applied through the normal mixer control, so it can be changed at runtime.

Tested on a MECHREVO WUJIE 14SAH (AMD ACP6.3, ES9356 on SoundWire link 0): setting the control to 0 dB by hand and then restarting PipeWire results in the device being enabled at +12 dB, and recording from the internal microphone is usable without any manual mixer change.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/912
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/912.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
