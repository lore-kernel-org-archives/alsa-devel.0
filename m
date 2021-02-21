Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9CC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 13:59:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AC164EF1
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 13:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AC164EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1E76825;
	Sun, 21 Feb 2021 14:58:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1E76825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613915937;
	bh=0Qgei7YJkVy6mCd+hxSbfqhpewpplHmYDQl9yQoOG1w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6fu4BN9haI4/P3R3Imav3OIFiNKw/WXsgApVggsmWw0xmFI9PNGQ+nbC4oZaAhvr
	 DD2Q+zvw+A/I6gRpJM6R6mHSXjvVL47TyK5YySCZSHdz46zGYT2c8XlcQppU6XtlAT
	 6cIpnhEHS8+Q+4h+ycq8Vrt3K8CllT8oYYDDjezo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D25DFF802CA;
	Sun, 21 Feb 2021 14:58:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02E37F802DB; Sun, 21 Feb 2021 14:58:03 +0100 (CET)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6427FF80167
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 14:57:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6427FF80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="uG9+E9I/"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id BD445A1116;
 Sun, 21 Feb 2021 14:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=JMWVu00sJKNa
 UzNO4ZqMeD8FYjdkJxYXTlplUlw+228=; b=uG9+E9I/d1bg/MLj7SPOUDoYPycj
 c/k9k8uOCRZt3M6oYlEzSXXED6u40Lb+c7OcsxEVY5NGLX6kYfJyKc1IRPN0RZKr
 wmV61OG2joo6ND3USkRSZY6bKPdF3vKKRaeNs9N93ExrxbbZ63tpHxmBVBzIAWSq
 xCf9/wV+gbxQXcf9t+OnOCL4jk7d/xAgrfu8HTlaPTKE36gr5TnODHfnnTTObuJO
 uCH1As/anVSuGxtapgRvh2NkxvJnuzLHAy0TWyf9LEcBp3jS8TKvlKtDquhK9/FD
 nLqVS9a+y5XAH8hU9+PMNGJZZgSO41d/TeKkS0xOB9poC/A/Vm6thatwYA==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v4 1/9] uapi: virtio_ids: add a sound device type ID from
 OASIS spec
Date: Sun, 21 Feb 2021 14:57:23 +0100
Message-ID: <20210221135731.51348-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221135731.51348-1-anton.yakovlev@opensynergy.com>
References: <20210221135731.51348-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
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
2.30.0


