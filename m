Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE68C7EE2E
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:21:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B1AF82C;
	Wed,  7 Jun 2023 11:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B1AF82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686129679;
	bh=+z2zwMmJRUedPfuLFdIpbJEdDDjNhoncUxLejQ2z9Zs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eTh+2wjSTs/4gcMqn0WbHEgYsuhudltc9G+ISCuqWJfFe82xARxD9XY4rIV4pA1IZ
	 iF0HkZgzzLS994TRPpxaB1K7mVjzdOYfdhC3odu9qKagK5KnSMSIev04eDlCWe5n1S
	 Qgh521uVFXEeiRVl220oiydR8BEUX866pCbdy4y4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40F8DF805BB; Wed,  7 Jun 2023 11:18:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A149F805BB;
	Wed,  7 Jun 2023 11:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A65FEF80494; Wed,  7 Jun 2023 10:51:32 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by alsa1.perex.cz (Postfix) with ESMTP id CAC0BF80155
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 10:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAC0BF80155
Received: from loongson.cn (unknown [223.106.25.146])
	by gateway (Coremail) with SMTP id _____8BxLusIRYBkmxQAAA--.351S3;
	Wed, 07 Jun 2023 16:51:20 +0800 (CST)
Received: from localhost.localdomain (unknown [223.106.25.146])
	by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxXMoGRYBkGikEAA--.6577S2;
	Wed, 07 Jun 2023 16:51:19 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: tiwai@suse.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	perex@perex.cz,
	chenhuacai@loongson.cn,
	alsa-devel@alsa-project.org,
	loongarch@lists.linux.dev,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 0/4] Add Loongson HD Audio support
Date: Wed,  7 Jun 2023 16:51:01 +0800
Message-Id: <cover.1686125797.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXMoGRYBkGikEAA--.6577S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurykCFWrCF1DKw4xur4DGFX_yoWfKrc_A3
	yIqFWkuFyUu3ZrAayIvr4vkrZxXayjv34UK3Zaqr48JanayrsxKrZrCry3ur1xWFn5Jry5
	Xr1vgF4Fyr12vosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-MailFrom: siyanteng@loongson.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: AB7T4F7MZZIU3CXWSEF3RUPNVIOLLTYK
X-Message-ID-Hash: AB7T4F7MZZIU3CXWSEF3RUPNVIOLLTYK
X-Mailman-Approved-At: Wed, 07 Jun 2023 09:18:51 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AB7T4F7MZZIU3CXWSEF3RUPNVIOLLTYK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

v3:
* Adding some comments.
* Seting polling_mode flag.

v2:
* Handling with two new flags added to struct hdac_bus.

v1:
* The Loongson HDA controller is compatible with High Definition Audio
  Specification Revision 1.0a.
  See <https://loongson.github.io/LoongArch-Documentation/Loongson-
  7A1000-usermanual-EN.html#hda-controller>

Yanteng Si (4):
  ALSA: hda: Add Loongson LS7A HD-Audio support
  ALSA: hda: Using polling mode for loongson controller by default
  ALSA: hda: Workaround for SDnCTL register on loongson
  ALSA: hda/intel: Workaround for WALLCLK register for loongson
    controller

 include/linux/pci_ids.h     |  3 +++
 include/sound/hdaudio.h     |  3 +++
 sound/hda/hdac_controller.c |  5 ++++-
 sound/hda/hdac_device.c     |  1 +
 sound/hda/hdac_stream.c     |  6 +++++-
 sound/pci/hda/hda_intel.c   | 20 ++++++++++++++++++++
 sound/pci/hda/patch_hdmi.c  |  1 +
 7 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.31.4

