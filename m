Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D1BC25B74
	for <alsa-devel@archiver.kernel.org>; Tue, 21 May 2024 14:08:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4399DEC;
	Tue, 21 May 2024 16:08:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4399DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716300517;
	bh=mUJ68N6msczBB9C/8LlQHDYjFu+UJe5YHP1HFLKiZyg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HZ8fIMYo2MhvTfx1d4g9HFJn86x7BFrcNNlug/jXLgyn2hr0GEOHAwwHOL9SVFFb5
	 Vze8PIbmUd30I20uh9o/L8L9pN29Rj1U1Gdlms7U1plLlVtHavbZAkZkldVAcHrj3S
	 1K1FSy4EAxCCF7MV23FVs0+Qb5RU6ZmI7H6ST+ic=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30421F805BF; Tue, 21 May 2024 16:07:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3540F805AB;
	Tue, 21 May 2024 16:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92A94F8026A; Tue, 21 May 2024 03:04:49 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D6A92F801F5
	for <alsa-devel@alsa-project.org>; Tue, 21 May 2024 03:04:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6A92F801F5
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABXXhoe80tmEMlyBg--.49483S2;
	Tue, 21 May 2024 09:04:30 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ALSA: scarlett2: Prevent leaking urb
Date: Tue, 21 May 2024 09:03:52 +0800
Message-Id: <20240521010352.1082164-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXXhoe80tmEMlyBg--.49483S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43XryUAw4UCw45Ar45GFg_yoWfXwc_Wa
	yI9w1DAF1DWrnIkry5CrWSvF40kwnrAF18uFsI9397tF9Fq34rtw1Iqrn8CF1xZFs5JF4D
	Xrn7Z343try29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWkMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUFVyIUUUUU
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-MailFrom: nichen@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3USRERKKWNDCQ7JFO22FADP3VL6UDOLM
X-Message-ID-Hash: 3USRERKKWNDCQ7JFO22FADP3VL6UDOLM
X-Mailman-Approved-At: Tue, 21 May 2024 14:06:39 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3USRERKKWNDCQ7JFO22FADP3VL6UDOLM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In scarlett2_init_notify() if kmalloc() fails the allocated urb should
be released.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/usb/mixer_scarlett2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 1150cf104985..4cad6b2a0292 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -8637,9 +8637,10 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 		return -ENOMEM;
 
 	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
-	if (!transfer_buffer)
+	if (!transfer_buffer) {
+		usb_free_urb(mixer->urb);
 		return -ENOMEM;
-
+	}
 	usb_fill_int_urb(mixer->urb, dev, pipe,
 			 transfer_buffer, private->wMaxPacketSize,
 			 scarlett2_notify, mixer, private->bInterval);
-- 
2.25.1

