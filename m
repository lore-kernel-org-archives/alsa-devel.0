Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC34E9A03B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:44:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 881FD60213;
	Wed, 18 Feb 2026 10:44:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 881FD60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771407886;
	bh=XnFGj5rTZuCKK0GTg6vhcrHuMwWMYr2gqja0bDJGtSc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fVOv2ghnfFRfpfjwjcpTLfu/LKpV7rUR8pFH+n0ISHiN6XDdnhctZiGa80mQD1A5g
	 CXnFidanMMU2YylcBxn9SAEe+4DhWVIvzzX1Av9fHeYeJ1/nTgWpDQ++ekNs+rzovg
	 iohHXAR+bzr0Jvnz6UY5t+eTtshHmwpaUIj7lgnQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72055F805F0; Wed, 18 Feb 2026 10:44:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7535F805E3;
	Wed, 18 Feb 2026 10:44:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84415F804F2; Wed, 18 Feb 2026 10:41:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7295EF80153
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2026 10:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7295EF80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18954de4339f7b00-webhooks-bot@alsa-project.org>
In-Reply-To: <18954de432c0f200-webhooks-bot@alsa-project.org>
References: <18954de432c0f200-webhooks-bot@alsa-project.org>
Subject: MSI Z690 has the same problem. Can't get the SPDIF working,
 front panel doesn't work with micorphone.
Date: Wed, 18 Feb 2026 10:41:29 +0100 (CET)
Message-ID-Hash: JAPSZ5E3AZOQMBAL4WGJO5WAPXOTG5NI
X-Message-ID-Hash: JAPSZ5E3AZOQMBAL4WGJO5WAPXOTG5NI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JAPSZ5E3AZOQMBAL4WGJO5WAPXOTG5NI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #706 was opened from Ralfpf:

Hope you could help me too, for i saw, that you helped another user with a MSI Z790 and a ALC4080. 

Her is the thread I read

 _Originally posted by @perexg in [#664](https://github.com/alsa-project/alsa-ucm-conf/issues/664#issuecomment-3779380548)_

This I posted already on another thread:

> I am very new to this subject. I recently switched from Win10 to Linux, so please be patient with my lack of knowledge. I am using a MS690 Unify. Despite the fact, that I can find one in the USB-Audio.conf on line 83 "# 0db0:82c7 MSI MEG Z690I Unify", I still can't get my optical SPDIF working. If i choose digital out, the digital signal is routed to the analog output, which is very ugly to listen to. Also my microphone isn't working. It seems, as if the mic in is configured as sink for monitor out of any other source.
sudo dmidecode -t 2 answers
dmidecode 3.6

Getting SMBIOS data from sysfs.
SMBIOS 3.6.0 present.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
Manufacturer: Micro-Star International Co., Ltd.
Product Name: MEG Z690 UNIFY (MS-7D28)
Version: 1.0
Serial Number: 07D2810_N81E356737
Asset Tag: Default string
Features:
Board is a hosting board
Board is replaceable
Location In Chassis: Default string
Chassis Handle: 0x0003
Type: Motherboard
Contained Object Handles: 0

Hope this is usefull. Please let me know, if you need more information. Of course I have an ALC4080 built in, but it's also recognised as USB-Audio.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/706
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
