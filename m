Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF1CD4F25
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 13:51:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D12460227;
	Fri, 15 May 2026 15:51:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D12460227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778853078;
	bh=dph6BiP8RbcNJ6bkY7Uk0p3HKIsRFVvKkdjNZZPcMSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jq7V/l0rEarEmZUmG5JR5SrK0E+6jbUgNvBP6Py/PHbxq9hCQ6y0GuXZIWPoOeMEZ
	 rlMiCJxZOSGebHOpc6THmo2oLXpYASPMjXjIJYbwnNG6y+6XKVV6NGQMFEOubAy4mw
	 hdrENw9BYlOTlwgxvLXzQRG3atdt0ZYgmx54EA4w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83BCAF80621; Fri, 15 May 2026 15:50:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53084F80621;
	Fri, 15 May 2026 15:50:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3151F80557; Fri, 15 May 2026 14:40:31 +0200 (CEST)
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA0CCF800D0
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 14:40:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA0CCF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cachyos.org header.i=@cachyos.org header.a=rsa-sha256
 header.s=dkim header.b=OO4pmBaV
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C16EF281653;
	Fri, 15 May 2026 14:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1778848828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K3OV51EMJUFKs8ceGY8nB3mnJ1QtvQpvwmqTP8bB5N8=;
	b=OO4pmBaVywPeXKkCzdd+iYSTbosJhP1ACnB//2xKG/2RoxLjSm46NYW9U/8/Gm2oWrD8Wf
	IolPmImBxSc7mGZQF2oVFzziJ0aczbU2Fq+IH/QiA+ci6F7z4oFpZ7kLNtpdWocFsqY9EX
	3zuYz96ap9DrqKvPJMB4Lx1tA9VpfKwwNdhQFp01cWTBBAsdF5k3e4B1PDVxRj32p3kMrO
	SDarEy2Ox7NA7s1r9oVCrzK5gI10WiMt+0SbQwdqv7kFC594nVF+SZEdM2SoMlKF993MUg
	LtAgntVbfb8KxngIOxMrytpj7Nq/FPDj8wJsyTg+Sd2hAdmV1btPpu9reVIpFg==
Message-ID: <7e8c59c5-8459-4c74-9d32-d3b3b66210fc@cachyos.org>
Date: Fri, 15 May 2026 12:40:00 +0000
MIME-Version: 1.0
Subject: Re: equest to upstream: ALC287_FIXUP_TXNW2781_I2C quirk for ASUS
 Strix Gxx5 family (CachyOS commit 20313d76)
To: Takashi Iwai <tiwai@suse.de>
Cc: Rob Blake <rob@losource.net>, alsa-devel@alsa-project.org,
 kailang@realtek.com, baojun.xu@ti.com
References: <59fd4aa4-76b9-4984-8db9-a60e55ec6e80@losource.net>
 <7650fdea-6b8a-4116-9560-ac6b2f6c54b1@cachyos.org>
 <87o6iht559.wl-tiwai@suse.de>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <87o6iht559.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: dnaim@cachyos.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KZ2IJSBQ23JTMWTH3ECX3SET72UMRBZY
X-Message-ID-Hash: KZ2IJSBQ23JTMWTH3ECX3SET72UMRBZY
X-Mailman-Approved-At: Fri, 15 May 2026 13:50:20 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KZ2IJSBQ23JTMWTH3ECX3SET72UMRBZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 5/15/26 5:04 PM, Takashi Iwai wrote:
> On Wed, 13 May 2026 11:24:00 +0200,
> Eric Naim wrote:
>>
>> On 5/12/26 9:50 PM, Rob Blake wrote:
>>> Hi all,
>>>
>>> I'm writing to ask whether the small fixup-table change below can be picked up
>>> for mainline. It's already in CachyOS's downstream tree since 2026-03-06 and
>>> is reported to restore speaker audio on an
>>> entire family of recent ASUS ROG Strix laptops, including mine.
>>>
>>> The relevant commit is by Eric Naim <dnaim@cachyos.org>:
>>>
>>>   CachyOS commit 20313d767be2e5abdb88295b7c724634e1937a4f
>>>   "ALSA: hda/realtek: Use ALC287_FIXUP_TXNW2781_I2C for ASUS Strix Gxx5"
>>> https://github.com/CachyOS/linux/commit/20313d767be2e5abdb88295b7c724634e1937a4f
>>>
>>> The change is a six-line edit to sound/hda/codecs/realtek/alc269.c: the
>>> affected SSIDs are currently mapped to ALC287_FIXUP_TAS2781_I2C but actually
>>> need ALC287_FIXUP_TXNW2781_I2C. The wrong quirk leaves the I²C interrupt
>>> config inconsistent with the ACPI TXNW2781 entry, so serial-multi-instantiate
>>> fails to resolve IRQ index 0 for each of the three amp channels, and only the
>>> first channel binds.
>>>
>>> SSIDs affected (per Eric's patch):
>>>   0x1043 0x3ee0  ASUS Strix G815_JHR_JMR_JPR
>>>   0x1043 0x3ef0  ASUS Strix G635LR_LW_LX
>>>   0x1043 0x3f00  ASUS Strix G815LH_LM_LP
>>>   0x1043 0x3f10  ASUS Strix G835LR_LW_LX
>>>   0x1043 0x3f20  ASUS Strix G615LR_LW   <-- my machine
>>>   0x1043 0x3f30  ASUS Strix G815LR_LW
>>>
>>> On my G615LW (SSID 1043:3f20) running kernel 6.19.14-101.fc44, the
>>> broken state matches Eric's commit log exactly:
>>>
>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
>>> IRQ index 0 not found
>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
>>> IRQ index 0 not found
>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: error -ENXIO:
>>> IRQ index 0 not found
>>>   Serial bus multi instantiate pseudo device driver TXNW2781:00: Instantiated
>>> 3 I2C devices.
>>>
>>> with .0 binding to tas2781-hda and .1/.2 staying at driver=NONE.
>>> Speakers are silent. Headphones work (they're on a separate codec pin and
>>> don't involve TAS2781).
>>>
>>> I've ruled out asusd as the cause — I rebooted with asusd masked and the
>>> failure is identical, so this is purely codec-quirk-table business.
>>>
>>> Original upstream report:
>>> https://lore.kernel.org/
>>> CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com
>>>
>>> CachyOS issue with discussion:
>>>   https://github.com/CachyOS/linux-cachyos/issues/752
>>>
>>> I'm not a kernel developer and don't feel qualified to submit Eric's patch on
>>> his behalf. Could one of you (or Eric, if you're on this list) take a look and
>>> consider sending it for inclusion? It's a self-contained six-line change that
>>> fixes audio for a sizeable family of shipping laptops, and the patch is
>>> already authored and signed-off.
>>>
>>> Happy to test patches against my G615LW.
>>>
>>> Thanks,
>>>
>>> Rob
>>>
>>
>> Hi Rob,
>>
>> I've sent this patch 2 months ago [1]. I never got a reply from Baojun so I
>> myself am unsure as to how to proceed, cc'ing them here to hopefully get a reply.
>>
>> [1] https://lore.kernel.org/linux-sound/20260315160939.191265-1-dnaim@cachyos.org/
> 
> Indeed.  If no further followup appears, I'm going to pick up Eric's
> v2 patch in the next week.
> 
> 

Glad to hear that! I haven't sent any v2, but I will do so in the next few
days. I assume here the v2 will only cover the 2 confirmed misbehaving devices
instead of the full 6 in the first iteration, yes?

> thanks,
> 
> Takashi


-- 
Regards,
  Eric
