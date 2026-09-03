Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49F9C79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:40:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC48860329;
	Tue,  8 Sep 2026 20:40:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC48860329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892822;
	bh=SqQRICY7hoYn8IvzLBT69OAgqOtQ04dGUdFJ8WaPHe8=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OWCg/TDREJyLwyqV85USIKyA78+S2hvNv0GZCMDbV4ZA2RHC6tRcPuvhyEKkRdrNS
	 CmRcjFCZ+vzbDXpseq+9OpCQW6K5qclWjRsM+Gi29dZk51pj+CPJ4vTfvSW90hda8U
	 EYNOt4EUnYf0SfAIZTTB1dYIFdSrx3D/KyiXrIGg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B413AF89612; Tue,  8 Sep 2026 20:36:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11FA9F89612;
	Tue,  8 Sep 2026 20:36:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76DDDF805A8; Thu,  3 Sep 2026 14:47:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=129.27.2.202
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788439656;
	b=JilushbOXZjOjfiIHi4pECxdbniMfIWpMgkk0N2lL3yS+jyvwRT6x4DRdVMyCCYw2inp
	 dcvbQdGAZowrvZVpDnkR2e8Op/0LK9+Uz+aVfnwR/FtvQgqXVit09OwWgeJ453cZlJMzn
	 OdZSeYtexauUuK7ESrEnyf/gfVqg2Ec9rdEyzIZnq2Q6hJ2/BYXrsOWj2OsAdstZSzOk1
	 85VFtebdl6dHO/aVqjjTroi+dsVJA35sCcy20Qv2hufKmmrD6O8mTXBXRnGk6AlSOEsXk
	 Oo13mifHVmGbR2ya8p3Z4J40ZUpAqSUj4J37QL+D2s7xgectrQ13X2PaeEecbyC1lLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788439656;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:From:To;
	bh=SqQRICY7hoYn8IvzLBT69OAgqOtQ04dGUdFJ8WaPHe8=;
	b=H1fuZmCJzNV89bZ2LeVUnBF+KscRNXGYlMdf4ehNIqDdv5UgnexZBHrwxCpIg3pbrIjP
	 jQKJ1tbs9lPIO9TrY6M86opxcSWAgll7gPigHmPj1dlYot7bddLcR0JIK/ModjDG+9V+j
	 EWTdIkVbQgPiiQB52KRd71fr3JMCamHpetx1Y5ndHwLDXAbjPrZqE09LoMKK9JdIVPNEE
	 HSpzv4wB/dpjti7laFyGbYJprCVrOwbtQrmK0XAklDhbq79vKCAc4uFSrZs9akryDZL2K
	 cA02+pPBF0+6hY87QSBXCbKTV5kPg27+lXv0FWzvb+nvrhDhDEKNPcgqZg66+9edDMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=tugraz.at header.i=@tugraz.at header.a=rsa-sha256
 header.s=mailrelay header.b=KciR7coZ;
	arc=none smtp.remote-ip=129.27.2.202
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1EC5CF80553
	for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2026 14:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EC5CF80553
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=tugraz.at header.i=@tugraz.at header.a=rsa-sha256
 header.s=mailrelay header.b=KciR7coZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1788439648;
	bh=IY1hRf+homXRO31fXZkNU4yRaKXneJ08EfL6fagvP9k=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=KciR7coZdSsh+8p07fegROWAO0V/RzVZQ077y/oy282MOzWidcmkOm94GjlRd2Abo
	 SEEr0kCKcRD9uNOZv/oyhvP78IayZni58xCtVv1bYsCUNJsrAunTbgWG6qfMSIFUUR
	 tbMUVmQvcRGOWUxmqPHlTycIS7xZdVtlg7OcQ5yg=
Received: from [129.27.156.239] (fexphdyn39.tugraz.at [129.27.156.239])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4hbKB83rC1z2xNt
	for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2026 14:47:28 +0200 (CEST)
Message-ID: <abf3bf13-4f91-4026-89ea-74b5f42ea935@student.tugraz.at>
Date: Thu, 3 Sep 2026 14:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ALSA: usb-audio: MOTU MicroBook II playback fix
From: Sally Marcher <marcher@student.tugraz.at>
To: alsa-devel@alsa-project.org
References: <6690AE3A-5D2A-488D-BB09-1588948491D9@student.tugraz.at>
Content-Language: en-US
In-Reply-To: <6690AE3A-5D2A-488D-BB09-1588948491D9@student.tugraz.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TUG-Backscatter-control: bt4lQm5Tva3SBgCuw0EnZw
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116
X-MailFrom: marcher@student.tugraz.at
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AZFNOSDML3AVNT2XJS4VMMOJGLMUUCFR
X-Message-ID-Hash: AZFNOSDML3AVNT2XJS4VMMOJGLMUUCFR
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:32 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AZFNOSDML3AVNT2XJS4VMMOJGLMUUCFR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add correct datainterval in the quirks-table for Microbook II

This patch fixes playback issues on the Microbook II. The correct value 
was in the older driver for this device ( 
https://github.com/manuel-rhdt/snd-microbookii/blob/dd304c097bb6a9d52276ac29c6969fa02bc7674a/audio.c#L914 
).
Signed-off-by: Sally Marcher <me@gry.sh>
---
  sound/usb/quirks-table.h | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index dd02c6294edf..79df0cb10783 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2813,6 +2813,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
                                         .rates = SNDRV_PCM_RATE_96000,
                                         .ep_attr = USB_ENDPOINT_XFER_ISOC |
  USB_ENDPOINT_SYNC_ASYNC,
+                                       .datainterval = 1,
                                         .rate_min = 96000,
                                         .rate_max = 96000,
                                         .nr_rates = 1,
@@ -2835,6 +2836,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
                                         .rates = SNDRV_PCM_RATE_96000,
                                         .ep_attr = USB_ENDPOINT_XFER_ISOC |
  USB_ENDPOINT_SYNC_ASYNC,
+                                       .datainterval = 1,
                                         .rate_min = 96000,
                                         .rate_max = 96000,
                                         .nr_rates = 1,
-- 
2.55.0

On 9/1/26 2:20 AM, Sally Marcher wrote:
> Hi - quick help wanted:
>
> *Issue:*
> MOTU MicroBook 2 produced really crunchy sound on the output with 
> snd-usb-audio driver.
>
> *hacky Fix:*
> Just setting urb_packs = 8 fixed in usb/endpoint.c (in data_ep_set_params)
>
> *Question:*
> I would love to contribute, but just implementing a quirk that fixes 
> urb_packs at 8 seemed really hacky to me, any recommendations on 
> further things to check / try?
>
> *How I figured it out:*
> When I modified the old module 
> https://github.com/manuel-rhdt/snd-microbookii to compile with a 
> modern kernel it worked fine.
> Looking at the usb traffic with WireShark the usb packet size was 
> smaller in case of snd-usb-audio compared to the snd-microbookii driver.
>
> *Kernel (issue also verified on a newer one, on this I did all my 
> debugging / testing):*
> 7.1.8-arch1-3 (Arch Linux)
>
> *Relevant dmesg output:*
> [17703.794487] usb 1-2: new high-speed USB device number 40 using xhci_hcd
> [17703.922374] usb 1-2: New USB device found, idVendor=07fd, 
> idProduct=0004, bcdDevice= 0.49
> [17703.922383] usb 1-2: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [17703.922386] usb 1-2: Product: MicroBookII
> [17703.922389] usb 1-2: Manufacturer: MOTU
> [17703.926053] usb 1-2: Waiting for MOTU Microbook II to boot up...
> [17703.926874] MicroBookII snd: 00 00 00 00 00 00 0b 14 00 00 00 01
> [17703.927854] MicroBookII rcv: 00 02 00 00 00 00 0b 14
> […]
> [17707.052011] MicroBookII snd: 00 04 00 00 00 00 0b 18
> [17707.052932] MicroBookII rcv: 00 06 00 00 00 00 0b 18 00 00 00 01
> [17707.052943] usb 1-2: MOTU MicroBook II ready
> [17707.053014] usb 1-2: 0:1 : invalid sync pipe. bmAttributes 03, 
> bLength 7, bSynchAddress 00
>
> Thanks for any help / advice,
> Sally
