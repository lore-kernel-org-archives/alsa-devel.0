Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74A0C5DF70
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:00:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E31F60270;
	Mon, 17 Aug 2026 18:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E31F60270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786986002;
	bh=Deg1ghCZlLPGzu0Iu95rYV41SSlMzh7dmYtuVO4ri0k=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=q/JFQjTzjJrGPn/HqaMfQwtGlO59AHjD465h62TeYo8fzOI8qLGvuxSgZmnzJjyDg
	 Hk6tnY390mbgcv+V3r0JFmQtpBEenK6dm1dGW2F84eLMjiksBHgipCkLX07YC4hqJH
	 NNYl5L8/lsbUehhCtCDH0U/WValERzwdFcsbzbs4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F961F805F4; Mon, 17 Aug 2026 18:59:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC7C5F80601;
	Mon, 17 Aug 2026 18:59:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56055F802BE; Sat, 15 Aug 2026 19:47:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=109.224.244.24
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786816032;
	b=aab57R4aaRyyXb6bfMtew7EwSobmeCOmrA4EEBxI30g1iRbb9R9h2Tio1tOZfwlG7Omf
	 1KIvZmy56zz+ZSghnmTaAsdlh93YYPvfXNAxMJkbAVAq6GkNKQwMs4hwD9tEQW9HBZFvW
	 2QuZJoH7MYTR8IamhWDuJJO5oNCWc8vyhk5STs3O/XiyxLfL9q3HhtCxjtnW3daguZ6fR
	 SRUPTgie/HXj4wH2T3a50vIx+A/ndJdggZo45Q3d10LkmfGEXuQ6+VC3TBIksexy1blDE
	 xlZBvHwdU1s68VpLpJwfb8VvNQNIrnP1Cw/1R46n9fptmyO1lTWWNGink6grsUJakhw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786816032;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=Lv9l4whlDQkW/vvpS7HTdoqKMBpuM5JUJHN3YvUYBXI=;
	b=YYkvOja7BRPF4C+wb8+p3a4ss3aXTs4qEq0V12qfXUqS8AOMI51W7qum+am3W7b034/J
	 +8Ztshyte43tTmbyUC0g8mqBtMbxDbH/yGehcEyxQg1WEL/hOJp+1B1oYraqqqbzaU9ie
	 XiZlMMWypkqwwBXwiwJ0uJ/NF2kmQf1cNKSRnScOMZf6SlfKVRHMM41/lxx+cdDVmXbI8
	 5t/5FusXK+35PYEsbss7XOTnn9Prdmx+R2Uf+Cxxabo5hO0w15Y5gulVwjNPYFEF55knq
	 9nXV3ltMKOfqxM57SG+CWM0sqRGkUBrdpVmyiK+v712Z6MGWV1AllSGCPnq/ywsd/bw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=62y5d477wbfulaiit7utn24q4y.protonmail header.b=VqSKFaWh;
	arc=none smtp.remote-ip=109.224.244.24
Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch
 [109.224.244.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3EA0F800C1
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2026 19:47:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3EA0F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=62y5d477wbfulaiit7utn24q4y.protonmail header.b=VqSKFaWh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=62y5d477wbfulaiit7utn24q4y.protonmail; t=1786816030; x=1787075230;
	bh=Lv9l4whlDQkW/vvpS7HTdoqKMBpuM5JUJHN3YvUYBXI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VqSKFaWhXZmt8yDhJDROhyqg1MVSju4WZG5IA7O3byXKm9k2l4NQ6IHoqhxadtfND
	 AcuCZGJxmJ4/fbXzy+KADUv0qbIVBcZhTjuhP2nQFQzdwToC1ywH6wH9qaajq6OtIY
	 QPuKkPqS+BvrhIJ7VWEzWv4o5IJfmx2BGDa2rKWp5+hvLcmXdeOeRvDFf6Wvr5UZKu
	 gQfGTt/XAto+JjU14FidFSqMYh6WXLQYPm2HrYpwHC9LbdCrz7eXz+HxCjs1SewKxz
	 lJK7IYtoH6lRGueve+sgEzkfhGrsCRElKF4GJxOsoZ6w2QXObl0r2PFFv3SXHopysh
	 Zp8YWSeZeQipA==
Date: Sat, 15 Aug 2026 17:47:06 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Walther White <Lightning1111111@proton.me>
Subject: LINUX AUDIO FIX FOR HUAWEI AMD LAPTOPS
Message-ID: 
 <3pZ5MOlm5zlq8xTJrCBs8rDuBniv3lHY1MgF9oAmFstfU7-lFF_j8fo-ZvLhxBaSkFEBp_FyrLZ8LLozvL4tsUZEBrgDrs_EZbQxMBImzIo=@proton.me>
Feedback-ID: 115794472:user:proton
X-Pm-Message-ID: 7080da4df292f3261adc2b4b342ef7c160f25427
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------8334e09ddeabe8615d7c5758341d610dfab660e677a31bae335887a636db54e3";
 charset=utf-8
X-MailFrom: Lightning1111111@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PN5CAT4MD2UT7CPQ4WPUS4RHS67PMLBQ
X-Message-ID-Hash: PN5CAT4MD2UT7CPQ4WPUS4RHS67PMLBQ
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:59:24 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PN5CAT4MD2UT7CPQ4WPUS4RHS67PMLBQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------8334e09ddeabe8615d7c5758341d610dfab660e677a31bae335887a636db54e3
Content-Type: multipart/mixed;boundary=---------------------a2cab561395e0ebf8d604d4cc3983542

-----------------------a2cab561395e0ebf8d604d4cc3983542
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3DLINUX AUDIO FIX FOR HUAWEI AMD LAPTOPS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Author: Linux Community / Michael Lorentz
Date: July 2026
Hardware: Huawei MateBook with AMD Ryzen processor (CX11970 audio codec)
System: Linux Mint / Ubuntu / Other distributions with PipeWire

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP-BY-STEP SOLUTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

PROBLEM DESCRIPTION:
Audio on built-in laptop speakers does NOT work.
Audio on headphones connected to the mini-jack DOES work.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 1: CHECK AUDIO DEVICE STATUS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Open a terminal and run:

$ pactl list short sinks

If you see "SUSPENDED" status for the speaker device, this confirms the pr=
oblem.

Check if the sound card is detected:

$ aplay -l

You should see a card with the CX11970 codec (or similar).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 2: IMMEDIATE AUDIO RESTORATION (QUICKEST METHOD)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Perform a full system restart:

$ sudo reboot

After restart, speaker audio should be restored.

NOTE: If this doesn't work, proceed to Step 3.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 3: MANUAL FIX (IF RESTART DID NOT HELP)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Run the following commands in the given order:

$ sudo alsactl init
$ sudo alsactl store
$ systemctl --user restart pipewire pipewire-pulse
$ pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-stereo
$ pactl set-sink-volume alsa_output.pci-0000_02_00.6.analog-stereo 80%

Test if audio works:

$ speaker-test -t wav -c 2

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 4: CHECK IF SPEAKERS ARE MUTED IN ALSA MIXER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

$ alsamixer

Press F6 and select your sound card (Generic_1 or CX11970).

Check these channels:
- Master
- PCM
- Speaker
- Headphone

If any shows "MM" (muted), press M on the keyboard to unmute.
Use the arrow keys to set volume to approximately 80%.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 5: AUTOMATIC STARTUP SCRIPT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

To automate the fix at every system startup, create a script:

$ mkdir -p ~/bin
$ nano ~/bin/fix-audio.sh

Paste the following content:
--------------------------------------------------------------------------=
---
#!/bin/bash
# Audio fix script for Huawei AMD

sleep 30

# Reset ALSA
sudo alsactl init 2>/dev/null

# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse 2>/dev/null

# Force speaker output
pactl set-card-profile alsa_card.pci-0000_02_00.6 output:analog-stereo+inp=
ut:analog-stereo 2>/dev/null
pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-stereo 2>/dev/n=
ull
pactl set-sink-volume alsa_output.pci-0000_02_00.6.analog-stereo 80% 2>/de=
v/null
pactl set-sink-mute alsa_output.pci-0000_02_00.6.analog-stereo 0 2>/dev/nu=
ll

echo "$(date) - Audio fixed" >> /tmp/fix-audio.log
--------------------------------------------------------------------------=
---

$ chmod +x ~/bin/fix-audio.sh

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 6: ADD SCRIPT TO AUTOSTART
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

$ nano ~/.config/autostart/fix-audio.desktop

Paste (replace [USER] with your username):
--------------------------------------------------------------------------=
---
[Desktop Entry]
Type=3DApplication
Name=3DFix Audio
Exec=3D/home/[USER]/bin/fix-audio.sh
Icon=3Daudio-card
X-GNOME-Autostart-enabled=3Dtrue
--------------------------------------------------------------------------=
---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 7: ALLOW SUDO WITHOUT PASSWORD (OPTIONAL)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

To allow the script to run without asking for a password:

$ sudo visudo -f /etc/sudoers.d/fix-audio

Add (replace [USER] with your username):
--------------------------------------------------------------------------=
---
[USER] ALL=3D(ALL) NOPASSWD: /home/[USER]/bin/fix-audio.sh
--------------------------------------------------------------------------=
---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 8: DESKTOP SHORTCUT FOR QUICK FIX
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Create a desktop shortcut to fix audio with one click:

$ nano ~/Desktop/Fix-Audio.desktop

Paste:
--------------------------------------------------------------------------=
---
[Desktop Entry]
Type=3DApplication
Name=3DFix Audio
Exec=3Dgnome-terminal -- bash -c "sudo alsactl init; systemctl --user rest=
art pipewire pipewire-pulse; pactl set-default-sink alsa_output.pci-0000_0=
2_00.6.analog-stereo; pactl set-sink-volume alsa_output.pci-0000_02_00.6.a=
nalog-stereo 80%; echo 'Audio fixed!'; read -p 'Press Enter'"
Icon=3Daudio-card
Terminal=3Dtrue
--------------------------------------------------------------------------=
---

$ chmod +x ~/Desktop/Fix-Audio.desktop

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 9: RESET PIPEWIRE CONFIGURATION (IF OTHER METHODS FAIL)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

If none of the above methods work, perform a full PipeWire reset:

$ systemctl --user stop pipewire pipewire-pulse
$ rm -rf ~/.config/pipewire
$ rm -rf ~/.config/pulse
$ rm -rf ~/.local/state/wireplumber
$ rm -rf ~/.cache/pipewire
$ systemctl --user start pipewire pipewire-pulse

Then repeat Step 3.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
STEP 10: INSTALL PAVUCONTROL (GRAPHICAL AUDIO MANAGEMENT TOOL)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

$ sudo apt install pavucontrol

Run:
$ pavucontrol

Go to the "Output Devices" tab:
- Find the CX11970 device (or similar)
- Click the green checkmark (Set as default)
- In the "Port" dropdown, select "Speaker" instead of "Headphones"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
DIAGNOSTICS - HOW TO CHECK WHAT'S WRONG
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Check if the sound card is detected:
$ aplay -l

Check device status:
$ pactl list short sinks

Check available ports:
$ pactl list cards | grep -A 20 "CX11970"

Check kernel logs:
$ dmesg | grep -i "snd\|audio\|hda"

Check loaded modules:
$ lsmod | grep snd

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
COMPARING "GOOD" AND "BAD" STATES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Save "good" state (when audio works):
$ sudo cp -r /etc/modprobe.d /tmp/modprobe.d.good
$ sudo cp -r /etc/modules-load.d /tmp/modules-load.d.good
$ sudo cp -r /etc/pulse /tmp/pulse-system.good
$ sudo cp -r /usr/share/pipewire /tmp/pipewire-share.good
$ lsmod | grep snd > /tmp/snd-modules.good

Save "bad" state (when audio does NOT work):
$ sudo cp -r /etc/modprobe.d /tmp/modprobe.d.bad
$ sudo cp -r /etc/modules-load.d /tmp/modules-load.d.bad
$ sudo cp -r /etc/pulse /tmp/pulse-system.bad
$ sudo cp -r /usr/share/pipewire /tmp/pipewire-share.bad
$ lsmod | grep snd > /tmp/snd-modules.bad

Compare states:
$ diff -r /tmp/modprobe.d.good /tmp/modprobe.d.bad
$ diff -r /tmp/modules-load.d.good /tmp/modules-load.d.bad
$ diff -r /tmp/pulse-system.good /tmp/pulse-system.bad
$ diff -r /tmp/pipewire-share.good /tmp/pipewire-share.bad
$ diff /tmp/snd-modules.good /tmp/snd-modules.bad

If diff shows no differences - the problem is in hardware registers.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
WHAT DOES NOT WORK - WHAT NOT TO TRY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

The following solutions have been tested and failed:

| Method | Why It Failed |
|--------|---------------|
| Cron @reboot with delay | Runs too early |
| Systemd service after sound.target | Runs before BIOS state is fully app=
lied |
| Disabling suspend in WirePlumber | Does not address hardware register st=
ate |
| Blacklisting ACP modules | Does not reset hardware state |
| Kernel parameters | Cannot override hardware register state |
| Watchdog scripts | BIOS does not create configuration files |

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
ADDITIONAL INFORMATION - ROOT CAUSE OF THE PROBLEM
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

The problem occurs because BIOS/UEFI during initialization writes the audi=
o
controller state to hardware registers. Linux reads this state and applies=
 it,
which causes speakers to be marked as "unavailable."

The state is stored in HARDWARE REGISTERS which:
- Are not accessible via software tools
- Are only reset during a full POST (Power-On Self-Test)
- Are not dependent on configuration files

This is why software solutions (scripts, file modifications) cannot fix th=
e
problem if the cause is in the hardware registers.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
SUMMARY - MOST EFFECTIVE SOLUTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

1. SYSTEM RESTART - always restores audio
=C2=A0 =C2=A0$ sudo reboot

2. MANUAL FIX - when restart doesn't help
=C2=A0 =C2=A0$ sudo alsactl init
=C2=A0 =C2=A0$ systemctl --user restart pipewire pipewire-pulse
=C2=A0 =C2=A0$ pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-=
stereo

3. STARTUP SCRIPT - automate the fix
=C2=A0 =C2=A0Create ~/bin/fix-audio.sh and add to autostart

4. DESKTOP SHORTCUT - one-click quick fix

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
IMPORTANT NOTE - THE F12 / F2 BIOS ISSUE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

During extensive testing, a critical discovery was made regarding how the
problem is triggered:

| BIOS Entry Method | Effect on Audio |
|-------------------|-----------------|
| F12 (boot device selection menu) | =E2=9D=8C Speaker audio STOPS WORKING=
 |
| F2 (BIOS configuration / boot order) | =E2=9C=85 Audio remains INTACT |

THIS MEANS:
- Entering BIOS itself is NOT the problem
- The problem is the SPECIFIC hardware initialization mechanism used by F1=
2
- If you need to change boot settings - use F2, not F12

HOW THIS WORKS:
1. BIOS/UEFI via F12 initializes the audio controller in a specific mode
2. This state is written to hardware registers
3. Linux reads and applies this state
4. The state causes speakers to be marked as "unavailable"
5. The system defaults to headphones as output

RECOMMENDATION:
- Avoid using F12 (boot menu) unless absolutely necessary
- Use F2 (BIOS configuration) to change boot order
- If you must use F12, perform a full restart without entering BIOS afterw=
ard

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
END OF REPORT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-----------------------a2cab561395e0ebf8d604d4cc3983542
Content-Type: application/pgp-keys; filename="publickey - Lightning1111111@proton.me - 0x75214908.asc"; name="publickey - Lightning1111111@proton.me - 0x75214908.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - Lightning1111111@proton.me - 0x75214908.asc"; name="publickey - Lightning1111111@proton.me - 0x75214908.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnFYdHFCWUpLd1lCQkFI
YVJ3OEJBUWRBek9UMFIxNW1Pa3VWYlJUanR1SjhjYjhxZFRwWnR0MDAKU2xpT3N5SmpVMEhOTjB4
cFoyaDBibWx1WnpFeE1URXhNVEZBY0hKdmRHOXVMbTFsSUR4TWFXZG9kRzVwCmJtY3hNVEV4TVRF
eFFIQnliM1J2Ymk1dFpUN0NqQVFRRmdvQVBnV0NacVh0cUFRTENRY0lDWkNBSXpqaApjLzM4TEFN
VkNBb0VGZ0FDQVFJWkFRS2JBd0llQVJZaEJIVWhTUWl0SGRqdnR3WEJsWUFqT09Gei9md3MKQUFB
SVVRRUFyWWd0Qk1FMVZIa2RXYzNoWXFLUFN0cktEUDViOEFzenNab2JncndTcGVBQS9SVlZZcVh6
CjE3M1QyRU9aLzBiR09uQWtMQXRhcG9RNUkyT2UwTmVJU3NVT3pqZ0VacVh0cUJJS0t3WUJCQUdY
VlFFRgpBUUVIUUxKejNCTjF4QkRIbGh2YW00Tk1WVmMwYUsrM3ZzVWtsODhFM0dFUit3NFZBd0VJ
QjhKNEJCZ1cKQ2dBcUJZSm1wZTJvQ1pDQUl6amhjLzM4TEFLYkRCWWhCSFVoU1FpdEhkanZ0d1hC
bFlBak9PRnovZndzCkFBQ2VFQUVBMHM5aWFmR2Vqd3hRVllaV0s5RDFDNnB1UGQxTnA3a2w3MkVS
WVFpZ0dBUUEvME1oMmVGQgpyZ25vM281NklsaDFtbXdDOVFKYTN5WVErbjFRK3pLNC9Zb0MKPUNO
RUMKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------a2cab561395e0ebf8d604d4cc3983542--

--------8334e09ddeabe8615d7c5758341d610dfab660e677a31bae335887a636db54e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqApgAJEIAjOOFz/fwsRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfY86jekqcLRdSJw4w+dN67rXPf6C9a5pTVuEo4
Z4RBMBYhBHUhSQitHdjvtwXBlYAjOOFz/fwsAAASxQEA2lcCP908WVpzYUe4
V2b3UMfrTQXdzmxq1ie6A2brmWsBANCRB+FqvvCJtYaKe/DcqjfpzVjhu6ot
cy1AGx5YBJII
=kat0
-----END PGP SIGNATURE-----


--------8334e09ddeabe8615d7c5758341d610dfab660e677a31bae335887a636db54e3--

