Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15BEC07E9D
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Sep 2022 06:08:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E009A15E5;
	Thu, 29 Sep 2022 08:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E009A15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664431733;
	bh=0p0LSNWenq9eFXMPdRXakDHUjRjHsPQbyq4CM11JAdA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K0CFo8kiQsrU7cdRCSo8zqDN9vziERGqoI/wBWbbcOvhhjbk5KAcloUzS3b2YIzA6
	 aAHk2Xs5GVUVkwNiTl4LLRmpNr5BbzkXOIB4q3aDFhDgHByahZ3TyhyUORXLP6uSUC
	 o5iC6vlK7e1w72OOleILdTmkL3deRNhdW60YQ8h8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F833F80549;
	Thu, 29 Sep 2022 08:06:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21CF6F8025E; Tue, 27 Sep 2022 15:37:14 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F647F80166
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 15:37:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F647F80166
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McLC42rhzzHtfM;
 Tue, 27 Sep 2022 21:32:16 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 21:37:03 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 21:37:02 +0800
From: Shang XiaoJing <shangxiaojing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ALSA: sb: Use DIV_ROUND_UP() instead of open-coding it
Date: Tue, 27 Sep 2022 22:11:10 +0800
Message-ID: <20220927141110.18033-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 29 Sep 2022 08:06:37 +0200
Cc: shangxiaojing@huawei.com
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

Use DIV_ROUND_UP() instead of open-coding it, which intents and makes
it more clear what is going on for the casual reviewer.

The Coccinelle references Commit e4d8aef21403 ("ALSA: usb: Use
DIV_ROUND_UP() instead of open-coding it").

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 sound/isa/sb/emu8000_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index f8d90a1e989b..c8afc4347c54 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -236,7 +236,7 @@ static int emu8k_pcm_open(struct snd_pcm_substream *subs)
 
 	/* use timer to update periods.. (specified in msec) */
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-				     (1000000 + HZ - 1) / HZ, UINT_MAX);
+				     DIV_ROUND_UP(1000000, HZ), UINT_MAX);
 
 	return 0;
 }
-- 
2.17.1

