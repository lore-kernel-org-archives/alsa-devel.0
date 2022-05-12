Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60C0C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 07:49:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A0B71933;
	Thu, 12 May 2022 09:48:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A0B71933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652341750;
	bh=h2JHAfA9xLIxvqr/0tC7GfhBMbhPiB60is62rx6UF3o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XejZLByMdP2bjwEsNm/EtRe0btHF2BOh82skVuYIwXsyxw0O9TftB45GzLiP5NelF
	 vUh4lpUG5btsIBfYqvwULPAP1lVzOTMTJ80lUm56nYMzPMv654WtLyKYHVICyXiwPt
	 59++zAN/+VB5AoFP5Phq5fY1AaZiONYT8il3Zzd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C717F80245;
	Thu, 12 May 2022 09:48:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E4A2F80249; Thu, 12 May 2022 09:48:18 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11581F800BB
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 09:48:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11581F800BB
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzP2R54Q7zGpZS;
 Thu, 12 May 2022 15:45:19 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:48:08 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:48:08 +0800
From: Hui Tang <tanghui20@huawei.com>
To: <lgirdwood@gmail.com>
Subject: [PATCH -next v2 0/2] ASoC: codecs: Fix build error
Date: Thu, 12 May 2022 15:46:38 +0800
Message-ID: <20220512074640.75550-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
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

Changes in v2:
 * Add missing header files instead of adding dependencies.

Hui Tang (2):
  ASoC: max98396: Fix build error for implicit function declaration
  ASoC: tlv320adc3xxx: Fix build error for implicit function declaration

 sound/soc/codecs/max98396.c      | 1 +
 sound/soc/codecs/tlv320adc3xxx.c | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.17.1

