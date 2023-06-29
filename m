Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEDDEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 08:39:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FAD87F4;
	Thu, 29 Jun 2023 10:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FAD87F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688027979;
	bh=K5Qec0A3dH86u/WmMlurFT7f2Ry0hRaAQHSxxVf0e8k=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WC5jKnmioIPHnOfaBrzQfPjmiqLOL9SVwJ4tUXFf+B1hM369jrYOsFEXAXfBxreAk
	 U+ueDmq++mRNK2SyYVYgDGB0Y+lr42P3cmvAAto2v7zxw8dBzYmQ7wnm0GKBh9shP+
	 AhRFz0uZ02Yv4PP77CfaAUdhzDW9n++0HODjnb4A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 763AFF800E3; Thu, 29 Jun 2023 10:38:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF8CFF80534;
	Thu, 29 Jun 2023 10:38:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31691F80246; Thu, 29 Jun 2023 10:38:20 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id D2BF2F80093
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 10:38:19 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Thu, 29 Jun 2023 08:38:19 -0000
Message-ID: <168802789986.22.1719965101425313209@mailman-web.alsa-project.org>
In-Reply-To: <87cz1eepow.wl-tiwai@suse.de>
References: <87cz1eepow.wl-tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: BOQ37PE7AJFRFLDWWRW3PITNHH5BIT4G
X-Message-ID-Hash: BOQ37PE7AJFRFLDWWRW3PITNHH5BIT4G
X-MailFrom: happy.debugging@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BOQ37PE7AJFRFLDWWRW3PITNHH5BIT4G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thanks again. Its getting much clearer now. To summarize:

[a] more than 1 Group Terminal Blocks are supported by the driver for one endpoint, but  [b] you can't have more than 16 groups (per direction) on a single EP.  and [c] if devices (mainly due to Windows)  only support 1 EP, that would mean when using two GTB for 16 groups,  one device cannot go beyond the 16 group limit. That would mean  - in a rare corner case - to design  ay a USB UMP (MIDI 1.0) interface that has legacy DIN I/O it can't go beyond 16 in and 16 OUT  DIN connectors.  

Perhaps a logical use for multiple GTB is to use one GTB per function, but on the others hand designers would probably won't take all that hassle if that if they can do with one GTB for all the functions, and mostly devices have two functions, one for voice data an one for firmware updates or other non-voice purposes.
