Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D9BC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 16:49:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9073F64F27
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 16:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9073F64F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E641177C;
	Tue,  2 Mar 2021 17:48:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E641177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614703754;
	bh=ynYxj0YE6Zj4GR6AwZfMhhKycdTyQsOJhTolatQ+on0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7x/6SjT53ryOFWcxhiUN1+kc/tpnMT6jiaomIFbhU5bVgRIS2ksKhK8+78s6FHjR
	 dG7CMW2XNcfFqUR1eK/zkALWv2YHeP9eOLBecvGNGDinGR/+WjQv/opjl40QSebfWi
	 IOd+o23woVyjLnWzLLXueObfHEpKdFncNdsBFlOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8EBCF80227;
	Tue,  2 Mar 2021 17:47:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B06E5F802CA; Tue,  2 Mar 2021 17:47:32 +0100 (CET)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 416A7F8025B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 17:47:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 416A7F8025B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="o4coRdXy"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id DCBFDA17A5;
 Tue,  2 Mar 2021 17:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=H/IqaTbkOtxU
 zfKUTf6SoEir9ZqTvVT/Ba9mrKSHQWE=; b=o4coRdXy3JzjWncC4ukYMhknt9hf
 JKqVYZXYtH1E6L4RBgjFckq4GivyGsJolCrxUvh5sK3OhjI1F9kb0C6iwwN2dwwZ
 NKh8vhsABvmA7kfcjxZo4pD2i0gpL8Opl/LZvMJyjTdlZfOClv20UenhH/SmAafe
 DqjHn5fxGP6izx1gQe3rQSYEfipjMD73pvunsHZwNlBZPm9qBe4TUe3JJeaOilWh
 HeAj+en3E7Dw0BmQDRAvhqS2BCCMoN8HrTAaPucNdW8foY1LF5FoegPA9FdoLfNj
 aQ5ONfs7k92rkc09jKpEN4slGdYb9+yzeNSLx+NHrqy2mIemqzJeiX6TgA==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v7 1/9] uapi: virtio_ids: add a sound device type ID from
 OASIS spec
Date: Tue, 2 Mar 2021 17:47:01 +0100
Message-ID: <20210302164709.3142702-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
References: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

The OASIS virtio spec defines a sound device type ID that is not
present in the header yet.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index bc1c0621f5ed..029a2e07a7f9 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -51,6 +51,7 @@
 #define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
 #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
 #define VIRTIO_ID_MEM			24 /* virtio mem */
+#define VIRTIO_ID_SOUND			25 /* virtio sound */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
-- 
2.30.1


