Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37024C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:32:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8BA2087E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mKix7lft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8BA2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC37816D5;
	Tue,  5 Nov 2019 16:31:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC37816D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967950;
	bh=ey6RfUTYzgKiiUXd/J+YKFZFC6NyhjNVbpF8C1G/KG8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKix7lftTVBhicNLSMiAvAxY2Wnkuruu+AJs1vAmM0lAyTd5fe2Xc95sMj4dOLsRg
	 8Yf+vlY8KR+pVtsNC7u9MkQP4Wp3Ug5+wpjRLgglar0OXDsO5pO17RBxKeXGpDo/SP
	 SHMn8G5YsBAZ61pAyQocBdSO1NWCDyVAi2TTn7A0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC88FF8076C;
	Tue,  5 Nov 2019 16:19:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3179FF80638; Tue,  5 Nov 2019 16:19:23 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDF98F80611
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDF98F80611
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D533AB4F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:56 +0100
Message-Id: <20191105151856.10785-25-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 24/24] ALSA: docs: Remove snd_dma_pci_data()
	usage in documentation
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The macro will be removed soon later, so update the documentation to
reflect that as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index ba008ce28029..3a87311c125e 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -1383,7 +1383,7 @@ shows only the skeleton, how to build up the PCM interfaces.
               /* pre-allocation of buffers */
               /* NOTE: this may fail */
               snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-                                                    snd_dma_pci_data(chip->pci),
+                                                    &chip->pci->dev,
                                                     64*1024, 64*1024);
               return 0;
       }
@@ -1470,7 +1470,7 @@ buffer. For the pre-allocation, simply call the following:
 ::
 
   snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-                                        snd_dma_pci_data(chip->pci),
+                                        &chip->pci->dev,
                                         64*1024, 64*1024);
 
 It will allocate a buffer up to 64kB as default. Buffer management
@@ -3514,7 +3514,7 @@ bus).
 ::
 
   snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-                                        snd_dma_pci_data(pci), size, max);
+                                        &pci->dev, size, max);
 
 where ``size`` is the byte size to be pre-allocated and the ``max`` is
 the maximum size to be changed via the ``prealloc`` proc file. The
@@ -3700,7 +3700,7 @@ For creating the SG-buffer handler, call
 :c:func:`snd_pcm_lib_preallocate_pages()` or
 :c:func:`snd_pcm_lib_preallocate_pages_for_all()` with
 ``SNDRV_DMA_TYPE_DEV_SG`` in the PCM constructor like other PCI
-pre-allocator. You need to pass ``snd_dma_pci_data(pci)``, where pci is
+pre-allocator. You need to pass ``&pci->dev``, where pci is
 the :c:type:`struct pci_dev <pci_dev>` pointer of the chip as
 well.
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
