Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B98606A31C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=rlYlLEqq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fingerlessgloves.me header.i=@fingerlessgloves.me header.a=rsa-sha256 header.s=mailcow header.b=vztE8Mtn
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14AD060204;
	Mon, 16 Nov 2026 10:23:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14AD060204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794821010;
	bh=A7qlK+AcKAeUGoxHmmgdnmWXfvn7bfk/G02DlGK1mIY=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rlYlLEqqBFE738bIRxJWe6dcSX0hzZMLZCcV1E/f3dH0xBIsEV5+VNC+9yTmGv0+Y
	 3ugunyH7gmsCYYOBTITeV7pStvagEqMLQ7f8F54RXYJeXR8ut3dQDTwKYBaB3Hqkks
	 gqLJHmfimPWI4OFcwy8ylz5cNjlnNF7nQnWhSfvE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A5EBF80604; Mon, 16 Nov 2026 10:22:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91B12F805F6;
	Mon, 16 Nov 2026 10:22:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0D30F80510; Mon, 16 Nov 2026 10:22:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=78.157.222.147
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794820965;
	b=HgUhsr8Mm0e6OUOykZ1l1hMK4LUWIztTF1YqyInCKTE7Gpdr9N85zZrWxEMoLZDNi2Wp
	 gm4gy3lkRZOQ2kBwBofSEs8iPUuz9e/u21AIOlabaMOtuxIZvZBOV/0SpyqApu/5l4H4R
	 1qVEpggI+KFzy/rLUKAsmbN5VC1dcnz4LolgqCg88pxdm54pp/aqKIRojv/loYvnuBohf
	 HRBo8oPJX+cK4jOIwcCC5w9ewa5zl3eiSbhk9HcTlV43sJJDorSCgcgD2UK6zihBMk2A7
	 8sg9a9b8K1QyNV2kRrXa/6ML9Iv5+xpTXN3y1lKcd7q2FnUBivZ5/1icewYGgyxqNtg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794820965;
	h=DKIM-Signature:MIME-Version:Date:From:To:Subject:Message-ID;
	bh=WnQ4eViPY7gjrC79P72eGYhOvB8s+wjx3QUYF6ykLCM=;
	b=VA7pVygptIOvRz1/uIlNOh+J9uzdUuZrfZBZPNEJ/CB1EBG3noOFUEemIwGIrtaImdt9
	 laGsdteH3d7I1fzLki9QBGudU8pEbrus1IsOe1oQkVUQ/BdB8nRahbbDZxuomg2rk7v2H
	 6ZtniyGEPCSMEPqM+og2Nk6POSPfQ04/4/nUMUI8pVeFTKK3fZWdDa1pI4cvUafKC0shZ
	 TjU4IN2xtjs9CjUki9bLVTTO3Wv4QOB/6NrK4LOw4gR/rehU0KerF4r9WzXEVSCKUVXc9
	 UgDzbMv3TqhTjA/Y0NlQEaQyLWU6mOmiz+TsPUtPSZAbwtWuLJ5n+osjTXV44qjcAnw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=fingerlessgloves.me header.i=@fingerlessgloves.me
 header.a=rsa-sha256 header.s=mailcow header.b=vztE8Mtn;
	arc=none smtp.remote-ip=78.157.222.147
Received: from mail.n9.uk (mail.n9.uk [78.157.222.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 34521F80095
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2026 10:22:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34521F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=fingerlessgloves.me header.i=@fingerlessgloves.me
 header.a=rsa-sha256 header.s=mailcow header.b=vztE8Mtn
Received: from mail.n9.uk (localhost [127.0.0.1])
	by mail.n9.uk (Postcow) with ESMTP id 69A9BE2C23
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2026 09:22:43 +0000 (GMT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4A491E2C22
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2026 09:22:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fingerlessgloves.me;
	s=mailcow; t=1794820962;
	h=from:subject:date:message-id:to:mime-version:content-type;
	bh=b0jpnfcMf0LIZN9bxzdj/qGj0xkERamIHbTe04R0GHg=;
	b=vztE8MtnNrkJ/vMimjj7I65OeFjPFibt9RY1nJSpTHPVhUuBottMepNiKDzHjIPfy0Wd3B
	byPDlfHw+7sr9w6Ea1oi5q4nY/WIk99WHL+eEDcR/St9QZ5dhazZSrM3yNefUMxMWzR4XY
	HyQeqo0KAOnC6Rt0ajPCIbf3x7IgdGloJM2L/2LO7/eqrvQX1KLpWg0WWNHQKgnxyFMWI6
	whIt4AIzgQxYA2Wmn5zn3ANxtRkXR8p+SucQ8k+pDUzI475wsMYG3R8knl65FPBKdsTVRW
	JkeAE4DUQbRLvF9ey+2HDlmU/AC47LRh26RkmCY8IePx1abUipzoBTNy7SLpMg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 09:22:41 +0000
From: FingerlessGloves <me@FingerlessGloves.me>
To: alsa-devel@alsa-project.org
Subject: Fedora 44, kernel 7.3.3, Logitech PRO X Wireless (046d:0aba) - Volume
 issue
Message-ID: <cc98710ddf2e4de5385f2450748a3381@FingerlessGloves.me>
X-Sender: me@FingerlessGloves.me
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: TG6KISHQPSQQGVJW4MSCJNGYBCBMU2B5
X-Message-ID-Hash: TG6KISHQPSQQGVJW4MSCJNGYBCBMU2B5
X-MailFrom: me@fingerlessgloves.me
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TG6KISHQPSQQGVJW4MSCJNGYBCBMU2B5/>
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
