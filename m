Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DE8C7EE29
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 14:49:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31536826;
	Fri,  9 Jun 2023 16:48:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31536826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686322162;
	bh=yEt5u7RAWpVX0h+9AfKAS+uofz2MERudoUKsWZeqlDE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ct0RXxW2Gxko6/5q7hSUlcAzEPammsIGgbX6Ia9z+Z+rFuCIJPJ1PRh8DUWf8hVyf
	 B8deVgdmdLY6rkEJjoQkq7lXwFMHWdCECFIekAK+RsBR7iw1ZAHglx/i9HM3xeVitP
	 J5relOhTVLpNYKZnAr7kYE7vj8jVY2IKP+0vu84w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60527F8058C; Fri,  9 Jun 2023 16:47:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A6C5F80588;
	Fri,  9 Jun 2023 16:47:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8831DF80199; Wed,  7 Jun 2023 11:25:50 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BC69F80130
	for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2023 11:25:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BC69F80130
Received: from loongson.cn (unknown [223.106.25.146])
	by gateway (Coremail) with SMTP id _____8Bx7eo3TIBkSRcAAA--.330S3;
	Wed, 07 Jun 2023 17:21:59 +0800 (CST)
Received: from localhost.localdomain (unknown [223.106.25.146])
	by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxNeQ2TIBkvzcEAA--.14996S2;
	Wed, 07 Jun 2023 17:21:58 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: tiwai@suse.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	perex@perex.cz,
	chenhuacai@loongson.cn,
	alsa-devel@alsa-project.org,
	loongarch@lists.linux.dev,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH RESEND v3 0/4] Add Loongson HD Audio support
Date: Wed,  7 Jun 2023 17:21:48 +0800
Message-Id: <cover.1686128807.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeQ2TIBkvzcEAA--.14996S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurykCFWrCF1DKw4xur4DGFX_yoWfKrb_A3
	yIqFWkuryUC3ZrAayIvr4vkrZxXayjv34UK3Z3tr48JanayrsxKrWDCry3ur1xWFn5Jry5
	Xr1vgF4Fyr12vosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8AHUDUUUUU==
X-MailFrom: siyanteng@loongson.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: X2CI74KPF5XCM7HNTF47575ZUOROFPPM
X-Message-ID-Hash: X2CI74KPF5XCM7HNTF47575ZUOROFPPM
X-Mailman-Approved-At: Fri, 09 Jun 2023 14:46:45 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X2CI74KPF5XCM7HNTF47575ZUOROFPPM/>
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
 include/sound/hdaudio.h     |  2 ++
 sound/hda/hdac_controller.c |  5 ++++-
 sound/hda/hdac_device.c     |  1 +
 sound/hda/hdac_stream.c     |  6 +++++-
 sound/pci/hda/hda_intel.c   | 20 ++++++++++++++++++++
 sound/pci/hda/patch_hdmi.c  |  1 +
 7 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.31.4

