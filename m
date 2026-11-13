Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C45606A33D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=cel61gPw;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fingerlessgloves.me header.i=@fingerlessgloves.me header.a=rsa-sha256 header.s=mailcow header.b=p7QJ/fHY
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81CBB601FA;
	Mon, 16 Nov 2026 14:47:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81CBB601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794836852;
	bh=A7qlK+AcKAeUGoxHmmgdnmWXfvn7bfk/G02DlGK1mIY=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cel61gPwgqEdEvUhXrTPOT+1Sg9YBEMK8xvLbeG/kf911gNC17LgOj+WOL9/X8u/3
	 D6hKJaae9eWyHLFn4bICUyYJthEd5VLGu2y/6nuS4t5Z/iLwKUglP/+H7WrcZL8d9t
	 k/kER/iJXV3lhvkU93SqVkRfGszsOAgFqrB4tixI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10AF4F80611; Mon, 16 Nov 2026 14:46:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4844DF80618;
	Mon, 16 Nov 2026 14:46:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40F67F80552; Fri, 13 Nov 2026 14:35:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=78.157.222.147
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794576936;
	b=P5LBuVQ+FWZyF9KGv3XQb1Ownce/PolWjiHg2QY0GKuwYcZM6g1+FnlfQCU6UxT1KSqZ
	 4/PTJEiO+tfeLHzNoWHX3m+z2KDhGk67md9bOgaWycVhm6/CB69mr7mX9McAwFWcL7nLk
	 Qat5p59C5yIE9OLsLBYSTSa8GbqaaQVg1OttqHOxR0Od/Po/NdvjGgd16Si7DbxjiJ+X1
	 yuIpyb1lZ3i0qhLOalEZ0JG1Rg7RuBx+uZTIxyfRSHfxB3WuPX8SfE4H3pM2RXgi1WJpH
	 gxRTbqJka3XYZDz0eyzwNc9bXS/XoZn7TkWcf1WmuJFN66MDe6EnjZZ9d/OfBPlVG+A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794576936;
	h=DKIM-Signature:MIME-Version:Date:From:To:Subject:Message-ID;
	bh=oXWGRIPiz0MBdRzuhP+uN1DVqFMT2Gds145o6eglxnA=;
	b=FsEmwFU58rO8u3Mzc541hv0i0egsqsPftA7CdG2tdY826udCKJfmSynm1VrKBx3du0/1
	 xtRlx90KlJo/4Bi9SV0DnvVBZADLHMh+dGMpqrck9kbqdt9Cv8LrRviO6VBLF3AbulCwk
	 cEhBqqbHaKVVBgwGUWnWT1JFwEcOPLJ8+JIjzAOOBNko3BcnQ/pcvqOA9SvX1J2Cled2E
	 nXpErEJ/2Ka9iD4cYvCFkJuXMamt5Rk7KlyNjilIqOFCleh/N7JZro/dmqFKEULWFZdPk
	 fTZTDTo74L0fLnmy1hNpy5HHeUZwkBV/+fCqMsjPyvnMmPwJdR6ntDG4K8PzHINf4zA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=fingerlessgloves.me header.i=@fingerlessgloves.me
 header.a=rsa-sha256 header.s=mailcow header.b="p7QJ/fHY";
	arc=none smtp.remote-ip=78.157.222.147
Received: from mail.n9.uk (mail.n9.uk [78.157.222.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B102EF8012B
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 14:35:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B102EF8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=fingerlessgloves.me header.i=@fingerlessgloves.me
 header.a=rsa-sha256 header.s=mailcow header.b=p7QJ/fHY
Received: from mail.n9.uk (localhost [127.0.0.1])
	by mail.n9.uk (Postcow) with ESMTP id F117BE1EE5
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 13:35:34 +0000 (GMT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 065EBE1ED7
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 13:35:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fingerlessgloves.me;
	s=mailcow; t=1794576934;
	h=from:subject:date:message-id:to:mime-version:content-type;
	bh=jMXOglL4XfnhB8O2zveG15dNYf3gFAuHZHCzoBKfhgc=;
	b=p7QJ/fHY1d+1rqPxLZ/OO+4Pq/NnRsUmxtnaOtSS44ZmoMfFXKV+i6oQH6Sk10Zv1mu+Ok
	NwYUPwKzuW+0ERdJDQm6YsnR2Zo91fIbrzhj1fandAVGlNWhHtx7B53bIJANUC89sPrHg0
	IADfO4G5tNDX1o8cnad2iAfX3V83vz9WR2Li6M/8Tmdh3vk1ydWzDeq+TLYo1ULeZ57P6e
	z2+5K9Y3i4/SxH5PeAQGQZVnGSSsvPx7lqCvlu+OVHuTeNci/9MCB2/gNy9PVqCzyCxTMs
	Uxkc9Bdbsf+Ogk2RtPMHxqgWdI3SR70Ut5IKLO2UxW6mY7bRy36uJAGP3OeWiQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 13:35:33 +0000
From: FingerlessGloves <me@FingerlessGloves.me>
To: alsa-devel@alsa-project.org
Subject: Fedora 44, kernel 7.3.3, Logitech PRO X Wireless (046d:0aba) - Volume
 issue
Message-ID: <fd024e1354679eae7621cd868aa3d267@FingerlessGloves.me>
X-Sender: me@FingerlessGloves.me
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: me@fingerlessgloves.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WQAUGSXSKHVHVRDYAOWNCZEDP6NRFRJ2
X-Message-ID-Hash: WQAUGSXSKHVHVRDYAOWNCZEDP6NRFRJ2
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:46:28 +0000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQAUGSXSKHVHVRDYAOWNCZEDP6NRFRJ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi,

I upgraded to Kernel 7.3 today and noticed my Logitech PRO X Wireless 
headset playback volume was much quieter, I've worked out 30-35% range 
where I usually had my headset set now needs to be set near 85% to get 
similar loudness out of it.

The fix to the problem I have come up with so far is to run this command 
`amixer -c 5 sset PCM 64` which seems to restore the volume loudness 
levels back to their original.

I believe this might be a regression from 
https://github.com/torvalds/linux/commit/3ac761b613c744aa22e269d31801053e38bb4968 
I could be wrong though

I have command outputs below which may help show the problem here. I'm 
sure others will upgrade and suddenly wonder why their headset has 
gotten quieter. Microphone volume I've been told seems to be normal from 
the usual people I talk to, so it's just output affected

Headset is set to Pro Audio Profile in Fedora 44 KDE Desktop, when 
booted into Kernel 7.2 and 7.3.

## Kernel 7.2
# aplay -l | grep -i pro
card 5: Headset [PRO X Wireless Gaming Headset], device 0: USB Audio 
[USB Audio]
  amixer -c 5 get PCM
# amixer -c 5 get PCM
Simple mixer control 'PCM',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
# amixer -c 5 scontrols
Simple mixer control 'PCM',0
Simple mixer control 'Mic',0
# amixer -c 5 get Mic
Simple mixer control 'Mic',0
   Capabilities: cvolume cvolume-joined cswitch cswitch-joined
   Capture channels: Mono
   Limits: Capture 0 - 67
   Mono: Capture 67 [100%] [3.00dB] [on]
# dmesg | grep -iE 'usb-audio|0aba|snd-usb'
[   10.020534] usb 6-1.3.4.4.3: New USB device found, idVendor=046d, 
idProduct=0aba, bcdDevice= 1.00
[   10.193459] input: Logitech PRO X Wireless Gaming Headset Consumer 
Control as 
/devices/pci0000:00/0000:00:08.3/0000:75:00.3/usb6/6-1/6-1.3/6-1.3.4/6-1.3.4.4/6-1.3.4.4.3/6-1.3.4.4.3:1.3/0003:046D:0ABA.000A/input/input26
[   10.243772] input: Logitech PRO X Wireless Gaming Headset as 
/devices/pci0000:00/0000:00:08.3/0000:75:00.3/usb6/6-1/6-1.3/6-1.3.4/6-1.3.4.4/6-1.3.4.4.3/6-1.3.4.4.3:1.3/0003:046D:0ABA.000A/input/input28
[   10.244033] hid-generic 0003:046D:0ABA.000A: input,hiddev99,hidraw9: 
USB HID v1.11 Device [Logitech PRO X Wireless Gaming Headset] on 
usb-0000:75:00.3-1.3.4.4.3/input3
[   20.239239] usbcore: registered new interface driver snd-usb-audio

## Kernel 7.3
# aplay -l | grep -i pro
card 5: Headset [PRO X Wireless Gaming Headset], device 0: USB Audio 
[USB Audio]
# amixer -c 5 get PCM
Simple mixer control 'PCM',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 64
   Mono: Playback 41 [64%] [-23.00dB] [on]
# amixer -c 5 scontrols
Simple mixer control 'PCM',0
Simple mixer control 'Mic',0
# amixer -c 5 get Mic
Simple mixer control 'Mic',0
   Capabilities: cvolume cvolume-joined cswitch cswitch-joined
   Capture channels: Mono
   Limits: Capture 0 - 67
   Mono: Capture 67 [100%] [3.00dB] [on]
# dmesg | grep -iE 'usb-audio|0aba|snd-usb'
[   10.136223] usb 6-1.3.4.4.3: New USB device found, idVendor=046d, 
idProduct=0aba, bcdDevice= 1.00
[   10.297395] input: Logitech PRO X Wireless Gaming Headset Consumer 
Control as 
/devices/pci0000:00/0000:00:08.3/0000:75:00.3/usb6/6-1/6-1.3/6-1.3.4/6-1.3.4.4/6-1.3.4.4.3/6-1.3.4.4.3:1.3/0003:046D:0ABA.000A/input/input26
[   10.347810] input: Logitech PRO X Wireless Gaming Headset as 
/devices/pci0000:00/0000:00:08.3/0000:75:00.3/usb6/6-1/6-1.3/6-1.3.4/6-1.3.4.4/6-1.3.4.4.3/6-1.3.4.4.3:1.3/0003:046D:0ABA.000A/input/input28
[   10.348093] hid-generic 0003:046D:0ABA.000A: input,hiddev99,hidraw9: 
USB HID v1.11 Device [Logitech PRO X Wireless Gaming Headset] on 
usb-0000:75:00.3-1.3.4.4.3/input3
[   21.433299] usbcore: registered new interface driver snd-usb-audio
# amixer -c 5 sset PCM 64
Simple mixer control 'PCM',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 64
   Mono: Playback 64 [100%] [0.00dB] [on]
   # amixer -c 5 get PCM
Simple mixer control 'PCM',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 64
   Mono: Playback 64 [100%] [0.00dB] [on]

-- 
FingerlessGloves
