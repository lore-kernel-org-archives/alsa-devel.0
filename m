Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E251CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:43:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39B0160289;
	Sat, 10 Oct 2026 21:43:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39B0160289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661394;
	bh=GfWxa8ttEdOMSsaD83nYwxkjvSYjAL4dECdJ4H/OZYo=;
	h=Date:To:Cc:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Uo9tCwDRzNPPklX42euLq6+r4k0HwM675URFNWd9J0s+B1IrA0nNYf8graB2o6g1g
	 zV19wX4sIqTTE6oD1Z0b9eJEFYxAimwCIl6H2D0TnunmrQ5603GDrErA8NVESnvWlD
	 n7Nwj/wtsHlrLGXntceTCM3Ajh/b4UlqV3Ko5IE4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9BFAF80695; Sat, 10 Oct 2026 21:41:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ACFEF806A3;
	Sat, 10 Oct 2026 21:41:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 195AAF80557; Fri,  9 Oct 2026 21:24:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.12.231.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791573889;
	b=oUJah1yk+nA9N7Jib3YW7JVghAV7V1NAGgbsVB6jL7xZu/47hxWORo9rjVlwBFbGqqGe
	 1+DEwDWjQEuhJy1WJsEgicFwQobHbsH6kHo3SGF980Zql65AqLGOvcDISAFWqT37gyPLp
	 AWZoH8ukuinAs+WuXCwkY1BX9s1iaMdk5iWkwKARk8Y+a/rAFj5Z51kwRwVSSz9smqQaA
	 q1fkoa4DN9QLZMUEfuJ0E9Pb9m4bH3urqGCiBkiuX3XAGoHu7/R6TkKuKCXGganoW0olk
	 odZYJnERjUJSOLWpTbnDqDw4Uhvt1szkVlAadezGyL6MsMYAeeGMDfvj+KQriCPXnZg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791573889;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:To:From:Subject;
	bh=GfWxa8ttEdOMSsaD83nYwxkjvSYjAL4dECdJ4H/OZYo=;
	b=N3WQrrZ906GMX4CVcvQpWSkg9R9iDdGRKR45rh8uhVBBgFB7cVhMMZprntEGSuV/6fHz
	 /w2uR8I6js7ZhF4/P7VMzZo/w3eEu6hgYGYgJCw03HmBIEGKd3GYN+Gl7GDFtPeRW/8r9
	 95iXTTmMCasug2woROhcNqDipJENfNHSZ4VKRwjS2ehcScUDwVEByXSZQw0RczP28cu/j
	 Go0TOFPdIRjh4OraXXjXXllxZP37jnY4ZKg0v9ar4nEIu50GxYvzhqCk1h97CWS70lFxa
	 rSo5UMOlGu715/2DPltYwDo2hhDHy+7AZHWrF3TAf1oC6ADGNXk2jIVRoSlA+wz5iOQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=16bc.ru header.i=@16bc.ru header.a=rsa-sha256
 header.s=dkim header.b=GwS1tgOb;
	arc=none smtp.remote-ip=185.12.231.54
Received: from mail.16bc.ru (unknown [185.12.231.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B6A5F8026A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 21:24:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B6A5F8026A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=16bc.ru header.i=@16bc.ru header.a=rsa-sha256
 header.s=dkim header.b=GwS1tgOb
Message-ID: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=16bc.ru; s=dkim;
	t=1791573883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5TClRSHvBLuqjNOR2UuxtWxKbF4QbqomqI4ILgEdNag=;
	b=GwS1tgObUUdAVsKGAjObtQF1u1D0G5W8IHW4X3a8idCVAd2AT7eeFnPd+9NXNopvuS3NQj
	et8bP4F2BogGOd1IIELKt5dWq3ZSNdKpF8MS5V6+3Q/LmJ1wDIBVpLUE6P17JQTw572xuw
	DA3gophGVPZ+bhO3Doy9B3jmH6zCMBMgBXKNSDScTl+R6mKWKKHgkZQEwLn1cuKFR/5D69
	WTFyTXzmfZ/4SyxRuXzMms1QtIbdGlD9V/Xs+csvWoyAfuaArVnOMfVBVLYwrHNUhayE9T
	cfX1Y97WSbgoPN1CnIHBzDeH0UFYTcjdnqr+42rWWcd/Ezr+fjgXIt5dSFee4g==
Authentication-Results: mail.16bc.ru;
	auth=pass smtp.mailfrom=info@16bc.ru
Date: Sat, 10 Oct 2026 00:24:42 +0500
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kamlesh Chhetty <kamleshkc2002@gmail.com>
From: Eli D <info@16bc.ru>
Subject: Backport request for 7.0.y and 7.1.y: 6485da8579e2 (ALSA: hda: Add
 Lenovo Legion 7i 16IAX7 17AA3874 quirk)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
X-MailFrom: info@16bc.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VDTC47LTUWSD7VN3SQMNZNUG34DM7JTO
X-Message-ID-Hash: VDTC47LTUWSD7VN3SQMNZNUG34DM7JTO
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:41:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VDTC47LTUWSD7VN3SQMNZNUG34DM7JTO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

I would like to request a backport of the mainline commit

   6485da8579e2  ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk

into the 7.0.y and 7.1.y stable series.

Why it qualifies. The commit adds a device ID and a quirk entry for a 
machine
whose built-in speakers are completely silent without it. Per the stable 
rules
this falls under both accepted categories: it fixes a real user-visible 
problem,
and it merely adds a device ID. The change is three added lines across 
two files,
touches only static quirk and property tables, and cannot affect other 
hardware.

The problem. On Lenovo Legion 7 16IAX7 with Realtek ALC287 codec SSID 
17aa:3874
and CSC3551/CS35L41 speaker amps, cs35l41-hda fails to probe the amps:

   Failed property cirrus,dev-index: -22
   error -EINVAL: Platform not supported

and the Realtek codec never selects ALC287_FIXUP_CS35L41_I2C_2 for that 
SSID, so
the amps are not linked to the speaker output and the built-in speakers stay
silent. Headphones are unaffected, which makes it easy to miss.

Testing. I reproduced and verified the fix on a Lenovo Legion 7 16IAX7 
(board
82TD), ALC287 SSID 17aa:3874, PCI SSID 17aa:382b, two CS35L41 amps, 
running a
7.0-series Ubuntu kernel. After applying the change both amps probe and 
bind,
firmware loads, the dev-index error disappears and speaker playback works.

The commit is first present in v7.2, so 7.0.y and 7.1.y do not have it. 
It has no
Cc: stable tag, hence this request. There are no prerequisites; the 
patch applies
on its own.

For reference, sibling Legion quirks in the same code path were Cc'd to 
stable,
for example d35dfb6329ac (ALSA: hda/realtek: Fix speakers on Legion Pro 
7 16ARX8H
with codec SSID 17aa:38a7).

If you prefer an explicit patch submission rather than a pickup request, 
I can
send one.

References:
   commit: 
https://github.com/torvalds/linux/commit/6485da8579e2b0132630faa1ee2ac72ccaf01501
   thread: 
https://patch.msgid.link/20260622172247.19301-1-kamleshkc2002@gmail.com
   kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221663
   Ubuntu bug: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2157060

Thanks,
Eli D
info@16bc.ru

