Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023C606A329
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=G/rRUlxG;
	dkim=pass (2048-bit key, unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 296AE60201;
	Mon,  2 Nov 2026 22:14:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 296AE60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793654099;
	bh=8ONJqSAZV2Yx9p5ppT7rr0hTr9JK7MWUB8wuPRz34KI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=G/rRUlxGLDHxjOcUGSkymD25MQulIualDYZFnGKDu4R545TwknRGC4RZ/zh+aQoFr
	 VKgoWp1WnHGW8JBb2r0Mrli1lQSse5ThRHixcpYzhgoEu+dh6VJUaA8OL8wY2kIbQf
	 30uT1exMOGrR4F6JXwjYwHDHq693lMQsmGv5w/fE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C6B3F80674; Mon,  2 Nov 2026 22:13:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7ABCF80680;
	Mon,  2 Nov 2026 22:13:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E82CF8016E; Mon,  2 Nov 2026 19:01:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_48_96,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=185.232.107.110
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793642497;
	b=iFBE93+b2iD0RY4wxw14mB//1hcaSqsGYPGUxAMWNl9Ww3jvFUJLArkpGTCPcG9FrYee
	 nvn5qUok7F6tX2XfN3tPm4a0s9owFD0l15yMDqNwdbxq5qkdAxUtH0tsrsbCl11FDxudC
	 5UIMU89BwSrfkxQyLM8DYLMjROPQeLdodjciZxzskV2uibLTn92y5uxHtmxjD47z5XNMw
	 y3VZnObTuT0aZWpp2bPzNYMBnId0/0/WQHofRJP8n+n1QYiz+UcHoY55llSZiW0p7Kngl
	 dqxgVBunoNYIUMGS38xRsoRPKcnPiWUZ69VHAan5371CwKqrepxeoKKQTc4m0KmlUcQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793642497;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:MIME-Version;
	bh=8ONJqSAZV2Yx9p5ppT7rr0hTr9JK7MWUB8wuPRz34KI=;
	b=OK40CeK2/XF2niszEi8e0cA2qwAvb4wnYunzLGPm6QrlW8Cotrf8JGqCo2YCWszd7kvR
	 vUeXu/Lp2NWmo6BZJCgVqh7D+UMFbdMmAeYvHO7RqOOCi83x+sfQiJzkTNNSp/jRRUDt3
	 9cMK+Y43HxvGUd0QiSHvlfOuHow+8t4+SOBoV7V6AS+3dlgwL5/+VGFsBNt703obFqxYh
	 ZCfwS+tibH5OQBN8bFi3tTL9DyZGKSJ/7QL2PHkW4H4x+UGkVN7Ou+X42z91dDCEIBlZ+
	 YBtyc8p2lExDfNKYpe1yvWW1IoHZ/KM2CVoQ7LX7lKi4qDhwaz2PglzR6n7mJHVw6Fw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr;
	arc=none smtp.remote-ip=185.232.107.110
Received: from mx1.cyberprotect.ru (mx1.cyberprotect.ru [185.232.107.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A9DF7F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 19:01:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9DF7F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr;
	dkim=pass (2048-bit key) header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=QuS4jBxd;
	dkim=neutral header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b=Y57LJXjr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=GYxzBfV8nb382eo52z1jeyt/BLYppy/OrUDjVytaEig=; b=QuS4jBxdw067+NggE0xgNIi8NR
	GuFsxheNmzKidZcHFzLR6rklV79nUeAKdwEl2Has80OZ51/nlEyDjM/2unzONzZ/eRgTGV8OVy25q
	nKFDx7YXV1PsM+4fLfdiiCZpq+9RI6eQ22MzpYZuhmgr/DnX7w0p+5r/AG40UrTJCoQl4llqYijnF
	AAerwV/iRLirm+/QyxdiAfhgHVq/CB2Ki/HDEo9b4W2UlqUsHtDF5MKfo39m43zdIZ+Tl0jRl0etb
	tIaRCfHcofVGKeRkrhNdFjdYleRsoLlfQ+eexmXZgMMfAEt8adg3WPDVVUeIUYCtT1tHI1PDYMM1p
	4Ui85Whg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=GYxzBfV8nb382eo52z1jeyt/BLYppy/OrUDjVytaEig=; b=Y57LJXjrCWbPUhFtq0k5kFusQu
	lfaamp727G7T/y5l642QXtWPv5y31FuA9aYzqRD2dHtPKSqXI5/fb7TsNzBA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=GYxzBfV8nb382eo52z1jeyt/BLYppy/OrUDjVytaEig=; b=QuS4jBxdw067+NggE0xgNIi8NR
	GuFsxheNmzKidZcHFzLR6rklV79nUeAKdwEl2Has80OZ51/nlEyDjM/2unzONzZ/eRgTGV8OVy25q
	nKFDx7YXV1PsM+4fLfdiiCZpq+9RI6eQ22MzpYZuhmgr/DnX7w0p+5r/AG40UrTJCoQl4llqYijnF
	AAerwV/iRLirm+/QyxdiAfhgHVq/CB2Ki/HDEo9b4W2UlqUsHtDF5MKfo39m43zdIZ+Tl0jRl0etb
	tIaRCfHcofVGKeRkrhNdFjdYleRsoLlfQ+eexmXZgMMfAEt8adg3WPDVVUeIUYCtT1tHI1PDYMM1p
	4Ui85Whg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=GYxzBfV8nb382eo52z1jeyt/BLYppy/OrUDjVytaEig=; b=Y57LJXjrCWbPUhFtq0k5kFusQu
	lfaamp727G7T/y5l642QXtWPv5y31FuA9aYzqRD2dHtPKSqXI5/fb7TsNzBA==;
From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
To: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>, Mehul Rao <mehulrao@gmail.com>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>, Norbert Szetei
	<norbert@doyensec.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dmitriy
 Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Subject: [PATCH] ALSA: pcm: Don't WARN on NULL dma_area in the default mmap
 fault handler
Date: Fri, 30 Oct 2026 14:25:02 +0300
Message-ID: <20261030112502.22227-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AIP-EXCH-1.aip.ooo (10.77.28.101) To AIP-EXCH-1.aip.ooo
 (10.77.28.101)
X-MailFrom: Dmitry.Chumachenko@cyberprotect.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SPVYLJ2FENHOWRS6MFSFEUUBHMVTGDDT
X-Message-ID-Hash: SPVYLJ2FENHOWRS6MFSFEUUBHMVTGDDT
X-Mailman-Approved-At: Mon, 02 Nov 2026 21:13:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SPVYLJ2FENHOWRS6MFSFEUUBHMVTGDDT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

During fuzz testing, the following issue was discovered.

WARNING: CPU: 2 PID: 1734 at sound/core/pcm_native.c:3835 
snd_pcm_mmap_data_fault+0x47f/0x530 sound/core/pcm_native.c:3835

Modules linked in:
CPU: 2 PID: 1734 Comm: syz.1.352 Not tainted 6.1.187-syzkaller-00593-g063a81552262 #0
RIP: 0010:snd_pcm_mmap_data_fault+0x47f/0x530 sound/core/pcm_native.c:3835

Call Trace:
 <TASK>
 __do_fault+0x10d/0x480 mm/memory.c:4280
 do_cow_fault mm/memory.c:4661 [inline]
 do_fault+0xa7a/0x1100 mm/memory.c:4762
 handle_pte_fault mm/memory.c:5031 [inline]
 __handle_mm_fault+0xdf3/0x2e40 mm/memory.c:5173
 handle_mm_fault+0x2da/0xa60 mm/memory.c:5294
 do_user_addr_fault+0x4aa/0x1050 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x98/0x1b0 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:608

snd_pcm_mmap_data_fault() guards the default RAM-buffer path with
WARN_ON_ONCE(!runtime->dma_area). As commit d2913a07d903 notes, a driver
may allow mmap before dma_area is set up, so this state is reachable from
user space: mmap the PCM data region and fault it while the buffer is not
allocated. The WARN then fires on a user-triggerable path and panics a
kernel with panic_on_warn.

Drop the WARN; the NULL check and VM_FAULT_SIGBUS return stay, which is
the correct silent handling.

Fixes: d2913a07d903 ("ALSA: pcm: Add sanity NULL check for the default mmap fault handler")
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index fcb5f176f0df..dd640d90f6a3 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3832,7 +3832,7 @@ static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 	if (substream->ops->page)
 		page = substream->ops->page(substream, offset);
 	else if (!snd_pcm_get_dma_buf(substream)) {
-		if (WARN_ON_ONCE(!runtime->dma_area))
+		if (!runtime->dma_area)
 			return VM_FAULT_SIGBUS;
 		page = virt_to_page(runtime->dma_area + offset);
 	} else
-- 
2.49.0

