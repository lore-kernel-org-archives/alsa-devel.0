Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA6ECD98D6
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:57:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BFCC601FC;
	Fri, 12 Jun 2026 16:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BFCC601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781276269;
	bh=yu9uNxAYvy81PDQNiOPKiyxf4b3qdKK7nfdfsMOdH2Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dQvke9xDtp47QTlyhgvy1MNK+eefSqZfJcoKFqD/vWIJJcaB9sA+fWED+9sU9Echn
	 Xy3AnzlWx3rY/y1o1LAYlNjlnI1jyWPKJq1V791DKhyzNkjz4BqMtP8mWhK2QXl8xA
	 sp8Ejgl5I2z8GF9xGE+7MsHQMD1Qwy21ZKYQdYeg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E7B6F805FF; Fri, 12 Jun 2026 16:57:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1722FF805EB;
	Fri, 12 Jun 2026 16:57:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0060DF805D3; Fri, 12 Jun 2026 16:57:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781276224;
	b=n8OIawFyvnIPbv5o9xsICuYPZCzHj983ny+jBZjpIn2QKaRbnFiYGOTLAJxNzoYP8jR+
	 5otuUXuhm9/0gKKN+APCFy+Z+JiLGNZIuh++zNiWh1VmwenHURRDD7nNobR1hPDKjVoiR
	 a47p7QUcqFC3GkVJmmUzU6hc04t8RjTGEvsZtb0OWRXhJOdioGIFziA35DuGp2pZf1lia
	 8DDMGP0vcrArJkGb75ch4yn8ihPmP4ZPL6pCtll6FsVtRXLc1AaHa1wSSHC6hqIeePonE
	 F17/5t4QH95H1+zF8KnAP80BplbcWmmLtOgQaA7nSGmH0lHKjwWFpCtvz8LXsl73NMQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781276224;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=yu9uNxAYvy81PDQNiOPKiyxf4b3qdKK7nfdfsMOdH2Q=;
	b=Y+ByIo/kEwHetc5f65awOb1NeVjA9K/nTVRlCJ5TPdyHiIIIa6Rb5PKOpFqteNlM/DWZ
	 Bu9NEsMYYH383XrmiDKbCRfPcPh/bgsdjVXbAqeaIViXvh53EoNo7X7ftq2nLG3DBlAhR
	 +sxGy57POMJ8X88uOdyAbBqgl7mH+8hAhFihmoe6S/QwM6vhFpu5GHBvJF7/hQ08IZ9zR
	 tbiCThiZqNs2XHyNh3JKfZU7+CitJUtmVILh1zCirWO0p0LZnL6F2KWcLAgvPtXxbs7Ir
	 tBatcCrYg+sKwO0dSRBqHpg5AgNohulp40RPckZNdF5Zs+l4XyElJjztAR26bjN96Uw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C34FAF80579
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 16:57:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C34FAF80579
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b85d4997839600-webhooks-bot@alsa-project.org>
In-Reply-To: <18b85d499779f100-webhooks-bot@alsa-project.org>
References: <18b85d499779f100-webhooks-bot@alsa-project.org>
Subject: HP Elite x2 G8 Tablet: Mono-Duplicate Left channel on internal
 speakers (ALC3292 + 2x NXP TFA9894)
Date: Fri, 12 Jun 2026 16:57:05 +0200 (CEST)
Message-ID-Hash: MMCHLUKJJ6BSIJWDEYFJRQRKUM4F77YM
X-Message-ID-Hash: MMCHLUKJJ6BSIJWDEYFJRQRKUM4F77YM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MMCHLUKJJ6BSIJWDEYFJRQRKUM4F77YM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #786 was opened from k0styan3:

First I created a bug report here  https://github.com/thesofproject/linux/issues/5807#issuecomment-4676300046 
But in the comments, I was told that this is the wrong place, and a friend advised me to create one here. If someone confirms that this is the correct place for a bug report, I will delete it...
Hello,

I am running Ubuntu on an HP Elite x2 G8 Tablet (Intel Tiger Lake platform). The audio system uses a Realtek ALC3292 codec combined with two discrete NXP TFA9894 amplifiers for the internal speakers.

Currently, the internal speakers are not working correctly (routing issue/wrong fixup applied):
1 - When testing the LEFT channel, sound comes out of BOTH internal speakers simultaneously.
2 - When testing the RIGHT channel, there is absolute silence from the internal speakers.
3 - Audio via the headphone jack (wired) and Bluetooth works perfectly in full stereo.
It seems the driver applies a generic ALC285 fixup (SSID 103c:0000) and fails to properly initialize or route the right-channel NXP TFA9894 amplifier via ACPI/I2C.

I have attached all the necessary debug logs, including alsa-info, codec dump, dmesg, and nhlt.bin.
I can disable Secure Boot and test experimental kernels or SOF topologies.I'm ready to provide any logs, command outputs, or anything else needed to fix the sound on this device! Because the sound was simply amazing under Windows 11! And I really miss it.Could you please help with a proper kernel quirk/fixup for this specific hardware configuration? Thank you!

[alsa-info.txt](https://github.com/user-attachments/files/28884753/alsa-info.txt)

[aplay-l.txt](https://github.com/user-attachments/files/28884780/aplay-l.txt)

[codec_dump.txt](https://github.com/user-attachments/files/28884789/codec_dump.txt)

[dmesg.txt](https://github.com/user-attachments/files/28884805/dmesg.txt)

[nhlt.zip](https://github.com/user-attachments/files/28884813/nhlt.zip)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/786
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
