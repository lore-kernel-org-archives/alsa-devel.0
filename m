Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE89CD4851
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 07:06:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8247F6021D;
	Wed, 13 May 2026 09:05:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8247F6021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778655963;
	bh=VY0nH4fNSWXmqgQc5l0gOS386/n1HppOuLyw5E9ye54=;
	h=Date:To:Cc:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vjaAWJrkr40pEt0FCMRhxuO0AA92Eex8Eb08HQgoLKEZJz2z0klEedDw75YsRITbk
	 m6/iln1oFic9cyT/1KiA0NB/nwQrVPp/j9OvTnIptVi7w8huHlt8O9zCIUgj+UZH69
	 BcQaVDZu5LUCC5mqE3P+S1QyEwfXxL8SyPjSgrmk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC599F805FE; Wed, 13 May 2026 09:05:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 363AFF805F9;
	Wed, 13 May 2026 09:05:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B9CAF804CC; Tue, 12 May 2026 15:50:10 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 79D85F8012B
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2026 15:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79D85F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=losource.net header.i=@losource.net header.a=rsa-sha256
 header.s=gm1 header.b=H+428pbx
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CD223EBD7;
	Tue, 12 May 2026 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=losource.net;
	s=gm1; t=1778593807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SQcpvvcsFpc4lUxxbzQCXavuq6vrMbtf+84G74KdPNA=;
	b=H+428pbxjPwDjNEN3eeXEe67sV0O/jrJr6ZOnrt0Svn6Dxnil9LNRUqOR3jcJ21xBIu9UD
	KYIC7WyevKDfK/gQqqgKqWowmTgMMhyBlLXNdlYmoDl/IoCdhQ+HU2ofjc/gjZWo5t41Ox
	E9gGpZr4qSu9NQDm9Drgec9fHYCyljVZ71v8yk6K/0YcHu1TLY8bfQLxxeYNhFdzMRD71D
	Fa1YkGdrgNI3PodO/gUibE5pOm9cADwCw52nMmkZRRajpKg82A4AVZe5yKtNoekhQzM/Ls
	PuSi442wcrrT44FV1LVrclzYqCCYESUbS5K2/NBlDkheZ0XXvz0A4+tY6y/gGA==
Message-ID: <59fd4aa4-76b9-4984-8db9-a60e55ec6e80@losource.net>
Date: Tue, 12 May 2026 14:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, kailang@realtek.com, dnaim@cachyos.org
From: Rob Blake <rob@losource.net>
Subject: equest to upstream: ALC287_FIXUP_TXNW2781_I2C quirk for ASUS Strix
 Gxx5 family (CachyOS commit 20313d76)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rob@losource.net
X-GND-Cause: 
 dmFkZTGe5hbmQ6kAqBfaSa1s6gc+1NhmPoZMCqrroSna/TcVZf7Tbzy3ceqQayuJ/avRvlWZb9RXjCSW5mHd9yx9BguqhuMq0j7bdz7mkQOVRCLvZdvhkYfJwNrcAeivA/RU0jNiiCXB0WkAP+JWPwaTYcGrHRZu3bvYhnsiOiGmRu3AtdCWi7lbr3eVnRBWFnr4n9C1NUtEtXrZmClnPXg0hLei4/WBQwU5g7W0+dXkID2Z99nOaniYczazp/PIRFdlTJKc7Clee7HQJsiEfaAjECHZrsmhZROG2kD9XEdE7aNIxDXwjUcvjcg8OJ8xz3INPMR3tOXyjIqSuGza8R3IP5jdq9CERbcaYuMibICsfSWE/z0uKYad9tEXLpxeL9Fgh1GgNDLgDeSkPpuUkN5NgMkj5w6UIEM49bpHjMISmpMR1kkNN3TRnPtQM0OYD2ays9jJ0l+CyS4T9MEPvfPocYPNjzmb1RpGhmPDA7ki2IvowsTgpfDP56zfeY0+mlZO4VZ3Hjrn2D3FD+zThIu0jCfURVNPOoRUElVXbUf9JezITZ67ZxZCnDcMXrOpEachsENrliEcYadyxdbsg4e2+WeNQPpBoBG2QAGdG5z0b5jXqgsqHyNs9HAq+2m/4wwcPDOXYf+OeyS4GRg5V4ETqLIk4Jt9/NrqsgaF/OLQcxr0TA
X-GND-State: clean
X-GND-Score: 0
X-MailFrom: rob@losource.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: I27ONJHZR2IK5U2YWO2KJYVE7Y7HBAIB
X-Message-ID-Hash: I27ONJHZR2IK5U2YWO2KJYVE7Y7HBAIB
X-Mailman-Approved-At: Wed, 13 May 2026 07:05:00 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I27ONJHZR2IK5U2YWO2KJYVE7Y7HBAIB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi all,

I'm writing to ask whether the small fixup-table change below can be 
picked up for mainline. It's already in CachyOS's downstream tree since 
2026-03-06 and is reported to restore speaker audio on an
entire family of recent ASUS ROG Strix laptops, including mine.

The relevant commit is by Eric Naim <dnaim@cachyos.org>:

   CachyOS commit 20313d767be2e5abdb88295b7c724634e1937a4f
   "ALSA: hda/realtek: Use ALC287_FIXUP_TXNW2781_I2C for ASUS Strix Gxx5"
https://github.com/CachyOS/linux/commit/20313d767be2e5abdb88295b7c724634e1937a4f

The change is a six-line edit to sound/hda/codecs/realtek/alc269.c: the 
affected SSIDs are currently mapped to ALC287_FIXUP_TAS2781_I2C but 
actually need ALC287_FIXUP_TXNW2781_I2C. The wrong quirk leaves the I²C 
interrupt config inconsistent with the ACPI TXNW2781 entry, so 
serial-multi-instantiate fails to resolve IRQ index 0 for each of the 
three amp channels, and only the first channel binds.

SSIDs affected (per Eric's patch):
   0x1043 0x3ee0  ASUS Strix G815_JHR_JMR_JPR
   0x1043 0x3ef0  ASUS Strix G635LR_LW_LX
   0x1043 0x3f00  ASUS Strix G815LH_LM_LP
   0x1043 0x3f10  ASUS Strix G835LR_LW_LX
   0x1043 0x3f20  ASUS Strix G615LR_LW   <-- my machine
   0x1043 0x3f30  ASUS Strix G815LR_LW

On my G615LW (SSID 1043:3f20) running kernel 6.19.14-101.fc44, the
broken state matches Eric's commit log exactly:

   Serial bus multi instantiate pseudo device driver TXNW2781:00: error 
-ENXIO: IRQ index 0 not found
   Serial bus multi instantiate pseudo device driver TXNW2781:00: error 
-ENXIO: IRQ index 0 not found
   Serial bus multi instantiate pseudo device driver TXNW2781:00: error 
-ENXIO: IRQ index 0 not found
   Serial bus multi instantiate pseudo device driver TXNW2781:00: 
Instantiated 3 I2C devices.

with .0 binding to tas2781-hda and .1/.2 staying at driver=NONE.
Speakers are silent. Headphones work (they're on a separate codec pin 
and don't involve TAS2781).

I've ruled out asusd as the cause — I rebooted with asusd masked and the 
failure is identical, so this is purely codec-quirk-table business.

Original upstream report:
https://lore.kernel.org/CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com

CachyOS issue with discussion:
   https://github.com/CachyOS/linux-cachyos/issues/752

I'm not a kernel developer and don't feel qualified to submit Eric's 
patch on his behalf. Could one of you (or Eric, if you're on this list) 
take a look and consider sending it for inclusion? It's a self-contained 
six-line change that fixes audio for a sizeable family of shipping 
laptops, and the patch is already authored and signed-off.

Happy to test patches against my G615LW.

Thanks,

Rob

-- 
Rob Blake

Director

Losource Ltd

Tel: +44(0)7951 081480

Privacy Notice: This email and any attachments to it may be confidential 
and are intended solely for the use of the individual to whom it is 
addressed. Any views or opinions expressed are solely those of the 
author and do not necessarily represent those of Losource Ltd. If you 
are not the intended recipient of this email, you must neither take any 
action based upon its contents, nor copy or show it to anyone. Please 
contact the sender if you believe you have received this email in error.
