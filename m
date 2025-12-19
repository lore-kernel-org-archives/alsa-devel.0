Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1863BD711D3
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Dec 2025 00:59:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6B216022B;
	Fri, 19 Dec 2025 01:59:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6B216022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1766105995;
	bh=JG25kOi0Dhwx5eg5sk/8izfK+vAzUNPQUBbhGKk2pu4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sWuEQHuZ3kTp9O9AALgJsBAwo7zo/YhUWNaKzjzXNL5wzPnw/exNPskoLF9lfCH49
	 xqmsqZCBcNdpEUlEUwl7HkK9Img1RA7UVnIj6ux6wuqDxz7u29niCp9cmZjvbQdOJY
	 P2EAPP7XuttWG16SvrxWgXwFt2B9ZAyZ89R9z/mM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 300DDF805E3; Fri, 19 Dec 2025 01:59:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E29BDF805C6;
	Fri, 19 Dec 2025 01:59:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B741AF8028B; Fri, 19 Dec 2025 01:59:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3357AF8001F
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2025 01:59:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3357AF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <188278008b7bcd00-webhooks-bot@alsa-project.org>
In-Reply-To: <18827800856b6700-webhooks-bot@alsa-project.org>
References: <18827800856b6700-webhooks-bot@alsa-project.org>
Subject: MSI Z790I EDGE WiFI not detecting front panel audio
Date: Fri, 19 Dec 2025 01:59:10 +0100 (CET)
Message-ID-Hash: OBTSZQPTDBU5FTQQEIAPUDOCUU4ZCCLT
X-Message-ID-Hash: OBTSZQPTDBU5FTQQEIAPUDOCUU4ZCCLT
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OBTSZQPTDBU5FTQQEIAPUDOCUU4ZCCLT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #664 was opened from abhisas:

This Motherboard is in already in the UCM conf list for the ALC4080, but the front panel audio still does not work, and I am not sure why. 

I am on Fedora version 43. Any help would be appreciated. 

Below is output from lsusb
` us 001 Device 007: ID 0db0:62a4 Micro Star International USB Audio `

Alsa info.sh output: http://alsa-project.org/db/?f=01026cd96771a91f619f9c36abb51b6bfe9321f6 

Output from plugging in front panel jack (alsactl monitor)
```node hw:3, #14 (0,0,0,Mic - Input Jack,0) VALUE
node hw:3, #25 (0,0,0,Headphone - Output Jack,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #19 (2,0,0,PCM Playback Volume,0) VALUE
node hw:3, #14 (0,0,0,Mic - Input Jack,0) VALUE
```

alsaucm -c hw:2 dump text"

```
ALSA lib parser.c:305:(error_node) [error.ucm] UCM is not supported for this HDA model (HDA NVidia at 0x82080000 irq 17)
ALSA lib main.c:1804:(snd_use_case_mgr_open) [error.ucm] failed to import hw:2 use case configuration -6
alsaucm: error failed to open sound card hw:2: No such device or address
```

aplay -l:

```
**** List of PLAYBACK Hardware Devices ****
card 0: Stream [JBL Quantum Stream], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 3: HDMI 0 [Odyssey G50A]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: Audio [USB Audio], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: Audio [USB Audio], device 1: USB Audio [USB Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/664
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
