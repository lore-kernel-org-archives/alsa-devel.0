Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D576C531C9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:00:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57FC160200;
	Sat, 25 Jul 2026 01:00:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57FC160200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784934034;
	bh=hFc4nYciuy8E6SVudIA2kv5ISBt63fwfDNgPsuAalWc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vdJe6TFcjTc3Z5zsRbIRG2HNcpjCfCRd2YaTF2aGnyMZ5rNhPYmEMMY0b13DgEO7X
	 zw4LC37psHwgAoarXp5n6AlnyOd9H89NAO0vLlUVAbRSsYGOb1k81XCrReG271tzX+
	 oaFoHBxb4I6EMPll2JNt8R+Oy0vG6n0/+LnWRQ1s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6C8CF805FD; Sat, 25 Jul 2026 00:59:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8764AF805FF;
	Sat, 25 Jul 2026 00:59:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0187F800AC; Sat, 25 Jul 2026 00:59:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784933988;
	b=ZgaW27KCkx8hdxsJinBVyzWz7kR/SrUQui6toCMG1ieg6iPikNTqmyfabGBQejGHX8wA
	 np+6mv8Upls0VWbjkppmXQkCiya4phAfwYuCsh28oGLLjUo+5ME2Msu2jXsEzwmlKr4I2
	 OeqNRcTk4QcwiHn/NA9HwH3rcmZkNZ257rufh6gUol7nJXGfoJl2buIYwaGlzL0E77B8h
	 gVKymOaaTdA549ZW/7cMpkWxKmCkQ95MJatJTupFG/D8grevO0eqbAylHb5rtZx2Bqb3E
	 4ECGGC3TCds0uZvAuD3N3JNY4zVsNZGHFj9ilrrTX4YNwL3Ea1KViP+RI1KbFg906yg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784933988;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=hFc4nYciuy8E6SVudIA2kv5ISBt63fwfDNgPsuAalWc=;
	b=A11NKHTLP3lFUJmUhC9HRl2fyMMIV8nBIks1aj4u//Fa/Fyr4Zo2xb+2UJdn0Q6SspzG
	 1jfAcXuCnPV9Jz5hVnyUj6fgwBtBSBexiR9g5dfVdgmg5906zrpkB+rBL/ehbXbygfcIH
	 ifSlQGx0IZaY9ozj73GMmpwtwm6/QKpFTN8lqrj3HiyBdLw5NZGDlyB0TZzpYY5+uCVHP
	 h0ptCyIvlGnydrbNtewQe7xhuQ23F2GTE3DnPMuwAZWGtdtDKOpyEjvJjUu51Q1Lgz1cY
	 b0nIU0eyAhSrCYl8rSK8wQ2KMa6taLpOOlMl9Kk9UqocsecVF1Mxp2r/5a0UMOv4UMA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DBD5AF800AC
	for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2026 00:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBD5AF800AC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c55c0120e11e00-webhooks-bot@alsa-project.org>
In-Reply-To: <18c55c0120bfe900-webhooks-bot@alsa-project.org>
References: <18c55c0120bfe900-webhooks-bot@alsa-project.org>
Subject: MSI MPG B650 CARBON WIFI (USB ID 0db0:70d3) - Front panel headphones
 detected but no audio output
Date: Sat, 25 Jul 2026 00:59:49 +0200 (CEST)
Message-ID-Hash: AX6DMWVMSS3UOMUOMU3B4CPGOHXZZXH2
X-Message-ID-Hash: AX6DMWVMSS3UOMUOMU3B4CPGOHXZZXH2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AX6DMWVMSS3UOMUOMU3B4CPGOHXZZXH2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #818 was opened from mtr-rdr:

### Summary

I believe I may have found an unsupported or partially supported MSI USB audio device.

My motherboard is an MSI MPG B650 CARBON WIFI (MS-7D74). The onboard audio appears as a Generic USB Audio device (USB ID 0db0:70d3).

Under Windows 11 the front panel headphone jack works correctly.

Under Linux Mint 22.3 the headphone jack is detected correctly, but no audio is produced from the front panel headphones. The rear speaker outputs continue to function correctly under Linux.

I am unsure whether this is a UCM issue or something lower in the stack, but after several days of troubleshooting I noticed that USB ID 0db0:70d3 does not appear in the current ALC4080 USB-Audio.conf profile while many other MSI ALC4080 boards do.

I would appreciate any guidance on whether this is expected, or whether support for this board is currently incomplete.

---

### System

- Distribution: Linux Mint 22.3 (Ubuntu 24.04 based)
- Kernel: 7.0.0-28-generic
- Motherboard: MSI MPG B650 CARBON WIFI (MS-7D74)
- USB Audio Device ID: 0db0:70d3

---

### Behaviour

**Windows 11**

- Speakers work.
- Front panel headphones work.
- Plugging headphones mutes the speakers automatically.

**Linux Mint 22.3**

- Speakers work normally.
- Headphone insertion is detected.
- PipeWire switches to the headphone output.
- Front panel headphones remain silent.

---

### Troubleshooting already performed

- Confirmed the hardware works correctly under Windows.
- Tested multiple PipeWire output selections.
- Confirmed headphone jack detection works.
- Tested playback directly with speaker-test (bypassing PipeWire).
- Inspected ALSA mixer controls.
- Compared available mixer controls against the existing ALC4080 UCM profile.
- Verified that USB ID 0db0:70d3 is not currently included in USB-Audio.conf while many other MSI ALC4080 boards are listed.

I have attached a complete diagnostic report containing:

[audio_bug_report.txt](https://github.com/user-attachments/files/30364459/audio_bug_report.txt)

- ALSA card information
- USB descriptors
- aplay output
- amixer controls
- PipeWire status
- Current USB-Audio.conf

If additional diagnostics, testing, or patches would be helpful, I would be happy to test them and report the results.

Thank you for your time.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/818
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
