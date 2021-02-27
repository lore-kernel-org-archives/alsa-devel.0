Return-Path: <SRS0=30w1=H5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1752C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Feb 2021 09:01:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A120564DB2
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Feb 2021 09:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A120564DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B94D167E;
	Sat, 27 Feb 2021 10:00:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B94D167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614416473;
	bh=Vo1QyLDmxddNhNH1zle+1XPI2y6TsdC1Re+oEE2Rz5o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pY7qC5Ubznj+LwyZ1uny6kigYmaO1smXbvx4KGhJufDdh5dcS+rEmgg1YmLBhKyPd
	 He8X8SW0tctzQ5/Y689L2wpJkuD6BvAW6OnOI74UPMNTAcryRs/6Jqn400Kkw2851Y
	 6uOIXWrWIUJE6WGpUrzCVtD+83zKb9jBk7rQgfgE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4B7FF8016D;
	Sat, 27 Feb 2021 10:00:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B93F0F801F5; Sat, 27 Feb 2021 10:00:21 +0100 (CET)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13B03F8010B
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2021 10:00:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13B03F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="UCgQhQCh"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 71525A1309;
 Sat, 27 Feb 2021 10:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=srmailgate02; bh=7vpHr467KLWtiBKRdCh16iYojISr5VNmABumd
 HAQ6Vg=; b=UCgQhQChQlo8imdrsVzR3egcCFqgEvFLOtySfSYzblem1MHgkyH5W
 IR885ePtHJhmWGp+XMTn16lZPpg5VYJWnOGkAjiFoxy8Ad+zRwyRUOsmGdgZ4C5m
 44V3aZxU6RqUJfoFevA6pN61DfRpG18rW40X00QD/dfnpxR6YZQBx7y+gQGUy0oi
 ZKu9AFY2RO7mlRAbUr9PerLJzsJP7SBLfDdAO+gh4OSiwaoELgtw0v/TtraWqZdd
 c8MtWZrAAsCw7b3H9YG5n7q1ltJIg9h0pVVK82UpLFXBj5U9ySL9Sj8WOx/qAhUQ
 OZxmsmNGjbf254gciL8c9NOWSQP8wMHYQ==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v6 0/9] ALSA: add virtio sound driver
Date: Sat, 27 Feb 2021 09:59:47 +0100
Message-ID: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

This series implements a driver part of the virtio sound device
specification v8 [1].

The driver supports PCM playback and capture substreams, jack and
channel map controls. A message-based transport is used to write/read
PCM frames to/from a device.

As a device part was used OpenSynergy proprietary implementation.

v6 changes:
 - Code readability improvements suggested by Takashi.
 - Added additional comments about PCM message lifetime.
 - Temporarily removed DEVICE_NEEDS_RESET device status handling.
   Some kind of assistance from the virtio bus/level is required. In turn, this
   requires a separate discussion of the possibility of implementing such
   handling for virtio devices whose configuration may change (which may require
   re-probing, like in case of the sound device).

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html


Anton Yakovlev (9):
  uapi: virtio_ids: add a sound device type ID from OASIS spec
  ALSA: virtio: add virtio sound driver
  ALSA: virtio: handling control messages
  ALSA: virtio: build PCM devices and substream hardware descriptors
  ALSA: virtio: handling control and I/O messages for the PCM device
  ALSA: virtio: PCM substream operators
  ALSA: virtio: introduce jack support
  ALSA: virtio: introduce PCM channel map support
  ALSA: virtio: introduce device suspend/resume support

 MAINTAINERS                     |   9 +
 include/uapi/linux/virtio_ids.h |   1 +
 include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 410 ++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 111 +++++++
 sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 310 ++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   |  78 +++++
 sound/virtio/virtio_jack.c      | 233 +++++++++++++++
 sound/virtio/virtio_pcm.c       | 498 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 118 ++++++++
 sound/virtio/virtio_pcm_msg.c   | 417 ++++++++++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 478 ++++++++++++++++++++++++++++++
 17 files changed, 3243 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_snd.h
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h
 create mode 100644 sound/virtio/virtio_jack.c
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h
 create mode 100644 sound/virtio/virtio_pcm_msg.c
 create mode 100644 sound/virtio/virtio_pcm_ops.c

-- 
2.30.1


