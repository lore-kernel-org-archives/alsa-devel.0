Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8617CC433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:11:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538A4610CC
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538A4610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BA5D1692;
	Fri,  9 Apr 2021 19:10:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BA5D1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617988279;
	bh=Psv+nPcO3zydYEmy3ta/kQ5UiqknTvYGEQN+PpJuLxI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLJD7r81o+aocrFlW+th0IgBAfodYpNgI0GarGXz+ggPDYDHusCXrLb9jwt042YTf
	 ssu9N0YfZUTzUVUL7TY0dHOgMb6W4mXT8DFrxc4gP1oAqSZY7C0cN31QxUPPMPWJ8n
	 U3JqTo+JkzIQLBrxIIcfsOObOZwl//icwzBO4yqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05BB0F80245;
	Fri,  9 Apr 2021 19:09:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2A76F8020B; Thu,  8 Apr 2021 14:47:43 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F26EF800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 14:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F26EF800BD
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGLZ31d7zzNttM;
 Thu,  8 Apr 2021 20:44:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:47:19 +0800
From: Chen Huang <chenhuang5@huawei.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
Subject: [PATCH -next] ALSA: virtio: use module_virtio_driver() to simplify
 the code
Date: Thu, 8 Apr 2021 12:54:29 +0000
Message-ID: <20210408125429.1158703-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 09 Apr 2021 19:09:35 +0200
Cc: alsa-devel@alsa-project.org, Chen Huang <chenhuang5@huawei.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

module_virtio_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 sound/virtio/virtio_card.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index ae9128063917..150ab3e37013 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -432,17 +432,7 @@ static struct virtio_driver virtsnd_driver = {
 #endif
 };
 
-static int __init init(void)
-{
-	return register_virtio_driver(&virtsnd_driver);
-}
-module_init(init);
-
-static void __exit fini(void)
-{
-	unregister_virtio_driver(&virtsnd_driver);
-}
-module_exit(fini);
+module_virtio_driver(virtsnd_driver);
 
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio sound card driver");
-- 
2.17.1

