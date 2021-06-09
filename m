Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92430C48BCF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 23:23:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B04613DF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 23:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B04613DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6659416E1;
	Thu, 10 Jun 2021 01:22:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6659416E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623281014;
	bh=dKkauYZ11aH5MNg1/8EDrrvhq99F/T//A1gguE2d+S4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nZwJAVjN+HTOHMABSbzayRfFyUX5YAvJ/goIY1Igi+LHMm8urO+YlqTbPpngazBR+
	 94Foiq+c7Ox7KMEdSkuT9uLlBJ8HDH5FemeoPSp1oo3Mz4HGRA+jhnhpNFSm/cmoW9
	 PLeWebTXMbR0hCmpalmP3peuVXRUbWFQcT560a6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03BBFF80212;
	Thu, 10 Jun 2021 01:22:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A06C8F8026C; Thu, 10 Jun 2021 01:22:42 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C19EF800F4
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 01:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C19EF800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Bpxhg8qT"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="f2BLgrwD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 236665C011C;
 Wed,  9 Jun 2021 19:22:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 09 Jun 2021 19:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=cvSZLmkO6A3ujaBQvErecP5PeH
 exxUfhtONxM2n9GQA=; b=Bpxhg8qTb1fnz31lgSTYRrHh1W6gvN4uHkyEQhXwWx
 kIViz+F0qFw6HvZ6a6m0RpNVyW6EVK1PmFtvn7xCrcfxdx8lnVv9sq+Zqd7hnRbl
 5HUCmc7J+rWBNWMDVI0kIzwMg+QeIxE2r7G0bEuVrZJ1Wh1gZ8o3MltedSltb57a
 kgMYk7hERiD+ue8D6FAYV5JeUS7lAKRI6zIyZ82m82+3wnvIaoJM5shBD7OyJ3PK
 oTzWkTiriTept1rObqkY8ukygovKV85IwMv1gD1VuC0i4nifajeFV7jgzSsw1jt9
 f2pkIMb7SQfsbkcvLt/0Qq5d9kZbLF0HmrMt82tccL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cvSZLmkO6A3ujaBQv
 ErecP5PeHexxUfhtONxM2n9GQA=; b=f2BLgrwDmNz1/MhaLA5/AmXY2Y/4nUNmO
 H9eCi3yQEg1OSAVNK9pSRN6bHm+yoKdtJEhpxO0VFc2xNuBmzDTtscQ2Kml7T2wa
 +y3keBT+kMj29qo4VHtUyfT3voyPtZpwywahE7LOUu2wWJbYgksUtgFO4nlm3oUc
 Mu2cwj/jPKK/K2NOX+/r74vZ6eF4riGkenaVh5lmroOh6IlLNTqjWnp+vaDMLHo8
 FXYiJQ/06PySzrVr69gyBMKCv53Wxsh2eqnoRUOhjKA8tZfy947l+Ycaq+zv3dMV
 boKg/BakaRZzBcMRLxsNHpKpJRpjXTBEFYyBYKHAyQcaEP7FiMgsg==
X-ME-Sender: <xms:O03BYBlN17yGY0iW7gg4IgaBieQD1wQvnaMpwmhyC4DoyAaR27BB9Q>
 <xme:O03BYM1l8t9GUOZk_QNdLgOCcstMbhbM7z77086dPcQr3WrYkhzIpo8OE6rNkA4Pp
 V24teTKn709ZweAWhk>
X-ME-Received: <xmr:O03BYHreB7jdA41NKZGjX6iVbYAFrwYiFvsMS4SleBPvjVUKuBGvIqB780NJF2duvydEJ4VM5kN6tbcPAZhSAUJtY7Htnfi_GDfwdjDw6MGDBFpqwZh2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduvddgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteeiuefhjeekke
 efheetieekvdegfefhgffgvdeiheehhfehiedvhffgjeejuddunecuffhomhgrihhnpehk
 vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:O03BYBnClpaHHqYQdje4qUhxlOlf4WLvJmXpMVvAwnwnyIjbSI8f4w>
 <xmx:O03BYP3e4mkXKBw7pGzBrMSq96YYb5k_I8wgZqQ2_-61MzP3sbEnAg>
 <xmx:O03BYAvcEmKfn0ItLAiZyA_3CQgFwbtreSahbVZmqjyqDePI93z7ng>
 <xmx:PE3BYI-X8LsxnxmmBgXczriMOcrICKR87rhPfcPCqEcM4lL4a0pJPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 19:22:34 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 0/3] ALSA: pcm: add snd_pcm_period_elapsed() variant
 without acquiring lock of PCM substream 
Date: Thu, 10 Jun 2021 08:22:27 +0900
Message-Id: <20210609232230.5963-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

This patchset is revised version of my previous one:
 * https://lore.kernel.org/alsa-devel/20210609143145.146680-1-o-takashi@sakamocchi.jp/

All of drivers in ALSA firewire stack have two chances to process
isochronous packets of any isochronous context; in software IRQ context
for 1394 OHCI, and in process context of ALSA PCM application.

In the process context, callbacks of .pointer and .ack are utilized. The
callbacks are done by ALSA PCM core under acquiring lock of PCM substream,

In design of ALSA PCM core, call of snd_pcm_period_elapsed() is used for
drivers to awaken user processes from waiting for available frames. The
function voluntarily acquires lock of PCM substream, therefore it is not
called in the process context since it causes dead lock. As a workaround
to avoid the dead lock, all of drivers in ALSA firewire stack use workqueue
to delegate the call.

This patchset is my attempt for the issue. A variant of 
'snd_pcm_period_elapsed()' without lock acquisition is going to be added,
named 'snd_pcm_period_elapsed_under_stream_lock()'. The call is available
in callbacks of .pointer and .ack of snd_pcm_ops structure.

Changes from v2:
 * delete context section from kernel API documentation

Takashi Sakamoto (3):
  ALSA: pcm: add snd_pcm_period_elapsed() variant without acquiring lock
    of PCM substream
  ALSA: firewire-lib: operate for period elapse event in process context
  ALSA: firewire-lib: obsolete workqueue for period update

 include/sound/pcm.h           |  1 +
 sound/core/pcm_lib.c          | 64 +++++++++++++++++++++++++++--------
 sound/firewire/amdtp-stream.c | 46 ++++++++-----------------
 sound/firewire/amdtp-stream.h |  1 -
 4 files changed, 64 insertions(+), 48 deletions(-)

-- 
2.27.0

