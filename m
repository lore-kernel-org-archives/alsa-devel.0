Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD837C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 09:45:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E6C520CA;
	Wed,  2 Mar 2022 10:44:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E6C520CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646214309;
	bh=Xs6VvHM/OmjELGzW4GEdMg801tRDhITkfXDOb4NK6Fc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W3T2kFtqs8V+sC5Y5EEidJ7rn00NjRKUhtgZJzDSvOafGKBQJ/1os+4gWfZs9fs0U
	 79gBNeVxyi9sO79Ws4zHGHQE7jvIYZbatLUnpepBN/HxHj9WA4Szyc38VWBfsHDdXy
	 xIxzuztAADzniDlvcjEG2uWMXYk/dt3JmnyM9i9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABED9F80171;
	Wed,  2 Mar 2022 10:44:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC192F80171; Wed,  2 Mar 2022 10:44:16 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ABABF80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 10:44:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ABABF80054
X-QQ-mid: bizesmtp77t1646214239t4q3lvu0
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 02 Mar 2022 17:43:53 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: xyySF+ktKzc8o0sxazVfL1OaxjVY3Ht/nzDo91W+cec1vfOJK2+P94HZr5Ta2
 2svAAD6EXCc6FpllvhLHSRkQZSWQLRbN9BXofmljew6Fqk71bOe0o3qhGINLhBHZLOKgs1f
 PItROfzgeQocrtvNjXK9FeMRFGC3aSm94bNhe0iuFpY8sC2+KvAzGFWUO4yCfBC78dknjp7
 7jzOGJavoBZNNGBaK1PLhZ/Eu9SgloLY/UD4fouNLDcV8+o0A0iLmwentlUbnJfTo4bG3Lr
 Z7ee8MZMuCuzdZlY4bTSFCuRSoeBiaM6FT+mJRTES3g73bXsFJ3GrtP/6IvpkJmqYiO58AX
 A/9Paf8C8yoApWoQcUjU/QlLxKUwVYZNRBWC4BpRAHvpac8vJWPu8YSWYYvNg==
X-QQ-GoodBg: 1
From: Meng Tang <tangmeng@uniontech.com>
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Subject: [PATCH] ASoC: hdac_hda: Avoid unexpected match when pcm_name is
 "Analog"
Date: Wed,  2 Mar 2022 17:43:51 +0800
Message-Id: <20220302094351.3487-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Cc: Meng Tang <tangmeng@uniontech.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

pcm name can be "Analog" and "Alt Analog", cpcm->name can be
"Analog Codec DAI" and "Alt Analog Codec DAI". When pcm_name
is "Analog", "Analog Codec DAI" and "Alt Analog Codec DAI" are
both satisfy the 'if (strstr(cpcm->name, pcm_name))' condition,
which may cause the returned cpcm to be "Alt Analog Codec DAI".

Even if we get the pcm name by id, and "Analog Codec DAI" goes
into the loop before "Alt Analog Codec DAI", but I still think
we'd better have multiple insurances against unexpected return
values. After, we can correctly return the expected result
even if other relevant places are changed.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/codecs/hdac_hda.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 667f3df239c7..a9f61c7e44ee 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -363,8 +363,13 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	}
 
 	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
-		if (strstr(cpcm->name, pcm_name))
+		if (strstr(cpcm->name, pcm_name)) {
+			if (strcmp(pcm_name, "Analog") == 0) {
+				if (strstr(cpcm->name, "Alt Analog"))
+					continue;
+			}
 			return cpcm;
+		}
 	}
 
 	dev_err(&hcodec->core.dev, "didn't find PCM for DAI %s\n", dai->name);
-- 
2.20.1



