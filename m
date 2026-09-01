Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4864FC61DD6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:29:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B890C601D7;
	Tue,  1 Sep 2026 08:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B890C601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788244161;
	bh=+MYnlwNVlutc2ooZ2XYr20uRES4pC/cMbjRJHdsRDcA=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZRTzp56suxp2yaU3xJXla7K/zHUvbhNiuSKevT5xtDUeH9mZl8hQqsch6zy8rLi7o
	 0PK6UcDj5E+TQ/LFQX50vJorhUFQ1YdCi7meXfeTwyKT/gxnMxEtH9zDJJdWIchpf1
	 0JCjwsseWo7BhuDopJ/k2bfTjKuyDmzCXQJsYSdU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 206E5F80601; Tue,  1 Sep 2026 08:28:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 763D0F805FC;
	Tue,  1 Sep 2026 08:28:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B12BF804CC; Tue,  1 Sep 2026 02:20:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=129.27.2.202
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788222054;
	b=mSGz97HjNwixBTMyJMDhO86EPAwznMuW9N3tUQuCyN5Nanzii47Odk0XPl+m3GerZw+k
	 rxPBHD6L90fz4rs7Ib5km3ID01qqMgQikYrIyHkrQw7WBP5caDInBTbGhdO5N7soYFHdK
	 Kon1dpnVj3JJ9Q3TST+h6KBo7D4n12vxly76xBwIDm5rN8Xnuy1h4A3VW+NlXM2xlGgPe
	 l6Y4Z0rJYYTQsnK5xtbptYrFfQJSUCxk5bpSW9SfNkYMzBcYGlmiacLmTUeevCMPe9dco
	 stS1/TjIqnw6HOaJpTIC2KJrp5sEpzl9tKMsk6jlsVA1ScokAv2N5QsLnDXCehUGnKQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788222054;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=zKmL37fjm9Ol24k56TMjXFQDChLTASWYPZGyuMX1lp4=;
	b=eEAQqYKAITkvu3pZW6VO24G14rk9LNVti6zN1ra68lJ4bDHZieUboTSSoubk115pE812
	 Xmzm8/zCRvo1b168dFNgQY4HQbiC9bg84rhsv3grond1Dq59hKqmqQ7ujYQNSgZ5ynoSh
	 f1MtpdFqGVXz0DLZR3mnlEJqXmhIUtdh/lvqlHodxiHHM5mk+lFpZERMvOnX1Bq/EpIUZ
	 TNPUqDgca8mEufaMFh36XSG6ftakV27w9lnIo6MM29Qr6JA/B0sws4gFEjXzHbss6gTz8
	 uv6RlXyesTIxahbPbqjTGjiDPEV/RORcvstdgyYct1jRQ82KADtYPoFXdVeNYSjZpYQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=tugraz.at header.i=@tugraz.at header.a=rsa-sha256
 header.s=mailrelay header.b=oPoW0v7n;
	arc=none smtp.remote-ip=129.27.2.202
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 218ECF80246
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 02:20:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 218ECF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=tugraz.at header.i=@tugraz.at header.a=rsa-sha256
 header.s=mailrelay header.b=oPoW0v7n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1788222039;
	bh=zKmL37fjm9Ol24k56TMjXFQDChLTASWYPZGyuMX1lp4=;
	h=Date:From:To:Subject;
	b=oPoW0v7nFBofRg+b+TmW4/oYMKiwMci/TPim0BAW5z841GjmdfSF6cBJHvWEe721V
	 jxS95lFM4p6NxqgG8tWFqrtH78n2wfaSbjMsHnjDmDtAjPAXzngEvNTu8OP12lPpvR
	 zyfpx9ED9P4xyRn5+yoL+E28B0Cz0IumT8n9D8cA=
Received: from ehlo.thunderbird.net (public.router.steyrer87.ffgraz.net
 [193.33.150.55])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4hYmjM1YXxz9s0w
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 02:20:38 +0200 (CEST)
Date: Tue, 01 Sep 2026 02:20:39 +0200
From: Sally Marcher <marcher@student.tugraz.at>
To: alsa-devel@alsa-project.org
Subject: MOTU MicroBook II playback issue snd-usb-audio (hacky fix)
User-Agent: K-9 Mail for Android
Message-ID: <6690AE3A-5D2A-488D-BB09-1588948491D9@student.tugraz.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TUG-Backscatter-control: bt4lQm5Tva3SBgCuw0EnZw
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117
X-MailFrom: marcher@student.tugraz.at
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3ZEK2EMU6Q6GE3FCKGBNX674OXFFKUKB
X-Message-ID-Hash: 3ZEK2EMU6Q6GE3FCKGBNX674OXFFKUKB
X-Mailman-Approved-At: Tue, 01 Sep 2026 06:28:41 +0000
Content-Type: text/plain;
 charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3ZEK2EMU6Q6GE3FCKGBNX674OXFFKUKB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi - quick help wanted:

*Issue:*
MOTU MicroBook 2 produced really crunchy sound on the output with snd-usb-audio driver.

*hacky Fix:*
Just setting urb_packs = 8 fixed in usb/endpoint.c (in data_ep_set_params)

*Question:*
I would love to contribute, but just implementing a quirk that fixes urb_packs at 8 seemed really hacky to me, any recommendations on further things to check / try?

*How I figured it out:*
When I modified the old module https://github.com/manuel-rhdt/snd-microbookii to compile with a modern kernel it worked fine.
Looking at the usb traffic with WireShark the usb packet size was smaller in case of snd-usb-audio compared to the snd-microbookii driver.

*Kernel (issue also verified on a newer one, on this I did all my debugging / testing):*
7.1.8-arch1-3 (Arch Linux)

*Relevant dmesg output:*
[17703.794487] usb 1-2: new high-speed USB device number 40 using xhci_hcd
[17703.922374] usb 1-2: New USB device found, idVendor=07fd, idProduct=0004, bcdDevice= 0.49
[17703.922383] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[17703.922386] usb 1-2: Product: MicroBookII 
[17703.922389] usb 1-2: Manufacturer: MOTU
[17703.926053] usb 1-2: Waiting for MOTU Microbook II to boot up...
[17703.926874] MicroBookII snd: 00 00 00 00 00 00 0b 14 00 00 00 01
[17703.927854] MicroBookII rcv: 00 02 00 00 00 00 0b 14
[…]
[17707.052011] MicroBookII snd: 00 04 00 00 00 00 0b 18
[17707.052932] MicroBookII rcv: 00 06 00 00 00 00 0b 18 00 00 00 01
[17707.052943] usb 1-2: MOTU MicroBook II ready
[17707.053014] usb 1-2: 0:1 : invalid sync pipe. bmAttributes 03, bLength 7, bSynchAddress 00

Thanks for any help / advice,
Sally
