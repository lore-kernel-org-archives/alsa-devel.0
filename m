Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 May 2022 12:16:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 783EA1A44;
	Wed, 11 May 2022 14:15:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 783EA1A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652271409;
	bh=2NApovftPwAfB+rBejsNPpkAf1WXu9iVke+I4c8kRnM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XxJM5MBjNesnMv+V6ewPOOdiz4MIgO68BL990sR2gt8thT+nE2wu4SeyYq2svzG/d
	 PqvWHmP+DMk8AXgDP4xVY1QGnHB5cGhCHPEY1XgHJbgaV7DspL+5srCkvhJk1s5u/k
	 Hth6X6yv8ykDYHlWDUYOQC76FXqMG+uP2FsYvbhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADFB4F80515;
	Wed, 11 May 2022 14:15:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3744F804B2; Wed, 11 May 2022 03:25:28 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 102F3F800BB
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2022 03:25:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 102F3F800BB
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kycb83lvKzGpl2;
 Wed, 11 May 2022 09:22:28 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:16 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:16 +0800
From: Hui Tang <tanghui20@huawei.com>
To: <lgirdwood@gmail.com>
Subject: [PATCH -next 0/2] ASoC: codecs: Fix build error
Date: Wed, 11 May 2022 09:23:46 +0800
Message-ID: <20220511012348.94288-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 11 May 2022 14:14:58 +0200
Cc: alsa-devel@alsa-project.org, steve@sk2.org, tanghui20@huawei.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, ricardw@axis.com,
 broonie@kernel.org, ryan.lee.analog@gmail.com
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

Fix two build error, as follows:

tanghui (2):
  ASoC: max98396: Fix build error for implicit function declaration
  ASoC: tlv320adc3xxx: Fix build error for implicit function declaration

 sound/soc/codecs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

