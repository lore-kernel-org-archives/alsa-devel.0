Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A66C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jul 2022 14:44:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC19017F8;
	Thu, 21 Jul 2022 16:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC19017F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658414650;
	bh=/OyDrgbz3hO7dv2QxV24GvZuoa+m8SDw/R4QwX6KL+w=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DiSnPoRPjGDAoT4jAUK0qdZfn1MV4dmYRX4t532qmzMeTIYO8BDh78hkx56VPO7JZ
	 3lN8zo4rM4GsT8UIUFj3+nEG66IFw5ApSIe0wcsbEBcyWBnnEm0IxKv2EGibJu0pnE
	 fajI7mPkzghdAMrh5R2XXjt2je0RChPAQyX3IF3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48DFDF8047C;
	Thu, 21 Jul 2022 16:43:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABD47F80527; Thu, 21 Jul 2022 16:43:19 +0200 (CEST)
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
 by alsa1.perex.cz (Postfix) with ESMTP id A3FA5F80169
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2022 16:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3FA5F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.b="Q+O/D9sd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Z5PtN
 1kHcISuOf1nFu5ActQZEVYPQ2YKp1UhFggOWzA=; b=Q+O/D9sdJOsep9vbV7CcK
 PrM5StoS5rmdHEgwUjl1iXMA4QSYiZPEaFuNFNqRZrFRFPtfRwMxfxZuzZU2ch+b
 0BknbNNckpiJwIg8JHuxm2HUO3nxZiD7JpUCViRbnK+P6zgo/wRQXLYlUkBDAkkH
 v5nl6/SC2k51lSFvV9hbAU=
Received: from localhost.localdomain (unknown [124.16.139.61])
 by smtp9 (Coremail) with SMTP id NeRpCgC3Q9z8Zdli417TGw--.14730S2;
 Thu, 21 Jul 2022 22:43:10 +0800 (CST)
From: Liang He <windhl@126.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, windhl@126.com
Subject: [PATCH] ASoC: audio-graph-card: Add of_node_put() in fail path
Date: Thu, 21 Jul 2022 22:43:08 +0800
Message-Id: <20220721144308.1301587-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgC3Q9z8Zdli417TGw--.14730S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr48KF4kAr4rGr1xury5twb_yoWfWFcEya
 y8u39rXF48KrWIkrsxWay3Gw1I9F18WFyxCFWSgF17CayDKF1Sy3Z8Jr93Cr97u3y5CFWx
 W34DZ3yvvrWayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuHq73UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2h5FF1uwMcZ1OwAAsE
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

In asoc_simple_parse_dai(), we should call of_node_put() for the
reference returned by of_graph_get_port_parent() in fail path.

Fixes: ae30a694da4c ("ASoC: simple-card-utils: add asoc_simple_card_parse_dai()")
Signed-off-by: Liang He <windhl@126.com>
---
 sound/soc/generic/audio-graph-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 2b598af8feef..b327372f2e4a 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -158,8 +158,10 @@ static int asoc_simple_parse_dai(struct device_node *ep,
 	 *    if he unbinded CPU or Codec.
 	 */
 	ret = snd_soc_get_dai_name(&args, &dlc->dai_name);
-	if (ret < 0)
+	if (ret < 0) {
+		of_node_put(node);
 		return ret;
+	}
 
 	dlc->of_node = node;
 
-- 
2.25.1

