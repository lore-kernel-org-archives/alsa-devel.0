Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D990C88E53
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Sep 2026 19:43:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC21B602B1;
	Sat, 12 Sep 2026 21:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC21B602B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789242229;
	bh=+S/q95GIDQ7s4YNRtR0KVQs/wJwmlnkVJUHw93ROiuk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=de2CLxyij5w3FUPpa/P4KeIfzLvLkrETQJ08uWaWbFHe7PaXg2gjeMewO1X8K7R8n
	 g+KobC6BQqkXJNDurh76QXgpbOX9i8ZuZeojk72rPVNYNIJnHqGX+frQYkQizTHG8f
	 RHSSAAMVV5+0E3Kee0P6PwCj1QUxmxrSPKxcXkHs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DBE3F805FF; Sat, 12 Sep 2026 21:43:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9A98F805F5;
	Sat, 12 Sep 2026 21:43:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98E50F80544; Sat, 12 Sep 2026 21:43:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789242187;
	b=USP+hLzpX3PAoNExbzDsvJacul0Sp1yw1aZpRI7iWIsu/QP6wPXAghe7Qp9RtF0pKY27
	 oDSwGgVkUIsoGUV8IT8E1xcuC3BzVMVnY9ClYtmsSSsH78KvzlNuZNRPgmbi6bLejiaSF
	 gXFlY6JPIB4EW+C0KLJ9FKr4icGLfBJRqUUtpS8W7D7p9elFmLmJtaOQwebeGd5QHdDaY
	 RT1RzB5h/ihic5jGaaCfA2w0ryzgVOJkXLOTq3ydLESpg/jQwIGbIWtD7kSYJ6KgqivFZ
	 Da6A+j7yeyxRyL+NMMZwO3y9zo9i7CbY15HSijbnq+GA0lc9wY+seGmFxPPDa8J6FJw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789242187;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=+S/q95GIDQ7s4YNRtR0KVQs/wJwmlnkVJUHw93ROiuk=;
	b=aNnx/8EVTy0O3oo/G+d866Dh2Js6Ir/SdN8ItiQiRg+ASxpAh/ZhF3ErnmFyArOitU5u
	 wKlOpSnuLjtdDIPCcNdM6kyX2GcENOfmOF0IaylG5yrF8/8J8zqHWpM76D+ZmdHawiFoL
	 T98Zn9+8rg5swQX1m2IuhpgFB37M+3i4ak9rc3dPBrBM78K3b5hw+QdCFhBCEnFRL0uHD
	 fPyI6jxOS7q+k+X3rKkyIIOgkvQtQPDdVICwkNhVpn3zKRto50aRkwpmitcT+NU7WsvxS
	 fZYfluzVNDq6M4yYoc+2ysL3rMi7lgrgZmmCL2v4E1Z2Rmkl8WN0R1FIgmlfd4zNXaQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 96BF5F8014B
	for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2026 21:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96BF5F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d4aa49d6dfb700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/854@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/854@alsa-project.org>
Subject: USB-Audio: fix channel count for SSL 2+ Mk II
Date: Sat, 12 Sep 2026 21:43:08 +0200 (CEST)
Message-ID-Hash: UARR3ZFRUXEVWWVLSZWS535LAGNNQXVJ
X-Message-ID-Hash: UARR3ZFRUXEVWWVLSZWS535LAGNNQXVJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UARR3ZFRUXEVWWVLSZWS535LAGNNQXVJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #854 was opened from zachberger:

The "SSL 2+ Mk II" reports the same USB product ID (31e9:0009) as the plain "SSL 2 Mk II", so the existing detection based on CardComponents and bcdDevice cannot tell them apart. It has more physical I/O though: 6 playback channels and 8 capture channels, vs 4/4 for the plain model.

With the previous profile (DirectPlaybackChannels=4, DirectCaptureChannels=4), WirePlumber rejects the whole card:

    spa.alsa: Error in ALSA UCM profile for _ucm0003.hw:II,0 (HiFi: Line2: sink): PlaybackChannels=4 < avail 6
    spa.alsa: Error in ALSA UCM profile for _ucm0003.hw:II,0 (HiFi: Mic2: source): CaptureChannels=4 < avail 8
    spa.alsa: Errors in ALSA UCM profile for card SSL 2+ Mk II

...and it shows up as "SSL 2+ Mk II [ALSA UCM error]" in wpctl/sound pickers built on PipeWire.

Disambiguate using the USB product string (which does carry the "+"), read via sys-card the same way bcdDevice already is, and set the correct channel counts for the confirmed "SSL 2+ Mk II" case.

The If.chn4 gate in SSL2-HiFi.conf that builds the split Line1/Line2 output devices only matched DirectPlaybackChannels == "4" exactly. Broaden it to match "4" or "6" so the "+" Mk II also gets routed through the existing channel-splitting macros (which already use the variable dynamically and needed no other change).

Tested against real "SSL 2+ Mk II" hardware (USB ID 31e9:0009, bcdDevice 0116, 6 playback / 8 capture channels per USB descriptors). Before: card flagged with [ALSA UCM error], no usable output. After: clean profile, Line1/Line2 both work as separate stereo outputs, Mic1/Mic2 both work as separate mono inputs.

Not extended to the non-Mk-II "SSL 2+" since that hardware wasn't available to verify its channel counts also come out to 6/8.

[alsa-info-ssl2plus.txt](https://github.com/user-attachments/files/32149222/alsa-info-ssl2plus.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/854
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/854.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
