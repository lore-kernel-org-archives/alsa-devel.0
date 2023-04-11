Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1606AC77B6E
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Apr 2023 05:29:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7B6BEBB;
	Wed, 12 Apr 2023 07:28:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7B6BEBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681277361;
	bh=tbse1zj+PqTioGJ8/4iC1nQ5Re6psjdnzCCuYOs93gI=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RK5ulZMLCJ1Lob2UaYdyXQuYqvEtEOVf7atgZFaoU9dKWhw1RVlUQi2L2CaEPDfkW
	 uNZhCwbDqz8cLzPVwboMyrOsdJM6ctiuopZfWyc04oOvn4NRhh/rjE9h+QxD5DNeSb
	 5zm3/64EfsRYakkrarstX7KghLPHZoXJAH52hZss=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DF2CF80568;
	Wed, 12 Apr 2023 07:26:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8AF43F8032B; Tue, 11 Apr 2023 19:09:58 +0200 (CEST)
Received: from hust.edu.cn (unknown [202.114.0.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0F35F80149
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2023 19:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0F35F80149
Received: from localhost.localdomain ([172.16.0.254])
	(user=lyre@hust.edu.cn mech=LOGIN bits=0)
	by mx1.hust.edu.cn  with ESMTP id 33BH9DX4005030-33BH9DX5005030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 12 Apr 2023 01:09:30 +0800
From: Ying Liu <lyre@hust.edu.cn>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: tas5720: add missing unwind goto in tas5720_codec_probe
Date: Wed, 12 Apr 2023 01:09:12 +0800
Message-Id: <20230411170912.1939906-1-lyre@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lyre@hust.edu.cn
X-MailFrom: lyre@hust.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: G6L2XSPMAVEQ7CAVUAYWWX4HEOYSVE44
X-Message-ID-Hash: G6L2XSPMAVEQ7CAVUAYWWX4HEOYSVE44
X-Mailman-Approved-At: Wed, 12 Apr 2023 05:23:30 +0000
CC: HUST OS Kernel Contribution <hust-os-kernel-patches@googlegroups.com>,
 Ying Liu <lyre@hust.edu.cn>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G6L2XSPMAVEQ7CAVUAYWWX4HEOYSVE44/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Smatch complains that missing unwind goto in tas5720_codec_probe.

When tas5720 has an invalid devtype, it is expected to invoke
regulator_bulk_disable to handle the failure. But the default
option return an error code directly. Fix it by reusing the
probe_fail label.

Signed-off-by: Ying Liu <lyre@hust.edu.cn>
---
The issue is found by static analysis and the patch remains untested.
---
 sound/soc/codecs/tas5720.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index de6d01c8fdd3..4d27b60bd804 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -339,7 +339,8 @@ static int tas5720_codec_probe(struct snd_soc_component *component)
 		break;
 	default:
 		dev_err(component->dev, "unexpected private driver data\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto probe_fail;
 	}
 
 	if (device_id != expected_device_id)
-- 
2.40.0

