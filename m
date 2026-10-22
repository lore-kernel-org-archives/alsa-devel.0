Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF5606A31D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=jQyLJOGY;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MpVU+mj2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3148A601DA;
	Thu, 22 Oct 2026 10:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3148A601DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792659329;
	bh=99NUKuOb7qBFPk1RiJkvjJxLya1woaDEYoEchGZy0R4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jQyLJOGYcJyx/AlALTweJv255ma4IORYxrshtqFm7HQbtuMYcRoC5JPgUhqtfVNEb
	 AHcId/xRB+H4sFGcCBd0gczrI0IUH4QY7MAFjDf1+XxGJTNG8xDbgeS1jPd/VFmTcH
	 HFenAYe3wwZL67P4EhiErUTkdkoUGAtS7rLGj3Zk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AFB6F80603; Thu, 22 Oct 2026 10:54:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15E59F80600;
	Thu, 22 Oct 2026 10:54:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6710FF804CC; Thu, 22 Oct 2026 10:54:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2AABF800F3
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 10:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2AABF800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=MpVU+mj2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2r
	K4ek6R2FxmaG7c9tAqRDlXMKsebVTstRhPuv3hJpU=; b=MpVU+mj2Vzr/qj2xIV
	UENozVmFiwFtSW+9sy9CtR4+Y2xSAqflu/6S3VfPvKtnxWNGUyrjEba2c050L2MH
	KtSBmQlzka9RK/OK5eq733YikJgeOGsop65WzPV4gCUBB+oVJ9wC3ZjPibkixe/9
	kpMViD8vq372iE8WFXa8AWE4Y=
Received: from pan-u.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3H9lQz9lqE4q0Bg--.6535S2;
	Thu, 22 Oct 2026 16:54:40 +0800 (CST)
From: rppxj178543@163.com
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	fuhao@open-hieco.net,
	linux-kernel@vger.kernel.org,
	renpanpan <renpanpan@kylinos.cn>
Subject: [PATCH] ALSA: hda: Force MSI for Hygon H34M51A board
Date: Thu, 22 Oct 2026 16:54:38 +0800
Message-ID: <20261022085438.1315679-1-rppxj178543@163.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3H9lQz9lqE4q0Bg--.6535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWfGFy8XFWkJw43tFyUGFg_yoW8Ar43pF
	WYg39akFWvgFWjvan0gF48GFyfZF13GrsxG3909w47JanxZr1jqw4YyrW8JFW8Gr48CrWY
	qr1DKas7ZF45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjiihUUUUU=
X-CM-SenderInfo: huss5yirxykkqt6rljoofrz/xtbC6RAZGGrZz1CAtwAA3j
Message-ID-Hash: G7PU6RGA3XNMZNKSG6TAWNKVJL24SHWE
X-Message-ID-Hash: G7PU6RGA3XNMZNKSG6TAWNKVJL24SHWE
X-MailFrom: rppxj178543@163.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G7PU6RGA3XNMZNKSG6TAWNKVJL24SHWE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: renpanpan <renpanpan@kylinos.cn>

The Hygon HDA controller (PCI 1d94:14a9) has AZX_DCAPS_NO_MSI set in
the PCI ID table to use legacy INTx, as MSI may lose interrupts under
heavy load on some Hygon platforms (commit 41212ff3e4ed ("ALSA: hda:
Add support for Hygon family 18h model 5h HD-Audio")).

However, on the Kunlun H34M51A board (PCI subsystem 1d94:c950) the
INTx interrupt line is not wired.  /proc/interrupts shows zero count
for the HDA IRQ from boot, so the RIRB interrupt handler is never
called.  Without RIRB processing, azx_rirb_get_response() times out
after 1 s, switches to polling mode, and the resulting slow codec
communication delays card registration by ~20 s and breaks
unsolicited jack-detection event delivery.

Force MSI on for subsystem 1d94:c950 by adding it to msi_deny_list
with value 1.  The list is consulted in check_msi() before the
AZX_DCAPS_NO_MSI check, so H34M51A gets MSI enabled while other
Hygon platforms retain INTx.

Signed-off-by: renpanpan <renpanpan@kylinos.cn>
---
 sound/hda/controllers/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 24015c73a67f..fa36ed4c1153 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1669,6 +1669,7 @@ static const struct snd_pci_quirk msi_deny_list[] = {
 	SND_PCI_QUIRK(0x1179, 0xfb44, "Toshiba Satellite C870", 0), /* AMD Hudson */
 	SND_PCI_QUIRK(0x1849, 0x0888, "ASRock", 0), /* Athlon64 X2 + nvidia */
 	SND_PCI_QUIRK(0xa0a0, 0x0575, "Aopen MZ915-M", 0), /* ICH6 */
+	SND_PCI_QUIRK(0x1d94, 0xc950, "Hygon H34M51A", 1), /* INTx broken */
 	{}
 };
 
-- 
2.43.0

