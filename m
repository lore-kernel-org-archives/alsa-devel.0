Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D11CD8CA8
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:59:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A1AB601AF;
	Fri, 12 Jun 2026 16:58:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A1AB601AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781276343;
	bh=iLSlY5mRlKo115bVVwKVk4daRUEY1p14dQZ2XYNnur0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=X+XTX2aL/dwK8HxokbvljlRWwuUMqPSrixBHIrnt5rtg+86c+yISI6rn1XgKK2PdI
	 ZB4B7aiVduC+5PFD9pTl8E5D2G17XZtZVfWTrhBAMgLjBz4UYIwPp3aoExQZkGiuJY
	 BeOp0b5Vec+QcRrQFeX/SOojW6//OI2hjr3A7sc8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2911EF805EA; Fri, 12 Jun 2026 16:58:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D96CEF805F8;
	Fri, 12 Jun 2026 16:58:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9494F805D3; Fri, 12 Jun 2026 16:58:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781276298;
	b=iTFcRdG7Ul3nMdQ/EnQqqGV0vinhdJIP5HSf8L0JCTHXlFPdWPPaGpTrQWkLDUYr7pt0
	 OnmqPlSpVe4n8uUCSU+cFc3s7+QCznr9z5D+Li8zQy3hIU0w7+gEj7cxTeCYfohI05mbX
	 o9k1rsdrGX5qdiNDX5JqHW4iekYeV6NqL9aN5tfNIUqhcXX3mK8Ogxi3Iio7v2vxHqDWN
	 LcBKxW0ORgbp+aKTXwA8zj7atD4CQT9YxjS1MK+BMrNM5XfeQqiaNoajLKhMAUL5RGKvd
	 fWETG5XVBXUoJWmL8+jsuhaUWd8NCYePc2JrEIOcHh+CiLNIJ/CF0Q79WkZYwfXt8qA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781276298;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=iLSlY5mRlKo115bVVwKVk4daRUEY1p14dQZ2XYNnur0=;
	b=QJyxDuwFNL3mjXarFYa/NcLMFsAxBdbJw1C0cd/IKkZ5F4zcVJjrkFfA3QBpdXKyj37Q
	 YPxcSj9sbH9XkGuiY7kTPS/151dlzajjzhz0ELMcEgWNoIRcYT85CdDTYJhV6zQIQoEsm
	 GyeBqwMnI32kwyEw4FCHShEJgQtyYfgKLcOZtAOHdDKR6K6EhMf3yi/uIh7DDxwdPZC9y
	 JTDi8Mpp4jmDma+H07ZrYzhCspGzJqd2CMenjBkSkvki3BM1mUz9897jL0jPV3WBFV8is
	 Xy0Kcv1WvCfJAWrekJHeAKhpF1xxpkqaXCMhy2/ZOpGwfURZ5hH8mQJEzfvtXwMSt3w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AC72F805CB
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 16:58:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AC72F805CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b85d5ad3287b00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b85d5ad3252300-webhooks-bot@alsa-project.org>
References: <18b85d5ad3252300-webhooks-bot@alsa-project.org>
Subject: HP Elite x2 G8 Tablet: Mono-Duplicate Left channel on internal
 speakers (ALC3292 + 2x NXP TFA9894).It seems the driver applies a generic
 ALC285 fixup (SSID 103c:0000)
Date: Fri, 12 Jun 2026 16:58:22 +0200 (CEST)
Message-ID-Hash: XOAST5UXCVH5EJK4FTOTFDWHULJHH7TE
X-Message-ID-Hash: XOAST5UXCVH5EJK4FTOTFDWHULJHH7TE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOAST5UXCVH5EJK4FTOTFDWHULJHH7TE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #786 was edited from k0styan3:

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
