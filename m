Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88898606A321
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=YUgJNFOB;
	dkim=pass (2048-bit key, unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=rsa-sha256 header.s=dkim-r header.b=UYOW2Gi3;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru header.a=ed25519-sha256 header.s=dkim header.b=4irY/SdN
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B58EC601ED;
	Mon, 23 Nov 2026 13:04:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B58EC601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435475;
	bh=MFZFUEvwdKSCsHtxa6z0s5xsNlmgcuL1UDvLJNazTPc=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YUgJNFOBzKaib92YfCQmG0A66KCoPDrVyFCP6DAWlXbU7ZaNxrlg2fvbxLf/XTgBt
	 Z1UtImcTBEYNG1D0bu1MCWQ94XUJF3QmcMLfXzbYjh35LPwk34zSA63pgdSJba/jhT
	 I/wbntHKpzcN8EOqa0EOsx9zgDsBCFakWMYg8NTU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A679AF806CA; Mon, 23 Nov 2026 13:02:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C83B9F806CA;
	Mon, 23 Nov 2026 13:02:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3201CF80538; Wed, 18 Nov 2026 14:20:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=176.10.93.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795008014;
	b=eksOnJoKtzzaLygeMKx8XVttKdx/PDnYUuU6jB7BC61Sm38pwnlTlWA8Ej+lJDOMXxk5
	 +dg8A8uaVUWi43cTvkIbT0IKAur5nHk+BnMLFTsaaLbGNYaiJzEhMcE+rvmZ/6EqLO13o
	 fxYtCCiQYB9OgdHBJbQ6z8bKThzkquYFw/ULjWsjKEfHHzK3h51kC3wF5vO9JTbMQKGEq
	 Qo7ipBtvJOYFpJdhmoMDcVXMxIduDNCE0XuriVzpWOlSduCwtUB62WZrl0r3WMNOE1e8x
	 sAc8R9cxUixKW9YxyUllMpyioJkpmSjJrWiCwL/JHy6DPAJRXMGBKoIG6t5pQOrTZTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795008014;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=MFZFUEvwdKSCsHtxa6z0s5xsNlmgcuL1UDvLJNazTPc=;
	b=OAKi7IccpHrlsW+xVgl2ylQIqjWD6tupCXPYT5WwgkY29qzbPyVbbEkZo+smP6PRJCV8
	 ZaN2yMEZjUrH/tJp/JoAwSR2OFviGGZkwdBsYOVFKb2x8ymkkwiXjHoqKtKpTnP/fTSIK
	 psof15toXwvvmoCAZxyz5kHIsZyczfuw+z4ShH559h2axqjILUSDix58cddUbk8hZT4iL
	 YEOsOZWHY96Bhc11IgkoBp1/8MO2bX24J2ZpasTsHvXXdOW+g/FwSyO8gisftrVJm1zf+
	 CuZASKYWwpE5y24XxMYHaoWIoVgz+3ZhOYm5PKmDVx5HlBBH7w8ALeBArr+946OPZcQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=UYOW2Gi3;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b="4irY/SdN";
	arc=none smtp.remote-ip=176.10.93.31
Received: from mx2.cyberprotect.ru (mx2.cyberprotect.ru [176.10.93.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DF07BF80152
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2026 14:20:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF07BF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=rsa-sha256 header.s=dkim-r header.b=UYOW2Gi3;
	dkim=pass header.d=cyberprotect.ru header.i=@cyberprotect.ru
 header.a=ed25519-sha256 header.s=dkim header.b=4irY/SdN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=32cyXCU1sWs+5TgmQguEoU4tTwPL+UvYB/tYlKxvnd8=; b=UYOW2Gi3CMf/tAuu7+s8KX8Wv9
	py4RP9kUFn7kmDO/JKczP71w9pntQCWbe89qEaIBDBJkOsIPuYBd5k1E1AMi4/tPX6pyn408uCpcQ
	29cBLWrdmkKi/24V8uH44pChKqH+01LNp9AyHibaBFWVZBm32aPfaodYT5Bx8DIHlBhb2x0eGAJaz
	WOBLL4fTvlZCQs8I9YpwBdFqXyuwWHMeHRzzQSFPGq3zQqTMsUW5eAuqoH1DJTA0xqpBmnkMQHFJ/
	Ydt6rk/q6OibKhau3Qs0RUnkF6rSjRAiUbeZnz51GyBKba2xQjDprVqxeNmELECAJg+KJAxEK5QH6
	OuWTRbVw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
	bh=32cyXCU1sWs+5TgmQguEoU4tTwPL+UvYB/tYlKxvnd8=; b=4irY/SdNPUamy7Q3S+eHGD7jMd
	lg6PWy+mOHZ9ZIhEj3bb1IPvu4ivYexv3VkmP2zRAB1hANCfd4SL/qfiBUDg==;
From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
To: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>, Mehul Rao <mehulrao@gmail.com>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>, Norbert Szetei
	<norbert@doyensec.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dmitriy
 Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Subject: [PATCH v2] ALSA: pcm_oss: reject buffer reconfiguration while the
 stream is mmapped
Date: Wed, 18 Nov 2026 16:19:45 +0300
Message-ID: <20261118131945.27592-1-Dmitry.Chumachenko@cyberprotect.ru>
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
Message-ID-Hash: 6DN4KIPVJ6GIX7SDQ7OT3DCP5SYUQTSB
X-Message-ID-Hash: 6DN4KIPVJ6GIX7SDQ7OT3DCP5SYUQTSB
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:14 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6DN4KIPVJ6GIX7SDQ7OT3DCP5SYUQTSB/>
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

snd_pcm_oss_change_params() frees and reallocates the substream buffer,
and several OSS entry points reach it while the data area may already be
mmapped: snd_pcm_oss_mmap() and the SNDCTL_DSP_GETOSPACE/GETISPACE ioctls
(snd_pcm_oss_get_space()).

For OSS streams snd_pcm_hw_params() skips the mmap_count guard
(!is_oss_stream), so the buffer is torn down under a live mapping. If the
reallocation then fails, the substream is left with runtime->dma_area ==
NULL, and the next page fault on the stale mapping reaches
snd_pcm_mmap_data_fault() with no buffer, hitting the WARN_ON_ONCE().

Reject the reconfiguration in snd_pcm_oss_change_params_locked() when the
stream is already mmapped; this covers all callers (read/write already
bail out earlier on a non-zero mmap_count). The core WARN_ON_ONCE() is
left in place.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
v2: Fix the root cause in the OSS layer instead of silencing the core
    warning. v1 dropped the WARN_ON_ONCE() in snd_pcm_mmap_data_fault();
    v2 refuses to reconfigure (and free) the buffer while a data mapping
    is active, which is what left dma_area NULL.
 sound/core/oss/pcm_oss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 2dbc27831eb3..4ce9ecaa6ab1 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -861,6 +861,8 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 
 	if (!runtime->oss.params)
 		return 0;
+	if (atomic_read(&substream->mmap_count))
+		return -EBADFD;
 	sw_params = kzalloc_obj(*sw_params);
 	params = kmalloc_obj(*params);
 	sparams = kmalloc_obj(*sparams);
-- 
2.49.0

