Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832DDC6FD18
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 04:41:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 446B81F4;
	Wed, 29 Mar 2023 06:40:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 446B81F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680064867;
	bh=/IRKOz6Q8m5IfA6Ipmr4hI8U5BeVBldP01wAXMYEvPs=;
	h=To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:Cc:From;
	b=Dh98GK48LYhU2RHEZ+RHqH3p0VJnb3j88uCetKY0QwQgJf50IK7KFjI0gEf6BwE9d
	 v+gkmEIfnxylJtVxbctyzv84MvYAJbY/gwxqkWnaCdG8XId4Hdn6F3hhB/u/Hqiuk8
	 Rv+g1MrZE6LVyiXWKvRoxFYJYoSBqVTFAETsGMwE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A623DF80272;
	Wed, 29 Mar 2023 06:39:52 +0200 (CEST)
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: ymfpci: Use register macro in place of integer literal
Date: Wed, 29 Mar 2023 07:39:18 +0300
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RPL76L437KLWWQ3PKBQFJPHXDPUDZMTA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
MIME-Version: 1.0
Message-ID: 
 <168006479208.26.12579531357585126343@mailman-core.alsa-project.org>
From: Tasos Sahanidis via Alsa-devel <alsa-devel@alsa-project.org>
Reply-To: Tasos Sahanidis <tasos@tasossah.com>
Cc: tiwai@suse.com, tasos@tasossah.com
Content-Type: message/rfc822
Content-Disposition: inline

Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3509F80272; Wed, 29 Mar 2023 06:39:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_HI,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.6
Received: from devnull.tasossah.com (devnull.tasossah.com
 [IPv6:2001:41d0:1:e60e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0E160F80114
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2023 06:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E160F80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com
 header.a=rsa-sha256 header.s=vps header.b=m+BFAVVc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z9uLcnNCfZgztK165JywkAznDCF4Q2TN8hXiiy3Gjxo=; b=m+BFAVVcAz0JMfbHQrIzPzNiaM
	JDOTzdCQQjU6sMvHVg7kGsnkumRzkjXykV7nI0l/izg6v2tPWPjC85A+ZtwtgY9iVzMdOEy5hiAUo
	PgZGeCPEP5bhF6ZJ7NWFDl6GEJlaedgVD0sRLYI6iKK7vHqJcu+mnD45D5aow2RSNUII=;
Received: from [2a02:587:6a11:9400::d54] (helo=localhost.localdomain)
	by devnull.tasossah.com with esmtpsa  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <tasos@tasossah.com>)
	id 1phNb7-00GusY-3Q; Wed, 29 Mar 2023 07:39:45 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: ymfpci: Use register macro in place of integer literal
Date: Wed, 29 Mar 2023 07:39:18 +0300
Message-Id: <20230329043918.179352-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RPL76L437KLWWQ3PKBQFJPHXDPUDZMTA
X-Message-ID-Hash: RPL76L437KLWWQ3PKBQFJPHXDPUDZMTA
X-MailFrom: tasos@tasossah.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.com, tasos@tasossah.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RPL76L437KLWWQ3PKBQFJPHXDPUDZMTA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The macro for said register already exists, so just use it, to make the
code more readable.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 sound/pci/ymfpci/ymfpci_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 2858736ed..24378f6fd 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2214,7 +2214,7 @@ static void snd_ymfpci_free(struct snd_card *card)
 
 	snd_ymfpci_free_gameport(chip);
 	
-	pci_write_config_word(chip->pci, 0x40, chip->old_legacy_ctrl);
+	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, chip->old_legacy_ctrl);
 	
 	release_firmware(chip->dsp_microcode);
 	release_firmware(chip->controller_microcode);
-- 
2.25.1

