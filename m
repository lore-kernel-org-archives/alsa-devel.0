Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1555C54EE9
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Sep 2022 12:26:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B46561655;
	Sat, 17 Sep 2022 14:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B46561655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663417573;
	bh=M+ulOPb12igsTMa9QZZ2ZASLR05lRM5799SfSbzhH0I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iPJMReuHu0NAXrbZPdKVbDrGVWvPa7qWSLCWlnkYvZUBX676J93On+MKvPyv3NSYL
	 Nl1FPfV0xEAu+7UydQOh/s0HS1i3Y/+SS8JHhPxW3NSTr7vTOlEYfMzEwujmN2CiqM
	 v9A3bTdEQLh+Iz4jns8chYmYcajlvJlhiihXLLjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7A92F8028D;
	Sat, 17 Sep 2022 14:25:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4704CF8028D; Sat, 17 Sep 2022 14:24:59 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E22DAF80249
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2022 14:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E22DAF80249
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MV95P692QzmV5w;
 Sat, 17 Sep 2022 20:20:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 20:24:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 20:24:47 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] ALSA: mts64: Switch to use list_for_each_entry()
 helper
Date: Sat, 17 Sep 2022 20:31:54 +0800
Message-ID: <20220917123155.1899689-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Cc: tiwai@suse.com
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

Use list_for_each_entry() helper instead of list_for_each() and
list_entry() to simplify code a bit. No functional change.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/drivers/mts64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index d3bc9e8c407d..746ac25a319e 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -752,7 +752,6 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 	struct mts64 *mts = card->private_data;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_substream *substream;
-	struct list_head *list;
 	int err;
 	
 	err = snd_rawmidi_new(card, CARD_NAME, 0, 
@@ -778,16 +777,16 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 
 	/* name substreams */
 	/* output */
-	list_for_each(list, 
-		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams) {
-		substream = list_entry(list, struct snd_rawmidi_substream, list);
+	list_for_each_entry(substream,
+			    &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams,
+			    list) {
 		sprintf(substream->name,
 			"Miditerminal %d", substream->number+1);
 	}
 	/* input */
-	list_for_each(list, 
-		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
-		substream = list_entry(list, struct snd_rawmidi_substream, list);
+	list_for_each_entry(substream,
+			    &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams,
+			    list) {
 		mts->midi_input_substream[substream->number] = substream;
 		switch(substream->number) {
 		case MTS64_SMPTE_SUBSTREAM:
-- 
2.25.1

